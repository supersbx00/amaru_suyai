// Cambio de zona con fundido (también al salir del menú de inicio). No durante una batalla, la victoria, Khoru
// del tutorial ni el final: así al volver de una batalla suena la música de donde empezó.
if (!instance_exists(obj_battleController) && !audio_is_playing(snd_win) && !audio_is_playing(snd_khoru) && room != rm_final_morro)
{
    var nueva = musica_zona(room);

    if (nueva != sound)
    {
        if (sound_saliente != -1)
            audio_stop_sound(sound_saliente);

        // Si la música la volvió a tocar otro objeto (Khoru del tutorial), no es sound_inst: se corta sin fundido
        if (!audio_is_playing(sound_inst))
            audio_stop_sound(sound);

        sound_saliente = sound_inst;
        audio_sound_gain(sound_saliente, 0, FADE_MS);
        sound = nueva;
        sound_inst = audio_play_sound(sound, 10, true);
        audio_sound_gain(sound_inst, 0, 0);
        audio_sound_gain(sound_inst, ganancia_zona(room), FADE_MS);
    }
}

// La música que salió se detiene cuando terminó de bajar
if (sound_saliente != -1 && audio_sound_get_gain(sound_saliente) <= 0)
{
    audio_stop_sound(sound_saliente);
    sound_saliente = -1;
}

if (room == rm_final_morro)
{
    if (audio_is_playing(snd_background) && count == 0)
    {
        audio_stop_sound(snd_background);
        sound = snd_final; // antes índice GMS1 4
        sound_inst = audio_play_sound(sound, 10, true);
        count = 1;
    }
}

if (instance_exists(obj_battleController))
{
    if (global.tipo_enemigo != "khoru")
    {
        if (audio_is_playing(sound) && !audio_is_playing(snd_battle))
        {
            audio_stop_sound(sound);

            if (sound_saliente != -1)
            {
                audio_stop_sound(sound_saliente);
                sound_saliente = -1;
            }

            audio_play_sound(snd_battle, 10, true);
        }
    }
}
else if (audio_is_playing(snd_win) && !audio_is_playing(sound))
{
    audio_stop_sound(snd_win);
    sound_inst = audio_play_sound(sound, 10, true);
    audio_sound_gain(sound_inst, ganancia_zona(room), 0);
}
