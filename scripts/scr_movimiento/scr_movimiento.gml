function scr_movimiento() {
lkey = keyboard_check(vk_left) || gamepad_axis_value(0, gp_axislh) < 0;
rkey = keyboard_check(vk_right) || gamepad_axis_value(0, gp_axislh) > 0;
ukey = keyboard_check(vk_up) || gamepad_axis_value(0, gp_axislv) < 0;
dkey = keyboard_check(vk_down) || gamepad_axis_value(0, gp_axislv) > 0;

if (dkey)
{
    if (ancestral == 1)
        sprite_index = spr_amaru_ancestral_run;
    else
        sprite_index = spr_amaru_battle_run;
    
    image_xscale = 1;
    vspd = 4.25;
    image_speed = 0.3;
}
else if (ukey)
{
    if (ancestral == 1)
        sprite_index = spr_amaru_ancestral_run;
    else
        sprite_index = spr_amaru_battle_run;
    
    image_xscale = 1;
    vspd = -4.25;
    image_speed = 0.3;
}
else if (lkey)
{
    if (ancestral == 1)
        sprite_index = spr_amaru_ancestral_run;
    else
        sprite_index = spr_amaru_battle_run;
    
    image_xscale = 1;
    hspd = -4.25;
    image_speed = 0.3;
}
else if (rkey)
{
    if (ancestral == 1)
        sprite_index = spr_amaru_ancestral_run;
    else
        sprite_index = spr_amaru_battle_run;
    
    image_xscale = 1;
    hspd = 4.25;
    image_speed = 0.3;
}

if ((!rkey && !lkey) || (rkey && lkey))
    hspd = 0;

if ((!ukey && !dkey) || (ukey && dkey))
    vspd = 0;
}
