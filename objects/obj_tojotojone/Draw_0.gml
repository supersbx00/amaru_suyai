if (cartaUsada != undefined)
{
    dibujaCarta1 = cartaUsada;
    
    if (anulable)
        draw_sprite_ext(dibujaCarta1[0], dibujaCarta1[1], (room_width / 2) + 202, 65, 1, 1, 0, c_gray, 0.7);
    else
        draw_sprite_ext(dibujaCarta1[0], dibujaCarta1[1], (room_width / 2) + 202, 65, 1, 1, 0, c_white, 1);
}

if (!ds_list_empty(ComboArray))
{
    cartausada1 = ds_list_find_value(ComboArray, 0);
    cartausada2 = ds_list_find_value(ComboArray, 1);
    cartausada3 = ds_list_find_value(ComboArray, 2);
    
    if (ds_list_size(ComboArray) == 3)
    {
        draw_sprite(cartausada1[0], cartausada1[1], 950, 70);
        draw_sprite(cartausada2[0], cartausada2[1], 1020, 70);
        draw_sprite(cartausada3[0], cartausada3[1], 1090, 70);
    }
}

draw_self();
