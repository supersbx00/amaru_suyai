dist = point_distance(x, y, obj_player.x, obj_player.y);
push_int = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);

if (dist <= 120)
{
    if (push_int && count == 0)
    {
        if (!entregoPuntaje)
        {
            global.puntaje_total_descrasheo += 20;
            global.puntaje_total += 20;
            script_execute(scr_guardar_datos);
            entregoPuntaje = 1;
        }
        
        instance_create(x, y, obj_texto_morro);
        count++;
    }
    
    if (instance_exists(obj_texto_morro))
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
