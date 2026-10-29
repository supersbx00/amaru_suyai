push_enter = keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_face3);

// Paso de retirar la piel: cada clic sobre el cuerpo cuenta como un Enter (un clic a la vez, sin repetir al mantener)
if (global.numero == 3 && global.mouse_click && scr_mouse_sobre(spr_cuerpo, 544, 103, 1, 1))
{
    push_enter = 1;
    global.mouse_click = 0;
}

if (push_enter)
{
    size += 1;
    
    if (size > max_size)
        size = max_size;
}

if (push_enter)
{
    enable = 1;
    global.prioridad += 1;
}

if (enable)
    shader_set(sh_pixel);

shader_set_uniform_f(pixel, 256, 700, size - 1, size - 1);
shader_set_uniform_f(alpha, 1 - (size / max_size));
draw_sprite(spr_cuerpo, -100, 544, 103);
shader_reset();

// Indica dónde hacer clic en los pasos de retirar la piel (3) y fijar el cráneo (11); con gamepad no se muestra
var marcar = 0;

if (!gamepad_is_connected(0))
{
    if (global.numero == 3 && size < max_size)
        marcar = 1;
    
    if (global.numero == 11 && !(instance_exists(obj_craneo) && instance_exists(obj_esternon) && obj_craneo.x == 622 && obj_craneo.y == 123 && obj_esternon.x == 607 && obj_esternon.y == 253))
        marcar = 1;
}

var icono_frame = floor(current_time / 133) mod sprite_get_number(spr_boton_clic);

if (marcar)
    draw_sprite(spr_boton_clic, icono_frame, 652, 428);

// Paso de quitar los órganos: primero se quitan el cráneo y el esternón con un clic, después se arrastran los órganos.
// Se dibuja aquí porque obj_cuerpo es la capa de más arriba de la sala.
if (global.numero == 4 && global.objeto_mouse == -4)
{
    var objetivo = noone;
    
    if (instance_exists(obj_huesos))
        objetivo = instance_find(obj_huesos, 0);
    else if (instance_exists(obj_organo))
        objetivo = instance_find(obj_organo, 0);
    
    if (objetivo != noone)
        draw_sprite(spr_boton_clic, icono_frame, (objetivo.bbox_left + objetivo.bbox_right) / 2, (objetivo.bbox_top + objetivo.bbox_bottom) / 2);
}
