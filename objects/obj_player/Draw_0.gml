// Se dibuja como el personaje activo; la lógica sigue usando los sprites de Amaru (y su máscara de colisión)
var spr_personaje = scr_sprite_personaje(sprite_index, global.personaje);
draw_sprite_ext(spr_personaje, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

// Destello al cambiar de personaje
if (global.cambio_destello > 0)
{
    gpu_set_fog(true, c_white, 0, 1);
    draw_sprite_ext(spr_personaje, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, global.cambio_destello / 8);
    gpu_set_fog(false, c_white, 0, 0);
}
