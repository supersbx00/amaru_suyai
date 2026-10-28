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
                    npc = "Khoru";
                
                count = 2;
            }
        }
        else
        {
            if (global.khoru == 0)
            {
                if (!instance_exists(obj_dialogo))
                {
                    with (instance_create(x, y, obj_dialogo))
                    {
                        npc = "Khoru2";
                        global.enable_battle = 1;
                        global.enable_player = 1;
                    }
                    
                    count = 1;
                }
            }
            
            if (global.khoru == 1)
            {
                with (obj_evil_whanku)
                    instance_destroy();
                
                if (!instance_exists(obj_dialogo))
                {
                    with (instance_create(x, y, obj_dialogo))
                        npc = "Khoru3";
                    
                    count = 3;
                }
            }
        }
    }
    
    if (!instance_exists(obj_dialogo))
    {
        if (global.khoru == 1 && count == 1)
        {
            with (instance_create(x, y, obj_dialogo))
                npc = "Khoru3";
            
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
        global.tipo_enemigo = "khoru";
        global.escena = 1;
        scr_go_to_room(4);
        count = 4;
    }
}

if (push && count == 3)
{
    if (!instance_exists(obj_dialogo))
    {
        if (!instance_exists(obj_whanku_final))
        {
            global.cinematica = 1;
            instance_create(x - 240, y - 70, obj_whanku_final);
        }
        
        if (instance_exists(obj_whanku_final))
        {
            with (instance_create(x, y, obj_dialogo))
                npc = "Final";
            
            count = 5;
        }
    }
}

if (count == 5)
{
    if (!instance_exists(obj_dialogo))
    {
        instance_destroy(obj_khoru);
        scr_go_to_room(15);
    }
}

if (global.khoru == 1)
    sprite_index = spr_khoru_mal;
