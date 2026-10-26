if (gamepad_is_connected(0))
    sprite_index = spr_popup_anciana_xbox;
else
    sprite_index = spr_popup_anciana;

push = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_select);
image_speed = 0;

if (!tutorial_popUp)
{
    tutorial_popUp = 1;
    instance_deactivate_all(true);
}

if (push)
{
    count += 1;
    
    if (count <= 1)
        image_index = count;
}

if (count > 1)
{
    instance_activate_all();
    instance_destroy();
}

depth = -1;
