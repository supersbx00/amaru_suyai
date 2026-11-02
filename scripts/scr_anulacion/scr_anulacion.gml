function scr_anulacion() {
if (global.v_player > 0 && global.v_enemy > 0)
{
    if (global.v_player > global.v_enemy)
    {
        // El duelo es contra la carta del enemigo que tiene el turno
        var rival = scr_batalla_enemigo_duelo();
        
        if (rival != noone)
            rival.anulable = 1;
    }
    
    if (global.v_player < global.v_enemy)
    {
        if (instance_exists(obj_player_battle))
            obj_player_battle.anulable = 1;
    }
}
}
