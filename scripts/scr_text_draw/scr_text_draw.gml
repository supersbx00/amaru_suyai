function scr_text_draw() {
draw_sprite(sprite_index, 0, x, y);
draw_set_colour(c_black);
draw_set_halign(fa_left);
draw_set_font(general);
draw_text(x - 380, y - 50, string_hash_to_newline(string(mensaje)));
}
