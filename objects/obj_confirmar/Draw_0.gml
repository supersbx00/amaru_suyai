draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(__view_get(0, 0), __view_get(1, 0), __view_get(0, 0) + __view_get(2, 0), __view_get(1, 0) + __view_get(3, 0), false);
draw_set_alpha(1);

if (estado == "nuevo")
{
    if (gamepad_is_connected(0))
        draw_sprite(spr_confirmar_xbox, 0, camera_get_view_x(view_camera[0]) + 660, camera_get_view_y(view_camera[0]) + 368);
    else
        draw_sprite(spr_confirmar_teclado, 0, camera_get_view_x(view_camera[0]) + 660, camera_get_view_y(view_camera[0]) + 368);
}

if (estado == "cargar")
{
    if (gamepad_is_connected(0))
        draw_sprite(spr_confirmar_xbox, 1, camera_get_view_x(view_camera[0]) + 660, camera_get_view_y(view_camera[0]) + 368);
    else
        draw_sprite(spr_confirmar_teclado, 1, camera_get_view_x(view_camera[0]) + 660, camera_get_view_y(view_camera[0]) + 368);
}

if (estado == "guardar")
{
    if (gamepad_is_connected(0))
        draw_sprite(spr_confirmar_xbox, 2, camera_get_view_x(view_camera[0]) + 660, camera_get_view_y(view_camera[0]) + 368);
    else
        draw_sprite(spr_confirmar_teclado, 2, camera_get_view_x(view_camera[0]) + 660, camera_get_view_y(view_camera[0]) + 368);
}
