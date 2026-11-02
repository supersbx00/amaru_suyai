draw_sprite(sprite_index, 183, 586, 555);
draw_set_halign(fa_left);
draw_set_font(general);
scr_texto_barro_izq(702, 630, string(mensaje), 0.9, 1);

// Sin gamepad, el ícono de clic izquierdo solo va en los pasos de diálogo; en los de acción se marca donde hay que hacer clic
if (gamepad_is_connected(0))
{
    // Los sprites _xbox traen el botón plano: se tapa con el de madera (scr_boton_joy)
    if (!paso_accion[global.numero])
    {
        draw_sprite(spr_siguiente_xbox, 0, 965, 780);
        scr_boton_joy_sobre(spr_siguiente_xbox, 965, 780);
    }
    
    if (global.numero == 3 || global.numero == 11)
    {
        draw_sprite(spr_botton_x_xbox, 0, 965, 780);
        scr_boton_joy_sobre(spr_botton_x_xbox, 965, 780);
    }
}
else if (!paso_accion[global.numero])
{
    draw_sprite(spr_boton_clic, floor(current_time / 133) mod sprite_get_number(spr_boton_clic), 965, 780);
}
