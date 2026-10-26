push_enter = keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_face3);

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
