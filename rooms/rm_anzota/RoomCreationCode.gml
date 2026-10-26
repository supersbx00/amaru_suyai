enemy_id = instance_create(1312, 736, obj_enemigo_normal1);
enemy_id = instance_create(1024, 160, obj_enemigo_normal1);
enemy_id = instance_create(2304, 1376, obj_enemigo_normal1);

if (global.zona < 3)
    global.zona = 3;

if (!instance_exists(obj_player))
{
    with (instance_create(x, y, obj_player))
    {
        player_x = 128;
        player_y = 416;
        desactivado = 0;
    }
}

if (!instance_exists(obj_generate))
    instance_create(x, y, obj_generate);

if (!instance_exists(obj_pause))
    instance_create(x, y, obj_pause);

if (!instance_exists(obj_room_controller))
    instance_create(x, y, obj_room_controller);

if (!instance_exists(obj_room_controller))
    instance_create(x, y, obj_room_controller);
