depth = -y;
script_execute(state, "normal");

if (instance_number(obj_player) != 0)
{
    dist = point_distance(x, y, obj_player.x, obj_player.y);
    
    if (dist <= 100)
    {
        global.enable_battle = 1;
        global.enable_player = 1;
        obj_player.enable_battle = 1;
        obj_player.enable_player = 1;
    }
}

if (obj_morral.mazo_seleccionado[4] < 4)
    rival_digno = 0;
else
    rival_digno = 1;
