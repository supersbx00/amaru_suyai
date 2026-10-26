if (global.index == 0 && !instance_exists(obj_mensaje))
{
    instance_create(-120, 420, obj_mensaje);
    global.index = 1;
}

if (instance_exists(obj_pause))
    instance_deactivate_object(obj_pause);
