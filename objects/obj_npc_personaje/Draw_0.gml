draw_self();

if (nombre != "" && point_distance(x, y, obj_player.x, obj_player.y) <= 100)
    scr_aviso_interaccion();
