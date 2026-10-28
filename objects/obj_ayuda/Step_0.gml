push_button = scr_tecla_z();
dist = point_distance(x, y, obj_player.x, obj_player.y);

if (dist <= 100)
{
    if (push_button && !instance_exists(obj_khoru_tutorial))
    {
        if (!instance_exists(obj_popup_ayuda))
            id_ayuda = instance_create(camera_get_view_x(view_camera[0]) + 660, camera_get_view_y(view_camera[0]) + 368, obj_popup_ayuda);
    }
}
