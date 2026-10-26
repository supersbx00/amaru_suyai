draw_self();
depth = -y;

if (obj_control_tutorial.paso == 4)
{
    if (dist <= 100)
    {
        if (gamepad_is_connected(0))
            draw_sprite(spr_boton_a, 0, obj_player.x, obj_player.y - 104);
        else
            draw_sprite(spr_button_A, 0, obj_player.x, obj_player.y - 104);
    }
    
    image_xscale = -1;
}

if (obj_control_tutorial.paso == 9)
{
    draw_sprite(spr_popUp_dialogo, 0, x + 220, y - 170);
    draw_set_halign(fa_center);
    
    if (gamepad_is_connected(0))
        draw_text(x + 220, y - 200, string_hash_to_newline("Presiona 'START'# que esperas!?!"));
    else
        draw_text(x + 220, y - 200, string_hash_to_newline("Presiona 'Enter'# que esperas!?!"));
}

if (obj_control_tutorial.paso == 15)
{
    draw_sprite(spr_popUp_dialogo, 0, x + 220, y - 170);
    draw_set_halign(fa_center);
    draw_text(x + 220, y - 210, string_hash_to_newline("Vamos!, debes tener como#máximo 5 cartas en tu mazo#Solo llevas " + string(obj_morral.mazo_seleccionado[4])));
}
