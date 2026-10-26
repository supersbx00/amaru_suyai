function scr_guardaPartida() {
script_execute(scr_guardar_item);
script_execute(scr_guardar_cartas);
script_execute(scr_guardar_mazo);
script_execute(scr_guardar_cuarto);
script_execute(scr_guardar_datos);
var gira = 0;
gira += 1;
draw_sprite_ext(spr_cursor, 0, __view_get(0, 0) + __view_get(2, 0), __view_get(1, 0) + __view_get(3, 0), 1, 1, gira, c_white, 1);
}
