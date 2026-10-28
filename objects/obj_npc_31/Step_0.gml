dist = point_distance(x, y, obj_player.x, obj_player.y);
push_button = scr_tecla_z();

if (global.espiritu_luna == 1 && count1 == 0)
{
    nombre = "npc31_2";
    count = 0;
    count1 = 1;
}

if (dist <= 100)
{
    if (push_button && count == 0)
    {
        with (instance_create(x, y, obj_dialogo))
            npc = other.nombre;
        
        if (!entregoPuntaje)
        {
            global.puntaje_total_descrasheo += 20;
            global.puntaje_total += 20;
            script_execute(scr_guardar_datos);
            entregoPuntaje = 1;
        }
        
        count++;
    }
    
    if (instance_exists(obj_dialogo))
    {
        if (instance_exists(obj_player))
        {
            obj_player.hspd = 0;
            obj_player.vspd = 0;
            obj_player.enable_player = 1;
        }
    }
}

depth = -y;
