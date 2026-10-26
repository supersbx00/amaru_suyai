if (creador == "player1")
{
    if (obj_player_battle.barHealth < 100)
    {
        obj_player_battle.barHealth += 20;
        
        if (obj_player_battle.barHealth > 100)
            obj_player_battle.barHealth = 100;
    }
}

instance_destroy();
