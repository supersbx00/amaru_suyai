hspeed = hspd;
phy_position_x += hspd;

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

if (instance_exists(obj_enemigo))
{
    if (creador == "enemy" && obj_enemigo.player_cardBreaked == 1)
        instance_destroy();
    else if (creador == "enemy" && obj_enemigo.anulable == 1)
        instance_destroy();
}
