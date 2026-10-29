draw_self();
depth = -y;

if (obj_control_tutorial.paso == 4)
{
    if (dist <= 100)
    {
        scr_aviso_interaccion();
    }
    
    image_xscale = -1;
}

if (obj_control_tutorial.paso == 15)
{
    draw_sprite(spr_popUp_dialogo, 0, x + 220, y - 170);
    // Letras de barro centradas; arriba del texto queda en y - 210, como antes
    var aviso = string_hash_to_newline("Vamos!, debes tener como#máximo 5 cartas en tu mazo#Solo llevas " + string(obj_morral.mazo_seleccionado[4]));
    var medida = scr_texto_barro_medir(aviso, 24, 10000, 0.9);
    scr_texto_barro(x + 220, (y - 210) + (medida[1] / 2), aviso, 0.9, 1);
    draw_set_halign(fa_left);
}
