if (!instance_exists(obj_player))
    exit;

if (global.cambio_destello > 0)
    global.cambio_destello -= 1;

var jx = obj_player.x;
var jy = obj_player.y;

// Grabar el camino del jugador (solo cuando se movió)
var ultimo = rastro[| 0];

if (point_distance(jx, jy, ultimo[0], ultimo[1]) >= 2)
    ds_list_insert(rastro, 0, [jx, jy]);

// Punto a distancia_rastro px por el camino, desde el jugador hacia atrás
var meta_x = x;
var meta_y = y;
var acum = 0;
var ax = jx;
var ay = jy;

for (var i = 0; i < ds_list_size(rastro); i++)
{
    var p = rastro[| i];
    var d = point_distance(ax, ay, p[0], p[1]);
    
    if (acum + d >= distancia_rastro && d > 0)
    {
        var t = (distancia_rastro - acum) / d;
        meta_x = lerp(ax, p[0], t);
        meta_y = lerp(ay, p[1], t);
        
        // Lo que queda más atrás ya no sirve
        while (ds_list_size(rastro) > i + 2)
            ds_list_delete(rastro, ds_list_size(rastro) - 1);
        
        break;
    }
    
    acum += d;
    ax = p[0];
    ay = p[1];
}

// Si el jugador se devolvió hacia el acompañante, este se queda quieto
if (point_distance(meta_x, meta_y, jx, jy) < distancia_minima)
{
    meta_x = x;
    meta_y = y;
}

var dist = point_distance(x, y, meta_x, meta_y);
var mx = 0;
var my = 0;

if (dist > 200)
{
    // Muy lejos (cambio de sala o de personaje): reaparece en su lugar
    x = meta_x;
    y = meta_y;
}
else if (dist > 0.5)
{
    var paso = min(dist, velocidad_max);
    var dir = point_direction(x, y, meta_x, meta_y);
    mx = lengthdir_x(paso, dir);
    my = lengthdir_y(paso, dir);
    x += mx;
    y += my;
}

// Animación según la diagonal en que se mueve (como scr_player_move)
if (abs(mx) > 0.3 || abs(my) > 0.3)
{
    if (my >= 0)
    {
        sprite_index = spr_amaru_walk_rightDown;
        image_xscale = (mx >= 0) ? 1 : -1;
    }
    else
    {
        sprite_index = spr_amaru_walk_rightTop;
        image_xscale = (mx >= 0) ? 1 : -1;
    }
    
    image_speed = 0.3;
}
else if (sprite_index == spr_amaru_walk_rightDown)
{
    sprite_index = spr_amaru_stand_rightDown;
}
else if (sprite_index == spr_amaru_walk_rightTop)
{
    sprite_index = spr_amaru_stand_rightTop;
}

depth = -y;

// Ícono de cambio: visible con el cursor sobre el acompañante o sobre el ícono, si el jugador puede moverse
icono_x = x;
icono_y = y - 80;
var puede = obj_player.enable_player == 0 && obj_player.enable_battle == 0 && !global.pause && cursor_sprite != -1;
var sobre = position_meeting(mouse_x, mouse_y, id) || point_distance(mouse_x, mouse_y, icono_x, icono_y) <= icono_radio;
icono_visible = (puede && sobre) || icono_presionado > 0;

if (icono_visible)
    icono_frame = (icono_frame + 0.4) mod 12;
else
    icono_frame = 0;

// Clic en el ícono (lo marca scr_amaru_clic): se ve presionado unos frames y luego se cambia
if (icono_presionado > 0)
{
    icono_presionado -= 1;
    
    if (icono_presionado == 0)
        scr_cambiar_personaje();
}
