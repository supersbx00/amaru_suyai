if (player_cardBreaked || player_danho)
    exit;

if (barHealth > 0)
{
    image_speed = 0.3;
    sprite_index = spr_tojone_atack;
    p_hspd = -20;
    hspd = 0;
    vspd = 0;
    anulable = 0;
    global.proyectil_2 = 1;
    tipo = "tojone";
    script_execute(scr_ataque_enemy, tipo);
}
