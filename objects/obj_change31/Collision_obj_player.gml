global.escena = 0;

if (room == rm_anzota_2)
{
    temp[0] = 2304;
    temp[1] = 1344;
    
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
