if (!instance_exists(obj_cartel_room))
{
    id_objcartel = instance_create(camera_get_view_width(view_camera[0]) / 2, 150, obj_cartel_room);
    id_objcartel.valor_room = room;
}
