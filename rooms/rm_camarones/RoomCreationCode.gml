global.cinematica = 0;

if (instance_number(obj_player) > 0)
    obj_player.desactivado = 0;

if (global.zona < 2)
    global.zona = 2;

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
