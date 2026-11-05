// Con la capa oculta (pausa, ayuda o popup) el Draw no corre: tampoco se cuenta el clic, como antes de pasarlo al Step
if (!layer_get_visible(layer))
    exit;

push_enter = keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_face3);

// Paso de retirar la piel: cada clic (o A) sobre el cuerpo cuenta como un Enter (uno a la vez, sin repetir al mantener)
if (global.numero == MOMIA_PASO_PIEL && (global.mouse_click || gamepad_button_check_pressed(0, gp_face1)) && scr_mouse_sobre(spr_cuerpo, 544, 103, 1, 1))
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
