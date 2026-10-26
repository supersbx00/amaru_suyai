dist = point_distance(x, y, obj_player.x, obj_player.y);
image_speed = 0.3;
push = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);

if (dist <= 100)
{
    if (push && count == 0)
    {
        if (global.espiritu_luna == 0 && global.espiritu_agua == 0)
        {
            if (!instance_exists(obj_dialogo))
            {
                with (instance_create(x, y, obj_dialogo))
                    npc = "espiritu_fuego1";
                
                count = 2;
            }
        }
        else if (global.espiritu_agua == 1)
        {
            if (!instance_exists(obj_dialogo))
            {
                with (instance_create(x, y, obj_dialogo))
                {
                    npc = "espiritu_fuego2";
                    global.enable_battle = 1;
                    global.enable_player = 1;
                }
                
                count = 1;
            }
        }
    }
    
    if (keyboard_check_pressed(ord("Z")) && global.espiritu_fuego == 1 && count == 4)
    {
        if (!instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
                npc = "espiritu_fuego3";
            
            count = 3;
        }
    }
}
else if (global.espiritu_fuego == 1)
{
    count = 4;
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
        global.tipo_enemigo = "espiritu_fuego";
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
        temp[0] = 257;
        temp[1] = 821;
        temp[2] = 13;
        ds_list_insert(obj_game.cambio_escena, 0, temp);
        scr_go_to_room(temp[2]);
        count = 4;
    }
}
