// Movimiento del enemigo en batalla: destinos al azar en su mitad de la arena,
// a veces a la altura de Amaru, con pausas cortas y amagues. Más suave en el tutorial.
function scr_enemigo_mover() {
var zona_x0 = 720;
var zona_x1 = 1216;
var zona_y0 = 304;
var zona_y1 = 768;
var tutorial = instance_exists(obj_control_tutorial) && obj_control_tutorial.paso < 25;

if (mov_pausa > 0)
{
    mov_pausa -= 1;
    hspd = 0;
    vspd = 0;
    
    if (sprite_index == spr_enemigo_battle_run)
        sprite_index = spr_enemigo_battle_stand;
    
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
    else
        mov_vel = random_range(4.5, 8);
    
    mov_pausa = choose(0, 0, 6, 12, 24);
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
