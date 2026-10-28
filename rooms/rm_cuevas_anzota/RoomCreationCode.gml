if (instance_number(obj_player) > 0)
{
    obj_player.player_x = 640;
    obj_player.player_y = 720;
}

if (!instance_exists(obj_player))
{
    with (instance_create(0, 0, obj_player))
    {
        player_x = 640;
        player_y = 720;
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

if (instance_exists(obj_control_tutorial))
{
    with (obj_control_tutorial)
        instance_destroy();
}

with (instance_create(camera_get_view_width(view_camera[0]) / 2, 150, obj_cartel_room))
    valor_room = room;
