push = keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_start);
push_help = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_select);

if (push && global.pause <= 1)
{
    if (!pauseBattle)
    {
        global.pause = 1;
        pauseBattle = 1;
        instance_deactivate_all(true);
    }
    else
    {
        pauseBattle = 0;
        global.pause = 0;
        instance_activate_all();
    }
}

if (push_help && global.pause == 0 && !instance_exists(obj_control_tutorial))
{
    global.pause = 3;
    
    if (!instance_exists(obj_tutorial_popUp1))
    {
        id_popup = instance_create(x, y, obj_tutorial_popUp1);
        
        with (id_popup)
            valor_popUp = "atacar";
        
        instance_deactivate_all(true);
        instance_activate_object(id_popup);
    }
}
