if (cartaUsada != undefined)
{
    dibujaCarta1 = cartaUsada;
    
    if (anulable)
        draw_sprite_ext(dibujaCarta1[0], dibujaCarta1[1], (room_width / 2) + 202, 65, 1, 1, 0, c_gray, 0.7);
    else
        draw_sprite_ext(dibujaCarta1[0], dibujaCarta1[1], (room_width / 2) + 202, 65, 1, 1, 0, c_white, 1);
}

draw_self();
