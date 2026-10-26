if (instance_number(obj_player) > 0)
{
    obj_player.player_x = 160;
    obj_player.player_y = 352;
}

if (!instance_exists(obj_generate))
    instance_create(0, 0, obj_generate);
