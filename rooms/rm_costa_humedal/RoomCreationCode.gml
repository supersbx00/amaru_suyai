if (global.espiritu_luna != 1)
{
    enemigo_id1 = instance_create(832, 480, obj_enemigo_normal1);
    enemigo_id2 = instance_create(2176, 544, obj_enemigo_normal1);
    enemigo_id3 = instance_create(1632, 1066, obj_enemigo_normal1);
}

if (global.zona < 1)
    global.zona = 1;

if (!instance_exists(obj_player))
{
    instance_create(0, 0, obj_player);
    obj_player.desactivado = 0;
}

if (!instance_exists(obj_pause))
    instance_create(0, 0, obj_pause);

if (!instance_exists(obj_generate))
    instance_create(0, 0, obj_generate);

if (!instance_exists(obj_room_controller))
    instance_create(0, 0, obj_room_controller);
