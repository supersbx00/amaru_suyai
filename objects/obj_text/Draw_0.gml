if (time < text_length)
{
    time += spd;
    print = string_copy(text, 0, time);
}

draw_set_alpha(alpha);

if (alpha < 1)
    alpha += (spd / 10);
else
    alpha = 1;

draw_set_font(font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
var sep = font_size + (font_size / 2);
var dx = x + padding;
var dy = y + padding;

if (centrado)
{
    dx = x - (string_width_ext(string_hash_to_newline(text), sep, maxlength) / 2);
    dy = y - (string_height_ext(string_hash_to_newline(text), sep, maxlength) / 2);
}

var prev_color = draw_get_color();
draw_set_color(c_black);
draw_text_ext(dx, dy, string_hash_to_newline(print), sep, maxlength);
draw_set_color(prev_color);
draw_set_alpha(1);
