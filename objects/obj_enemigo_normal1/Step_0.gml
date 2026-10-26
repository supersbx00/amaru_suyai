depth = -y;
enemy_id = id;
script_execute(state, "tojone");
dist = point_distance(x, y, obj_player.x, obj_player.y);

if (dist <= 100)
{
    with (obj_player)
    {
        global.enable_player = 1;
        global.enable_battle = 1;
        enable_player = 1;
        enable_battle = 1;
        hspd = 0;
        vspd = 0;
    }
}

if (obj_morral.mazo_seleccionado[4] < 4)
    rival_digno = 0;
else
    rival_digno = 1;
