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
var sep = max(font_size + (font_size / 2), 24);   // 24 = alto de una línea de barro a 0.9
var dx = x + padding;
var dy = y + padding;

// Letras de barro; el centrado se mide con el texto completo para que las letras no se muevan al escribirse
if (centrado)
{
    var medida = scr_texto_barro_medir(text, sep, maxlength, 0.9);
    dx = x - (medida[0] / 2);
    dy = y - (medida[1] / 2);
}

scr_texto_barro_ext(dx, dy, print, sep, maxlength, 0.9, alpha);
draw_set_alpha(1);
