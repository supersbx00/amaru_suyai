draw_self();
dist = point_distance(x, y, obj_player.x, obj_player.y);

if (dist <= 100)
{
    scr_aviso_interaccion();
}
else
{
    count = 0;
}
