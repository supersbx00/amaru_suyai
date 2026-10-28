function scr_text_draw_2() {
draw_sprite(sprite_index, 138, __view_get(0, 0) + 640, __view_get(1, 0) + 106);
scr_texto_icono_clic(sprite_index, __view_get(0, 0) + 640, __view_get(1, 0) + 106, 1);
draw_set_colour(c_black);
draw_set_halign(fa_left);
draw_set_font(general);
draw_text(__view_get(0, 0) + 280, __view_get(1, 0) + 46, string_hash_to_newline(string(mensaje)));
}
