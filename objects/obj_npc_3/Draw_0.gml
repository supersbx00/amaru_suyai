// Con Suyai unida es un punto de charla: no se dibuja, pero el aviso de botón sí
if (!global.suyai_unida)
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
