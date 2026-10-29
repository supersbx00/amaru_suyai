function scr_text_draw() {
draw_sprite(sprite_index, 0, x, y);
scr_texto_icono_clic(sprite_index, x, y, 1);
draw_set_halign(fa_left);
draw_set_font(general);
scr_texto_barro_izq(x - 380, y - 50, string(mensaje), 0.9, 1);
}
