dist = point_distance(x, y, obj_player.x, obj_player.y);
image_speed = 0.3;
push = scr_tecla_z();

if (dist <= 100)
{
    if (push && count == 0)
    {
        if (instance_number(obj_enemigo_normal) != 0)
        {
            if (!instance_exists(obj_dialogo))
            {
                with (instance_create(x, y, obj_dialogo))
                    npc = "espiritu_luna1";
                
                count = 2;
            }
        }
        else
        {
            if (global.espiritu_luna == 0)
            {
                if (!instance_exists(obj_dialogo))
                {
                    with (instance_create(x, y, obj_dialogo))
                    {
                        npc = "espiritu_luna2";
                        global.enable_battle = 1;
                        global.enable_player = 1;
                    }
                    
                    count = 1;
                }
            }
            
            if (global.espiritu_luna == 1)
            {
                if (!instance_exists(obj_dialogo))
                {
                    with (instance_create(x, y, obj_dialogo))
                        npc = "espiritu_luna3";
                    
                    count = 3;
                }
            }
        }
    }
    
    if (!instance_exists(obj_dialogo))
    {
        if (global.espiritu_luna == 1 && count == 1)
        {
            with (instance_create(x, y, obj_dialogo))
                npc = "espiritu_luna3";
            
            count = 3;
        }
    }
}
else
{
    count = 0;
}

depth = -y;

if (count == 1)
{
    if (!instance_exists(obj_dialogo))
    {
        global.tipo_enemigo = "espiritu_luna";
        global.escena = 1;
        scr_go_to_room(4);
        count = 4;
    }
}

if (count == 3)
{
    if (!instance_exists(obj_dialogo))
    {
        global.escena = 0;
        ds_list_clear(obj_game.cambio_escena);
        temp[0] = 1856;
        temp[1] = 96;
        temp[2] = 14;
        ds_list_insert(obj_game.cambio_escena, 0, temp);
        scr_go_to_room(temp[2]);
        count = 4;
    }
}
