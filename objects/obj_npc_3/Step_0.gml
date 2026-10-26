dist = point_distance(x, y, obj_player.x, obj_player.y);
push_button = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);

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
