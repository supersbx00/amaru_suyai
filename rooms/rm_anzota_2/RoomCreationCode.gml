enemigo_id = instance_create(1056, 640, obj_enemigo_normal1);

if (instance_number(obj_player) > 0)
{
    obj_player.player_x = 64;
    obj_player.player_y = 352;
}

if (!instance_exists(obj_player))
{
    with (instance_create(0, 0, obj_player))
    {
        player_x = 96;
        player_y = 448;
        desactivado = 0;
    }
}

if (!instance_exists(obj_generate))
    instance_create(0, 0, obj_generate);

if (!instance_exists(obj_pause))
{
    var pr = instance_create(0, 0, obj_pause);
    pr.depth = -1;
}

if (!instance_exists(obj_room_controller))
    instance_create(0, 0, obj_room_controller);
