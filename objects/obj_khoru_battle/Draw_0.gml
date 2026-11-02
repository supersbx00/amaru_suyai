// La carta de arriba es la del enemigo que tiene el turno
if (cartaUsada != undefined && scr_batalla_mi_turno())
{
    dibujaCarta1 = cartaUsada;
    
    if (anulable)
        draw_sprite_ext(dibujaCarta1[0], dibujaCarta1[1], (room_width / 2) + 202, 65, 1, 1, 0, c_gray, 0.7);
    else
        draw_sprite_ext(dibujaCarta1[0], dibujaCarta1[1], (room_width / 2) + 202, 65, 1, 1, 0, c_white, 1);
}

// Con tinte si está herido, brillo si avisa un disparo, barra de vida y marca de turno
scr_enemigo_dibujar();
