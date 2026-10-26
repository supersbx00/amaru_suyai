draw_self();
apunta_izq = apuntador - 1;
apunta_mid = apuntador;
apunta_der = apuntador + 1;
apunta_mde = apuntador + 2;

if (apunta_izq == -1)
    apunta_izq = ds_list_size(playerDeck) - 1;

if (apunta_der >= ds_list_size(playerDeck))
    apunta_der = 0;

if (apunta_mde > (ds_list_size(playerDeck) - 1))
    apunta_mde = 0;

carta_izq = ds_list_find_value(playerDeck, apunta_izq);
carta_mid = ds_list_find_value(playerDeck, apunta_mid);
carta_der = ds_list_find_value(playerDeck, apunta_der);
carta_mde = ds_list_find_value(playerDeck, apunta_mde);

if (ds_list_size(playerDeck) > 3)
{
    if (carta_izq != undefined)
    {
        if (carta_izq[0] != 15)
            draw_sprite_ext(carta_izq[0], carta_izq[1], -30, 608, 1.5, 1.5, 0, c_white, 0.8);
        else
            draw_sprite_ext(carta_izq[0], recuperaCartas / vecesRecuperarCartas, -30, 608, 1.5, 1.5, 0, c_white, 0.8);
    }
}

if (ds_list_size(playerDeck) > 2)
{
    if (carta_mde != undefined)
    {
        if (carta_mde[0] != 15)
            draw_sprite_ext(carta_mde[0], carta_mde[1], 98, 662, 1.5, 1.5, 0, c_white, 0.6);
        else
            draw_sprite_ext(carta_mde[0], recuperaCartas / vecesRecuperarCartas, 98, 662, 1.5, 1.5, 0, c_white, 0.6);
    }
}

if (ds_list_size(playerDeck) > 1)
{
    if (carta_der != undefined)
    {
        if (carta_der[0] != 15)
            draw_sprite_ext(carta_der[0], carta_der[1], 81, 642, 1.5, 1.5, 0, c_white, 0.8);
        else
            draw_sprite_ext(carta_der[0], recuperaCartas / vecesRecuperarCartas, 81, 642, 1.5, 1.5, 0, c_white, 0.8);
    }
}

if (ds_list_size(playerDeck) > 0)
{
    if (carta_mid != undefined)
    {
        if (carta_mid[0] != 15)
            draw_sprite_ext(carta_mid[0], carta_mid[1], 52, 617, 1.5, 1.5, 0, c_white, 1);
        else
            draw_sprite_ext(carta_mid[0], recuperaCartas / vecesRecuperarCartas, 52, 617, 1.5, 1.5, 0, c_white, 1);
    }
}
else
{
    draw_sprite_ext(spr_chargCards, 0, 52, 617, 1.5, 1.5, 0, c_white, 1);
}

if (popUp_on)
{
    if (ds_list_size(playerDeck) > 0)
    {
        if (carta_mid != undefined)
        {
            if (carta_mid[0] != 15)
                draw_sprite_ext(carta_mid[0], carta_mid[1], 40, room_height / 4, 3, 3, 0, c_white, 1);
            else
                draw_sprite_ext(carta_mid[0], recuperaCartas / vecesRecuperarCartas, 60, room_height / 4, 3, 3, 0, c_white, 1);
        }
    }
}

primero = ds_list_find_value(colaCartas, 0);

if (obj_battleController.duelo1)
    scr_dibujarCartas(primero, 608);

popUp_on = 0;

if (cartaUsada != undefined)
{
    dibujaCarta1 = cartaUsada;
    dibujaCombo1 = ds_list_find_value(comboCard_array, 0);
    
    if (anulable)
        draw_sprite_ext(dibujaCarta1[0], dibujaCarta1[1], (room_width / 2) - 302, 75, 1, 1, 0, c_gray, 0.7);
    else
        draw_sprite_ext(dibujaCarta1[0], dibujaCarta1[1], (room_width / 2) - 302, 75, 1, 1, 0, c_white, 1);
}

if (!ds_list_empty(comboCard_array))
{
    if (comparaCarta1 != undefined && comparaCarta2 != undefined && comparaCarta3 != undefined)
    {
        draw_sprite(comparaCarta3[0], comparaCarta3[1], 150, 75);
        draw_sprite(comparaCarta2[0], comparaCarta2[1], 220, 75);
        draw_sprite(comparaCarta1[0], comparaCarta1[1], 290, 75);
    }
    else if (comparaCarta1 != undefined && comparaCarta2 != undefined)
    {
        draw_sprite(comparaCarta2[0], comparaCarta2[1], 150, 75);
        draw_sprite(comparaCarta1[0], comparaCarta1[1], 220, 75);
    }
    else if (comparaCarta1 != undefined)
    {
        draw_sprite(comparaCarta1[0], comparaCarta1[1], 150, 75);
    }
}

if (combo == 1 && !player_cardBreaked)
{
    if (!anulable)
        draw_sprite_ext(spr_combo, 0, 650, 80, 1, 1, 0, c_white, 1);
}

if (anulable)
    draw_sprite_ext(spr_anulado, 0, 650, 80, 1, 1, 0, c_white, 1);

if (player_cardBreaked && barHealth > 0)
    draw_sprite_ext(spr_paralizado, 0, 650, 80, 1, 1, 0, c_white, 1);

if (go_agua < 2 || go_fuego < 2 || go_luna < 2)
{
    if (!ancestral)
    {
        draw_set_color(c_white);
        draw_sprite(spr_go_agua_min, 1, __view_get(0, 0) + 340, __view_get(1, 0) + 40);
        draw_text(__view_get(0, 0) + 337, __view_get(1, 0) + 40, string_hash_to_newline(string(go_agua)));
        draw_sprite(spr_go_fuego_min, 1, __view_get(0, 0) + 380, __view_get(1, 0) + 40);
        draw_text(__view_get(0, 0) + 377, __view_get(1, 0) + 40, string_hash_to_newline(string(go_fuego)));
        draw_sprite(spr_go_luna_min, 1, __view_get(0, 0) + 420, __view_get(1, 0) + 40);
        draw_text(__view_get(0, 0) + 415, __view_get(1, 0) + 40, string_hash_to_newline(string(go_luna)));
    }
}
else if (gamepad_is_connected(0))
{
    draw_sprite(spr_button_B, 1, __view_get(0, 0) + 340, __view_get(1, 0) + 40);
}
else
{
    draw_sprite(spr_button_C, 1, __view_get(0, 0) + 340, __view_get(1, 0) + 40);
}
