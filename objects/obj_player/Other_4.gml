if (!ds_list_empty(obj_game.cambio_escena) && global.escena == 0)
{
    temp = ds_list_find_value(obj_game.cambio_escena, 0);
    player_x = temp[0];
    player_y = temp[1];
}
else if (!ds_list_empty(obj_game.escena_grabada) && global.escena == 1)
{
    temp1 = ds_list_find_value(obj_game.escena_grabada, 0);
    player_x = temp1[0];
    player_y = temp1[1];
}

phy_position_x = player_x;
phy_position_y = player_y;

// Suyai unida: el acompañante aparece detrás del jugador en cada sala
if (global.suyai_unida && !instance_exists(obj_companero))
    instance_create(player_x - (60 * image_xscale), player_y - 30, obj_companero);
