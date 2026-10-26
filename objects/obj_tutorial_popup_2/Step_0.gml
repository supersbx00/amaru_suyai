push = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_select);
image_speed = 0;

if (!tutorial_popUp)
{
    tutorial_popUp = 1;
    instance_deactivate_all(true);
}

if (push)
{
    count += 1;
    
    if (count <= 2)
        valor_popUp = valor[count];
}

if (count > 2)
{
    instance_activate_all();
    global.pause = 0;
    instance_destroy();
}

if (valor_popUp == "inventario")
{
    if (gamepad_is_connected(0))
        sprite_index = spr_popup_inventario_xbox;
    else
        sprite_index = spr_popup_inventario;
}

if (valor_popUp == "recetas")
{
    if (gamepad_is_connected(0))
        sprite_index = spr_popup_recetas_xbox;
    else
        sprite_index = spr_popup_recetas;
}

if (valor_popUp == "cartas")
{
    if (gamepad_is_connected(0))
        sprite_index = spr_popup_cartas_xbox;
    else
        sprite_index = spr_popup_cartas;
}

x = __view_get(0, 0) + (__view_get(2, 0) / 2);
y = __view_get(1, 0) + (__view_get(3, 0) / 2);
depth = -1;
