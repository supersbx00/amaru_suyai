if (global.espiritu_agua == 1)
{
    with (obj_enemigo_normal)
        instance_destroy();
}

if (instance_number(obj_player) > 0)
{
    obj_player.player_x = 64;
    obj_player.player_y = 352;
}

if (global.zona < 5)
    global.zona = 5;

if (!instance_exists(obj_player))
{
    with (instance_create(x, y, obj_player))
    {
        player_x = 96;
        player_y = 448;
        desactivado = 0;
    }
}

if (!instance_exists(obj_generate))
    instance_create(x, y, obj_generate);

if (!instance_exists(obj_pause))
    instance_create(x, y, obj_pause);

if (!instance_exists(obj_room_controller))
    instance_create(x, y, obj_room_controller);

if (instance_number(obj_player) > 0)
{
    obj_player.player_x = 64;
    obj_player.player_y = 352;
}

if (!instance_exists(obj_player))
{
    with (instance_create(x, y, obj_player))
    {
        player_x = 96;
        player_y = 448;
        desactivado = 0;
    }
}

if (!instance_exists(obj_generate))
    instance_create(x, y, obj_generate);

if (!instance_exists(obj_pause))
    instance_create(x, y, obj_pause);

if (!instance_exists(obj_room_controller))
    instance_create(x, y, obj_room_controller);

with (instance_create(camera_get_view_width(view_camera[0]) / 2, 150, obj_cartel_room))
    valor_room = room;
