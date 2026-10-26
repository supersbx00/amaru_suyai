action_set_motion(0, 0);
global.escena = 0;

if (room == rm_humedal)
{
    temp[0] = 1504;
    temp[1] = 64;
    temp[2] = 12;
    ds_list_insert(obj_game.cambio_escena, 0, temp);
    scr_go_to_room(temp[2]);
}

if (room == rm_costa_humedal)
{
    temp[0] = 2514;
    temp[1] = 1504;
    temp[2] = 11;
    ds_list_insert(obj_game.cambio_escena, 0, temp);
    scr_go_to_room(temp[2]);
}
