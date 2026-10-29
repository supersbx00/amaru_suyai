// Avance real desde el Step anterior, con la física ya resuelta (la pared devuelve a Amaru después del += hspd)
var avance = point_distance(x, y, choque_x, choque_y);
choque_x = x;
choque_y = y;

if (enable_battle == 1 || enable_player == 1)
{
    enable_player = global.enable_player;
    enable_battle = global.enable_battle;
}

if (instance_number(obj_enemigo_normal) == 0)
{
    enable_battle = 0;
    enable_player = 0;
}

// Al comenzar el tutorial (pasos 1-2) Amaru no puede hacer nada hasta que aparece Wanku
var inicio_tutorial = instance_exists(obj_control_tutorial) && obj_control_tutorial.tutorialOn && obj_control_tutorial.paso <= 2;

if ((instance_number(obj_dialogo) > 0 || instance_number(obj_info) > 0) || global.transicion == 1 || global.cinematica == 1 || enable_battle == 1 || inicio_tutorial)
{
    enable_player = 1;
    hspd = 0;
    vspd = 0;
    image_speed = 0;
}
else
{
    enable_player = 0;
}

if (enable_player == 0 && enable_battle == 0)
{
    // Cambio de personaje con Tab o botón Y (el clic sobre el acompañante lo maneja scr_amaru_clic)
    if (!global.pause && (keyboard_check_pressed(vk_tab) || gamepad_button_check_pressed(0, gp_face4)))
        scr_cambiar_personaje();
    
    scr_amaru_clic();
    script_execute(state);
}
else
{
    // Diálogo, cinemática o batalla: se olvida el destino del clic
    destino_activo = 0;
}

depth = -y;

if (instance_exists(obj_control_tutorial))
{
    if (obj_control_tutorial.paso > 2 || !obj_control_tutorial.tutorialOn)
    {
        phy_position_x += hspd;
        phy_position_y += vspd;
        enable_player = 0;
    }
    else
    {
        enable_player = 1;
    }
}
else
{
    phy_position_x += hspd;
    phy_position_y += vspd;
}

array_item[0] = phy_position_x;
array_item[1] = phy_position_y;
array_item[2] = room;
ds_list_insert(obj_game.escena_grabada, 0, array_item);

// Si intenta moverse pero un límite no lo deja avanzar, se muestra parado
if ((hspd != 0 || vspd != 0) && avance < 1)
    choque_frames += 1;
else
    choque_frames = 0;

if ((hspd == 0 && vspd == 0) || choque_frames >= 2)
{
    if (sprite_index == spr_amaru_walk_rightDown && image_xscale == 1)
        sprite_index = spr_amaru_stand_rightDown;
    else if (sprite_index == spr_amaru_walk_rightTop && image_xscale == 1)
        sprite_index = spr_amaru_stand_rightTop;
    else if (sprite_index == spr_amaru_walk_rightTop && image_xscale == -1)
        sprite_index = spr_amaru_stand_rightTop;
    else if (sprite_index == spr_amaru_walk_rightDown && image_xscale == -1)
        sprite_index = spr_amaru_stand_rightDown;
    
    if (choque_frames >= 2)
        image_speed = 0;
}

if (load == 1)
{
    script_execute(scr_cargar_posicion);
    load = 0;
    obj_game.load = 0;
}
