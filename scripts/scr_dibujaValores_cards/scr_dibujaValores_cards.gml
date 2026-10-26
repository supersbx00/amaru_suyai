function scr_dibujaValores_cards() {
primeroCombo = ds_list_find_value(comboCard_array, 0);

if (argument0 != undefined)
{
    if (argument0[3] != "combo" && argument0[3] != "unicombo" && argument0[3] != "multicombo")
        draw_sprite(argument0[0], argument0[1], argument1, 528);
    else if (ds_list_size(comboCard_array) == 1)
        draw_sprite(primeroCombo[0], primeroCombo[1], argument1, 528);
}
}
