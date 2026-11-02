cartaUsada = undefined;
escoger = 0;
alarmTrigger = 0;

// Terminó su ataque: le toca al siguiente enemigo del grupo
if (scr_batalla_mi_turno())
    scr_batalla_turno_siguiente();
