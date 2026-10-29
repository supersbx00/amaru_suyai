if (completo)
{
    draw_sprite(spr_barro, 0, ox, oy);
    exit;
}

// Guía: la silueta de la arcilla a medias
draw_sprite_ext(spr_barro, 0, ox, oy, 1, 1, 0, c_white, 0.5);

var cambio = 0;

// Si la superficie se perdió, se rehace con todos los toques guardados
if (!surface_exists(mascara))
{
    mascara = surface_create(ancho, alto);
    surface_set_target(mascara);
    draw_clear_alpha(c_white, 0);
    surface_reset_target();
    dibujados = 0;
}

if (dibujados < array_length(toques))
{
    var color = draw_get_colour();
    surface_set_target(mascara);
    draw_set_colour(c_white);
    
    for (var k = dibujados; k < array_length(toques); k += 2)
        draw_circle(toques[k], toques[k + 1], radio, false);
    
    surface_reset_target();
    draw_set_colour(color);
    dibujados = array_length(toques);
    cambio = 1;
}

if (!surface_exists(capa))
{
    capa = surface_create(ancho, alto);
    cambio = 1;
}

// Capa = spr_barro copiado sin mezclar (para no oscurecer el borde) y recortado por el alfa de la máscara
if (cambio)
{
    surface_set_target(capa);
    draw_clear_alpha(c_black, 0);
    gpu_set_blendenable(false);
    draw_sprite(spr_barro, 0, 0, 0);
    gpu_set_blendenable(true);
    gpu_set_blendmode_ext(bm_zero, bm_src_alpha);
    draw_surface(mascara, 0, 0);
    gpu_set_blendmode(bm_normal);
    surface_reset_target();
}

draw_surface(capa, ox, oy);

if (en_mano)
{
    // El terrón de arcilla en la mano
    draw_sprite(spr_objetos, 9, mouse_x, mouse_y);
    scr_texto_barro(652, 85, sin_arcilla ? "Falta arcilla" : "Arcilla " + string(floor((cubiertas / max(1, total)) * 100)) + "%", 0.9, 1);
}
