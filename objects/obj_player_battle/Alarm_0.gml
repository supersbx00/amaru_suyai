if (!player_cardBreaked)
{
    image_speed = 0.3;
    sprite_index = spr_amaru_battle_atk;
}

p_hspd = 20;
hspd = 0;
vspd = 0;
global.proyectil_1 = 1;
script_execute(scr_ataque, tipo);
