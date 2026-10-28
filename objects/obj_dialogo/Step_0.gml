if (gamepad_is_connected(0))
    sprite_index = spr_cuadro_dialogo_xbox;
else
    sprite_index = spr_cuadro_dialogo;

script_execute(scr_text_step);
scr_text_npc();
final = array_length(texto);

if (instance_exists(obj_player))
{
    if ((obj_player.y - 100) <= (camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2)))
    {
        x = camera_get_view_x(view_camera[0]) + 640;
        y = camera_get_view_y(view_camera[0]) + 640;
    }
    else
    {
        x = camera_get_view_x(view_camera[0]) + 660;
        y = camera_get_view_y(view_camera[0]) + 128;
    }
}

if (room == rm_battle_tutorial)
{
    x = camera_get_view_x(view_camera[0]) + 660;
    y = camera_get_view_y(view_camera[0]) + 216;
}

depth = -1000 * room_height;
