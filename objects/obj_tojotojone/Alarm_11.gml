ds_list_clear(ComboArray);
cartaUsada = undefined;
escoger = 0;
alarmTrigger = 0;
global.v_enemy = -1;

// Terminó su ataque: le toca al siguiente enemigo del grupo
if (scr_batalla_mi_turno())
    scr_batalla_turno_siguiente();
