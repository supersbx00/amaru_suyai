if (instance_number(obj_player) > 0)
{
    obj_player.player_x = 303;
    obj_player.player_y = 814;
}

if (!instance_exists(obj_player))
{
    with (instance_create(x, y, obj_player))
    {
        player_x = 303;
        player_y = 814;
        desactivado = 0;
    }
}

if (global.zona < 6)
    global.zona = 6;

if (!instance_exists(obj_generate))
    instance_create(x, y, obj_generate);

if (!instance_exists(obj_pause))
    instance_create(x, y, obj_pause);

if (!instance_exists(obj_room_controller))
    instance_create(x, y, obj_room_controller);

if (instance_exists(obj_control_tutorial))
{
    with (obj_control_tutorial)
        instance_destroy();
}

with (instance_create(camera_get_view_width(view_camera[0]) / 2, 150, obj_cartel_room))
    valor_room = room;
