dist = point_distance(x, y, obj_player.x, obj_player.y);
image_speed = 0.3;
push = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);

if (dist <= 100)
{
    if (push && count == 0)
    {
        if (room == rm_camarones)
        {
            if (global.anciana == 0)
            {
                if (!instance_exists(obj_dialogo))
                {
                    with (instance_create(x, y, obj_dialogo))
                        npc = "espiritu_luna_camarones";
                    
                    count = 2;
                }
            }
            else if (global.anciana == 1)
            {
                if (!instance_exists(obj_dialogo))
                {
                    with (instance_create(x, y, obj_dialogo))
                        npc = "espiritu_luna_camarones2";
                    
                    count = 1;
                }
            }
        }
        else if (!instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
                npc = "espiritu_luna_camarones2";
            
            count = 1;
        }
    }
    
    if (count == 1)
    {
        if (!instance_exists(obj_dialogo))
        {
            if (room == rm_camarones)
            {
                global.escena = 0;
                ds_list_clear(obj_game.cambio_escena);
                temp[0] = 128;
                temp[1] = 384;
                temp[2] = 9;
                ds_list_insert(obj_game.cambio_escena, 0, temp);
                scr_go_to_room(temp[2]);
            }
            else if (room == rm_anzota)
            {
                global.escena = 0;
                ds_list_clear(obj_game.cambio_escena);
                temp[0] = 420;
                temp[1] = 530;
                temp[2] = 6;
                ds_list_insert(obj_game.cambio_escena, 0, temp);
                scr_go_to_room(temp[2]);
            }
            
            count = 4;
        }
    }
}
else
{
    count = 0;
}

depth = -y;
