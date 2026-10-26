dist = point_distance(x, y, obj_player.x, obj_player.y);
image_speed = 0.3;
push = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);

if (dist <= 100)
{
    if (push && count == 0)
    {
        if (instance_number(obj_enemigo_normal) != 0)
        {
            if (!instance_exists(obj_dialogo))
            {
                with (instance_create(x, y, obj_dialogo))
                    npc = "espiritu_agua1";
                
                count = 2;
            }
        }
        else if (!instance_exists(obj_dialogo))
        {
            if (global.espiritu_agua == 0)
            {
                with (instance_create(x, y, obj_dialogo))
                {
                    npc = "espiritu_agua2";
                    global.enable_battle = 1;
                    global.enable_player = 1;
                }
                
                count = 1;
            }
        }
    }
    
    if (keyboard_check_pressed(ord("Z")) && global.espiritu_agua == 1 && count == 5)
    {
        if (!instance_exists(obj_dialogo))
        {
            if (global.espiritu_agua == 1)
            {
                with (instance_create(x, y, obj_dialogo))
                    npc = "espiritu_agua3";
                
                count = 4;
            }
        }
    }
}
else if (global.espiritu_agua == 1)
{
    count = 5;
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
        global.tipo_enemigo = "espiritu_agua";
        global.escena = 1;
        scr_go_to_room(4);
        count = 5;
    }
}

if (count == 3)
{
    if (!instance_exists(obj_dialogo))
    {
        global.escena = 0;
        temp[0] = 128;
        temp[1] = 416;
        temp[2] = 12;
        ds_list_insert(obj_game.cambio_escena, 0, temp);
        scr_go_to_room(temp[2]);
        count = 4;
    }
}
