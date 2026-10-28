function scr_movimiento() {
// Movimiento en batalla: W/A/S/D, flechas o stick izquierdo, con diagonales a la misma rapidez
lkey = keyboard_check(ord("A")) || keyboard_check(vk_left) || gamepad_axis_value(0, gp_axislh) < 0;
rkey = keyboard_check(ord("D")) || keyboard_check(vk_right) || gamepad_axis_value(0, gp_axislh) > 0;
ukey = keyboard_check(ord("W")) || keyboard_check(vk_up) || gamepad_axis_value(0, gp_axislv) < 0;
dkey = keyboard_check(ord("S")) || keyboard_check(vk_down) || gamepad_axis_value(0, gp_axislv) > 0;

var eje_x = rkey - lkey;
var eje_y = dkey - ukey;
var rapidez = 4.25;

if (eje_x != 0 && eje_y != 0)
    rapidez *= 0.7071;

hspd = eje_x * rapidez;
vspd = eje_y * rapidez;

if (eje_x != 0 || eje_y != 0)
{
    if (ancestral == 1)
        sprite_index = spr_amaru_ancestral_run;
    else
        sprite_index = spr_amaru_battle_run;

    image_xscale = 1;
    image_speed = 0.3;
}
}
