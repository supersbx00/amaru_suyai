if (enable)
    shader_set(sh_pixel);

shader_set_uniform_f(pixel, 256, 700, size - 1, size - 1);
shader_set_uniform_f(alpha, 1 - (size / max_size));
draw_sprite(spr_cuerpo, -100, 544, 103);
shader_reset();

// Indica dónde actuar en los pasos de retirar la piel (3) y fijar el cráneo (11): clic, o botón A con joystick
var marcar = 0;

if (global.numero == MOMIA_PASO_PIEL && size < max_size)
    marcar = 1;

if (global.numero == MOMIA_PASO_CRANEO && !scr_momia_craneo_cerrado())
    marcar = 1;

if (marcar)
    scr_momia_icono(652, 428);

// Paso de quitar los órganos: primero se quitan el cráneo y el esternón con un clic, después se arrastran los órganos.
// Se dibuja aquí porque obj_cuerpo es la capa de más arriba de la sala.
if (global.numero == MOMIA_PASO_ORGANOS && global.objeto_mouse == -4)
{
    var objetivo = noone;
    
    if (instance_exists(obj_huesos))
        objetivo = instance_find(obj_huesos, 0);
    else if (instance_exists(obj_organo))
        objetivo = instance_find(obj_organo, 0);
    
    if (objetivo != noone)
        scr_momia_icono((objetivo.bbox_left + objetivo.bbox_right) / 2, (objetivo.bbox_top + objetivo.bbox_bottom) / 2);
}
