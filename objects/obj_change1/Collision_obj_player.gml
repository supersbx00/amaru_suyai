global.escena = 0;

if (room == rm_anzota_2)
{
    temp[0] = 2315;
    temp[1] = 1626;
    
    if (instance_exists(obj_player))
    {
        with (obj_player)
        {
            sprite_index = spr_amaru_stand_rightTop;
            image_index = -1;
        }
    }
    
    temp[2] = 7;
    ds_list_insert(obj_game.cambio_escena, 0, temp);
    scr_go_to_room(temp[2]);
}

if (room == rm_cuevas_anzota)
{
    temp[0] = 1882;
    temp[1] = 665;
    
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

if (room == rm_anzota)
{
    temp[0] = 126;
    temp[1] = 512;
    
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

if (room == rm_capilla)
{
    temp[0] = 2069;
    temp[1] = 660;
    
    if (instance_exists(obj_player))
    {
        with (obj_player)
        {
            sprite_index = spr_amaru_stand_rightTop;
            image_index = -1;
        }
    }
    
    temp[2] = 9;
    ds_list_insert(obj_game.cambio_escena, 0, temp);
    scr_go_to_room(temp[2]);
}
