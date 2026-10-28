draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(__view_get(0, 0), __view_get(1, 0), __view_get(0, 0) + __view_get(2, 0), __view_get(1, 0) + __view_get(3, 0), false);
draw_set_alpha(1);
var px = camera_get_view_x(view_camera[0]) + 660;
var py = camera_get_view_y(view_camera[0]) + 368;
draw_sprite(sprite_index, image_index, px, py);
scr_ayuda_dibujar_icono(scr_ayuda_icono_x(sprite_index, px), scr_ayuda_icono_y(sprite_index, py));
