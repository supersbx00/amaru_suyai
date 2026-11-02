hspeed = hspd;
phy_position_x += hspd;
phy_position_y += vspd;
// Se mueve por posición: un choque con otro cuerpo no lo desvía
phy_speed_x = 0;
phy_speed_y = 0;

if (!trigger && !phy_active)
{
    trigger = 1;
    alarm[0] = 3;
}

if (instance_exists(obj_player_battle))
{
    if (creador == "player1" && obj_player_battle.player_cardBreaked == 1)
        instance_destroy();
    else if (creador == "player1" && obj_player_battle.anulable == 1)
        instance_destroy();
}

// Si al enemigo que lo lanzó lo aturden o le anulan la carta, su ataque desaparece
if (creador == "enemy" && instance_exists(dueno))
{
    if (dueno.player_cardBreaked == 1 || dueno.anulable == 1)
        instance_destroy();
}
