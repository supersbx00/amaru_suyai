// Movimiento del enemigo en batalla: destinos al azar en su mitad de la arena,
// a veces a la altura de Amaru, con pausas cortas y amagues. Más suave en el tutorial.
// Con menos de la mitad de vida es más rápido; a veces esquiva los ataques de Amaru y Suyai;
// mientras apunta va a la altura de su objetivo y mientras avisa o dispara se queda quieto (scr_enemigo_ataque_fases).
#macro ENEMIGO_ZONA_X0 720
#macro ENEMIGO_ZONA_X1 1216
#macro ENEMIGO_ZONA_Y0 304
#macro ENEMIGO_ZONA_Y1 768

function scr_enemigo_mover() {
var zona_x0 = ENEMIGO_ZONA_X0;
var zona_x1 = ENEMIGO_ZONA_X1;
var zona_y0 = ENEMIGO_ZONA_Y0;
var zona_y1 = ENEMIGO_ZONA_Y1;
var tutorial = instance_exists(obj_control_tutorial) && obj_control_tutorial.paso < 25;
var agresivo = scr_enemigo_agresivo();

// Avisando o disparando: quieto
if (ataque_fase == "avisar" || ataque_fase == "disparando")
{
    hspd = 0;
    vspd = 0;
    
    if (sprite_index == spr_correr)
        sprite_index = spr_parado;
    
    return;
}

// Apuntando: va derecho al destino que fijó scr_enemigo_ataque_fases, sin pausas ni amagues
if (ataque_fase == "apuntar")
{
    var d = point_distance(phy_position_x, phy_position_y, mov_dest_x, mov_dest_y);
    
    if (d <= mov_vel)
    {
        phy_position_x = mov_dest_x;
        phy_position_y = mov_dest_y;
        hspd = 0;
        vspd = 0;
        return;
    }
    
    var da = point_direction(phy_position_x, phy_position_y, mov_dest_x, mov_dest_y);
    hspd = lengthdir_x(mov_vel, da);
    vspd = lengthdir_y(mov_vel, da);
    phy_position_x += hspd;
    phy_position_y += vspd;
    return;
}

if (!tutorial && scr_batalla_esquivar("player1", zona_y0, zona_y1))
    mov_pausa = 0;

if (mov_pausa > 0)
{
    mov_pausa -= 1;
    hspd = 0;
    vspd = 0;
    
    if (sprite_index == spr_correr)
        sprite_index = spr_parado;
    
    return;
}

var dist = point_distance(phy_position_x, phy_position_y, mov_dest_x, mov_dest_y);

// Amague: frena y sale hacia el lado contrario
if (!tutorial && dist > mov_vel && irandom(89) == 0)
{
    mov_dest_x = clamp(phy_position_x - (mov_dest_x - phy_position_x), zona_x0, zona_x1);
    mov_dest_y = clamp(phy_position_y - (mov_dest_y - phy_position_y), zona_y0, zona_y1);
    mov_pausa = 4;
    return;
}

if (dist <= mov_vel)
{
    phy_position_x = mov_dest_x;
    phy_position_y = mov_dest_y;
    
    // Destino nuevo: 1 de cada 3 a la altura de Amaru (fuera del tutorial)
    mov_dest_x = random_range(zona_x0, zona_x1);
    
    if (!tutorial && instance_exists(obj_player_battle) && irandom(2) == 0)
        mov_dest_y = obj_player_battle.y + random_range(-24, 24);
    else
        mov_dest_y = random_range(zona_y0, zona_y1);
    
    mov_dest_y = clamp(mov_dest_y, zona_y0, zona_y1);
    
    if (tutorial)
        mov_vel = random_range(4, 5.5);
    else if (agresivo)
        mov_vel = random_range(6, 10);
    else
        mov_vel = random_range(4.5, 8);
    
    mov_pausa = agresivo ? choose(0, 0, 4, 8, 12) : choose(0, 0, 6, 12, 24);
    hspd = 0;
    vspd = 0;
    return;
}

var dir = point_direction(phy_position_x, phy_position_y, mov_dest_x, mov_dest_y);
hspd = lengthdir_x(mov_vel, dir);
vspd = lengthdir_y(mov_vel, dir);
phy_position_x += hspd;
phy_position_y += vspd;
}

// Esquiva: si un ataque del rival viene en línea (a menos de 260 px y con menos de 40 px de altura de diferencia),
// se decide una sola vez por ataque, con 35 % de probabilidad, apartarse ~90 px hacia arriba o abajo a velocidad 10.
// Lo usan los enemigos (rival "player1") y el compañero con IA (rival "enemy"). Devuelve 1 si empezó a esquivar.
#macro ESQUIVA_PROB 35
#macro ESQUIVA_DIST 260

function scr_batalla_esquivar(rival, zona_y0, zona_y1) {
var yo = id;
var amenaza = noone;

with (obj_bala)
{
    if (creador == rival && amenaza == noone && scr_batalla_viene_hacia(yo))
        amenaza = id;
}

with (obj_especial)
{
    if (creador == rival && amenaza == noone && scr_batalla_viene_hacia(yo))
        amenaza = id;
}

if (amenaza == noone)
    return 0;

for (var i = 0; i < array_length(esquivados); i++)
{
    if (esquivados[i] == amenaza)
        return 0;
}

array_push(esquivados, amenaza);

if (array_length(esquivados) > 8)
    array_delete(esquivados, 0, 1);

if (irandom(99) >= ESQUIVA_PROB)
    return 0;

// Hacia el lado con más espacio, salvo que esté muy cerca de un borde
var lado = choose(-1, 1);

if (phy_position_y - 90 < zona_y0)
    lado = 1;
else if (phy_position_y + 90 > zona_y1)
    lado = -1;

mov_dest_x = phy_position_x;
mov_dest_y = clamp(phy_position_y + (lado * 90), zona_y0, zona_y1);
mov_vel = 10;
return 1;
}

// (Llamada dentro de un proyectil) ¿viaja hacia "quien", cerca y a su altura?
function scr_batalla_viene_hacia(quien) {
if (!variable_instance_exists(id, "hspd"))
    return 0;

var dx = quien.x - x;

if (abs(quien.y - y) >= 40 || abs(dx) >= ESQUIVA_DIST)
    return 0;

return (sign(dx) == sign(hspd) && hspd != 0);
}
