if (player_cardBreaked || player_danho)
    exit;

if (barHealth > 0)
{
    image_speed = 0.3;
    
    if (barHealth < 50)
        p_hspd = -27;
    else
        p_hspd = -22;
    
    hspd = 0;
    vspd = 0;
    anulable = 0;
    global.proyectil_2 = 1;
    tipo = "especial_luna";
    script_execute(scr_ataque_enemy, tipo);
}
