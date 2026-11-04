if (image_alpha > 0)
{
    draw_sprite_ext(sprite_index, image_index, x, y, escala_x * mira, escala_y, 0, c_white, image_alpha);
    
    // Aviso de interacción mientras espera que Amaru llegue a hablarle
    if (global.desafio_camarones == 2 && fase == "espera" && point_distance(x, y, obj_player.x, obj_player.y) <= 100)
        scr_aviso_interaccion(sprite_get_yoffset(sprite_index) * escala_y + AVISO_MARGEN);
}

// Humo oscuro de la aparición: bocanadas que giran alrededor de Khoru, crecen y se disipan (encima de él al principio)
if (fase == "humo" && efecto > 0)
{
    var t = efecto / duracion_humo;
    var a_humo = (t < 0.4) ? (t / 0.4) : ((1 - t) / 0.6);
    var radio = 15 + 75 * t;
    var c_centro = make_color_rgb(30, 18, 34);
    var c_borde = make_color_rgb(70, 55, 75);
    draw_set_alpha(0.85 * a_humo);
    
    for (var i = 0; i < 14; i++)
    {
        var ang = (i * (360 / 14)) + (efecto * 5);
        var r = radio * (0.55 + 0.45 * ((i mod 3) / 2));
        var hx = x + lengthdir_x(r, ang);
        var hy = y + 10 + lengthdir_y(r * 0.6, ang) - (t * 30 * ((i mod 2) + 0.5));
        draw_circle_color(hx, hy, 16 + (14 * t), c_centro, c_borde, false);
    }
    
    draw_set_alpha(1);
}
