if (player_cardBreaked || player_danho)
    exit;

if (barHealth > 0)
{
    image_speed = 0.3;
    sprite_index = spr_enemigo_battle_atk;
    // Arpón más lento mientras el tutorial de batalla enseña los controles
    if (instance_exists(obj_control_tutorial) && obj_control_tutorial.paso < 25)
        p_hspd = -15;
    else
        p_hspd = -22;
    hspd = 0;
    vspd = 0;
    anulable = 0;
    global.proyectil_2 = 1;
    tipo = "normal";
    script_execute(scr_ataque_enemy, tipo);
}
