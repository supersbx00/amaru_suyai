var otro = (global.personaje == "amaru") ? "suyai" : "amaru";
var spr_personaje = scr_sprite_personaje(sprite_index, otro);
draw_sprite_ext(spr_personaje, image_index, x, y, image_xscale, image_yscale, 0, c_white, image_alpha);

// Destello al cambiar de personaje (lo descuenta este objeto)
if (global.cambio_destello > 0)
{
    gpu_set_fog(true, c_white, 0, 1);
    draw_sprite_ext(spr_personaje, image_index, x, y, image_xscale, image_yscale, 0, c_white, global.cambio_destello / 8);
    gpu_set_fog(false, c_white, 0, 0);
}

if (icono_visible)
    draw_sprite_ext(spr_cambiar_personaje, (icono_presionado > 0) ? 12 : floor(icono_frame), icono_x, icono_y, icono_escala, icono_escala, 0, c_white, 1);
