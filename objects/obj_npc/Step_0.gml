with (obj_npc)
{
    push_button = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);
    dist = point_distance(x, y, obj_player.x, obj_player.y);
    
    if (dist <= 100)
    {
        if (push_button && count == 0)
        {
            if (room == rm_humedal)
            {
                if (!blessed)
                {
                    blessed = 1;
                    
                    if (!instance_exists(obj_dialogo))
                    {
                        with (instance_create(x, y, obj_dialogo))
                            npc = other.nombre;
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
            }
            
            if (room == rm_capilla)
            {
                if (!instance_exists(obj_texto_capilla))
                    instance_create(x, y, obj_texto_capilla);
                
                if (instance_exists(obj_texto_capilla))
                {
                    if (instance_exists(obj_player))
                    {
                        obj_player.hspd = 0;
                        obj_player.vspd = 0;
                        obj_player.enable_player = 1;
                    }
                }
            }
            
            script_execute(scr_cambiaSprite);
        }
    }
    else
    {
        count = 0;
    }
}
