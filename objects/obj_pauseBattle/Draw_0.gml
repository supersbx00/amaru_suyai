if (pauseBattle)
{
    draw_set_color(c_black);
    draw_set_alpha(0.5);
    draw_rectangle(__view_get(0, 0), __view_get(1, 0), __view_get(0, 0) + __view_get(2, 0), __view_get(1, 0) + __view_get(3, 0), false);
    draw_set_alpha(1);
    draw_sprite(spr_titulo, 0, room_width / 2, (room_height / 2) - 100);
    draw_set_color(c_white);
    draw_text(room_width / 2, (room_height / 2) - 200, "Puntaje : " + string(global.puntaje_total_descrasheo));
}
