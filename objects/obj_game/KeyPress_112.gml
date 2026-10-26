global.escena = 0;

if (room != rm_menu && room != rm_tutorial_test)
{
    if (!instance_exists(obj_cartel_room) && !instance_exists(obj_dialogo) && !instance_exists(obj_transition))
    {
        temp[0] = 1184;
        temp[1] = 384;
        temp[2] = 11;
        ds_list_insert(obj_game.cambio_escena, 0, temp);
        scr_go_to_room(temp[2]);
    }
}
