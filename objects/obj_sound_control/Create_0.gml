// game_restart (tras una derrota o el final) no detiene el audio: se corta todo para no arrastrar snd_defeat al menú
audio_stop_all();

// Música de cada zona: snd_espiritus en el menú de inicio, en los camarones, en rm_momificar y en el minijuego (rm_Momia); snd_background en el resto del mapa.
// Para dar música propia a otra zona basta con agregarla aquí.
musica_zona = function(sala) {
    if (sala == rm_menu || sala == rm_camarones || sala == rm_Momia || sala == rm_momificar)
        return snd_espiritus;
    return snd_background;
};

// En camarones y en la momificación snd_espiritus (archivo a 1.0) se baja a 0.5 para igualar a snd_background (archivo a 0.5)
ganancia_zona = function(sala) {
    return (sala == rm_camarones || sala == rm_Momia || sala == rm_momificar) ? 0.5 : 1;
};

FADE_MS = 1000;
sound = musica_zona(room); // música actual de la zona (antes índice GMS1 1)
sound_inst = audio_play_sound(sound, 10, true);
audio_sound_gain(sound_inst, ganancia_zona(room), 0);
sound_saliente = -1; // instancia que se está apagando con fundido
count = 0;
