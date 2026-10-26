for (i = 1; i <= cantidadCartas; i += 1)
{
    card_sprite = ds_list_find_value(morralCards, ds_list_size(morralCards) - i);
    
    if (card_sprite != undefined)
        draw_sprite(card_sprite[0], card_sprite[1], 32 + (67 * i), 30);
}
