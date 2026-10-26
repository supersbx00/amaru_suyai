global.escena = 0;

if (room == rm_anzota_2)
{
    temp[0] = 253;
    temp[1] = 834;
    
    if (instance_exists(obj_player))
    {
        with (obj_player)
        {
            sprite_index = spr_amaru_stand_rightTop;
            image_index = -1;
        }
    }
    
    temp[2] = 8;
    ds_list_insert(obj_game.cambio_escena, 0, temp);
    scr_go_to_room(temp[2]);
}

if (room == rm_anzota_3)
{
    temp[0] = 2281;
    temp[1] = 906;
    
    if (instance_exists(obj_player))
    {
        with (obj_player)
        {
            sprite_index = spr_amaru_stand_rightTop;
            image_index = -1;
        }
    }
    
    temp[2] = 6;
    ds_list_insert(obj_game.cambio_escena, 0, temp);
    scr_go_to_room(temp[2]);
}
