if (gamepad_is_connected(0))
    sprite_index = spr_popup_anciana_xbox;
else
    sprite_index = spr_popup_anciana;

// Clic sobre el ícono o Back, solo tras la espera de cada página (anti-multiclic)
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
    
    if (count <= 1)
    {
        image_index = count;
        scr_ayuda_espera_reiniciar();
    }
}

if (count > 1)
{
    instance_activate_all();
    global.mouse_click = 0; // el clic que cierra la ayuda no debe mover a Amaru
    instance_destroy();
}

depth = -1;
