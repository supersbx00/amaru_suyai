if (gamepad_is_connected(0))
    sprite_index = spr_cuadro_dialogo_xbox;
else
    sprite_index = spr_cuadro_dialogo;

script_execute(scr_text_step);
depth = -1 * room_height;
scr_text_npc(npc);
final = array_length_1d(texto);

if (instance_exists(obj_player))
{
    if ((obj_player.y - 100) <= (__view_get(1, 0) + (__view_get(3, 0) / 2)))
    {
        x = __view_get(0, 0) + 640;
        y = __view_get(1, 0) + 640;
    }
    else
    {
        x = __view_get(0, 0) + 660;
        y = __view_get(1, 0) + 128;
    }
}

if (room == rm_battle_tutorial)
{
    x = __view_get(0, 0) + 660;
    y = __view_get(1, 0) + 216;
}
