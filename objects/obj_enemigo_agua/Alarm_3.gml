if (instance_exists(obj_player_battle))
{
    if (!obj_player_battle.ancestral)
    {
        obj_player_battle.player_cardBreaked = 1;
        obj_player_battle.anulable = 0;
    }
}
