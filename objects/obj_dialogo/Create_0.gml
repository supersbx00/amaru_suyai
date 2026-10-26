mensaje = "";
numero = 0;
final = -1;
alarm[0] = 3;

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

event_inherited();
