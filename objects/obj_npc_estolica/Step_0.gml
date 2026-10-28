dist = point_distance(x, y, obj_player.x, obj_player.y);
push_button = scr_tecla_z();

if (dist <= 100)
{
    if (push_button && count == 0)
    {
        if (!instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
                npc = other.nombre;
            
            count++;
        }
        
        script_execute(scr_desbloquearRecetas, "Estolica de Madera");
        
        if (!entregoPuntaje)
        {
            global.puntaje_total_descrasheo += 20;
            global.puntaje_total += 20;
            script_execute(scr_guardar_datos);
            entregoPuntaje = 1;
        }
    }
}

depth = -y;

if (count == 1)
{
    if (obj_player.x > x && obj_player.y > y)
        image_xscale = -1;
    else if (obj_player.x > x && obj_player.y < y)
        image_xscale = -1;
    else if (obj_player.x < x && obj_player.y < y)
        image_xscale = 1;
    else if (obj_player.x < x && obj_player.y > y)
        image_xscale = 1;
}
