function scr_player_move() {
k_left = keyboard_check(vk_left) || gamepad_axis_value(0, gp_axislh) < 0;
k_right = keyboard_check(vk_right) || gamepad_axis_value(0, gp_axislh) > 0;
k_up = keyboard_check(vk_up) || gamepad_axis_value(0, gp_axislv) < 0;
k_down = keyboard_check(vk_down) || gamepad_axis_value(0, gp_axislv) > 0;

if (k_down)
{
    vspd = 3.15;
    hspd = 6.31;
    sprite_index = spr_amaru_walk_rightDown;
    image_xscale = 1;
    image_speed = 0.3;
}
else if (k_up)
{
    vspd = -3.15;
    hspd = -6.31;
    sprite_index = spr_amaru_walk_rightTop;
    image_xscale = -1;
    image_speed = 0.3;
}
else if (k_left)
{
    vspd = 3.15;
    hspd = -6.31;
    sprite_index = spr_amaru_walk_rightDown;
    image_xscale = -1;
    image_speed = 0.3;
}
else if (k_right)
{
    vspd = -3.15;
    hspd = 6.31;
    sprite_index = spr_amaru_walk_rightTop;
    image_xscale = 1;
    image_speed = 0.3;
}
else if (keyboard_check_released(vk_right) || !k_right)
{
    vspd = 0;
    hspd = 0;
}
else if (keyboard_check_released(vk_up) || !k_up)
{
    vspd = 0;
    hspd = 0;
}
else if (keyboard_check_released(vk_down) || !k_down)
{
    vspd = 0;
    hspd = 0;
}
else if (keyboard_check_released(vk_left) || !k_left)
{
    vspd = 0;
    hspd = 0;
}
}
