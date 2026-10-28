if (!instance_exists(obj_player))
{
    with (instance_create(0, 0, obj_player))
    {
        player_x = 128;
        player_y = 416;
        desactivado = 0;
    }
}

if (global.zona < 4)
    global.zona = 4;

if (!instance_exists(obj_generate))
    instance_create(0, 0, obj_generate);

if (!instance_exists(obj_pause))
    instance_create(0, 0, obj_pause);

if (!instance_exists(obj_room_controller))
    instance_create(0, 0, obj_room_controller);

if (!instance_exists(obj_room_controller))
    instance_create(0, 0, obj_room_controller);

with (instance_create(camera_get_view_width(view_camera[0]) / 2, 150, obj_cartel_room))
    valor_room = room;
