if (instance_exists(obj_player_battle))
{
    // Con el escudo arriba, la carta de Amaru no se rompe
    if (!obj_player_battle.ancestral && obj_player_battle.escudo_activo <= 0)
    {
        obj_player_battle.player_cardBreaked = 1;
        obj_player_battle.anulable = 0;
    }
}
