function scr_anulacion() {
if (global.v_player > 0 && global.v_enemy > 0)
{
    if (global.v_player > global.v_enemy)
    {
        if (instance_exists(obj_enemigo))
            obj_enemigo.anulable = 1;
    }
    
    if (global.v_player < global.v_enemy)
    {
        if (instance_exists(obj_player_battle))
            obj_player_battle.anulable = 1;
    }
}
}
