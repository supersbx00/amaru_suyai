push = keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_start);

if (push)
    game_restart();
