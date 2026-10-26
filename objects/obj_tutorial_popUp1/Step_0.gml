push = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_select);
image_speed = 0;

if (!tutorial_popUp && global.pause == 3)
    tutorial_popUp = 1;

if (push)
{
    count += 1;
    
    if (count <= 7)
        valor_popUp = valor[count];
}

if (count > 7)
{
    instance_activate_all();
    global.pause = 0;
    instance_destroy();
}

if (valor_popUp == "atacar")
{
    if (gamepad_is_connected(0))
        sprite_index = spr_popUp_atacar_xbox;
    else
        sprite_index = spr_popUp_atacar;
}

if (valor_popUp == "recargar")
{
    if (gamepad_is_connected(0))
        sprite_index = spr_popUp_recargar_xbox;
    else
        sprite_index = spr_popUp_recargar;
}

if (valor_popUp == "cardbreak")
{
    if (gamepad_is_connected(0))
        sprite_index = spr_popUp_cardBreak_xbox;
    else
        sprite_index = spr_popUp_cardBreak;
}

if (valor_popUp == "null card")
{
    if (gamepad_is_connected(0))
        sprite_index = spr_popUp_nullCard_xbox;
    else
        sprite_index = spr_popUp_nullCard;
}

if (valor_popUp == "rotar mazo")
{
    if (gamepad_is_connected(0))
        sprite_index = spr_popUp_rotarMazo_xbox;
    else
        sprite_index = spr_popUp_rotarMazo;
}

if (valor_popUp == "curar")
    sprite_index = spr_popUp_curar;

if (valor_popUp == "combo")
    sprite_index = spr_popUp_Combo;

if (valor_popUp == "orbe")
{
    if (gamepad_is_connected(0))
        sprite_index = spr_popup_ancestral_xbox;
    else
        sprite_index = spr_popup_ancestral;
}

x = __view_get(0, 0) + (__view_get(2, 0) / 2);
y = __view_get(1, 0) + (__view_get(3, 0) / 2);
