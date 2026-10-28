// Clic sobre el ícono o Back avanzan la ayuda, solo tras la espera de cada página (lectura directa: obj_game queda desactivado mientras la ayuda está abierta)
var px = camera_get_view_x(view_camera[0]) + 660;
var py = camera_get_view_y(view_camera[0]) + 368;
push = scr_ayuda_puede_avanzar(scr_ayuda_icono_x(sprite_index, px), scr_ayuda_icono_y(sprite_index, py));
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
    {
        valor_popUp = valor[count];
        scr_ayuda_espera_reiniciar();
    }
}

if (count > 2)
{
    instance_activate_all();
    global.pause = 0;
    global.mouse_click = 0; // el clic que cierra la ayuda no debe lanzar una carta
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
