if (!player_cardBreaked)
{
    image_speed = 0.3;
    sprite_index = spr_b_atk;
}

p_hspd = 30; // Amaru ya no se detiene al lanzar: sigue moviéndose a media rapidez
global.proyectil_1 = 1;
script_execute(scr_ataque, tipo);
