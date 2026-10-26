global.escena = 0;

if (room == rm_anzota_2)
{
    temp[0] = 634;
    temp[1] = 687;
    temp[2] = 7;
    ds_list_insert(obj_game.cambio_escena, 0, temp);
    scr_go_to_room(temp[2]);
}

if (room == rm_cuevas_anzota)
{
    temp[0] = 780;
    temp[1] = 465;
    temp[2] = 6;
    ds_list_insert(obj_game.cambio_escena, 0, temp);
    scr_go_to_room(temp[2]);
}

if (room == rm_anzota)
{
    temp[0] = 864;
    temp[1] = 576;
    temp[2] = 10;
    ds_list_insert(obj_game.cambio_escena, 0, temp);
    scr_go_to_room(temp[2]);
}
