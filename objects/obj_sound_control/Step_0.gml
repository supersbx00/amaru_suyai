// Fuera del menú de inicio, la música del menú pasa a la de fondo
if (sound == snd_espiritus && room != rm_menu)
{
    audio_stop_sound(snd_espiritus);
    sound = snd_background;
    audio_play_sound(sound, 10, true);
}

if (room == rm_final_morro)
{
    if (audio_is_playing(snd_background) && count == 0)
    {
        audio_stop_sound(snd_background);
        sound = snd_final; // antes índice GMS1 4
        audio_play_sound(sound, 10, true);
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
            audio_play_sound(snd_battle, 10, true);
        }
    }
}
else if (audio_is_playing(snd_win) && !audio_is_playing(sound))
{
    audio_stop_sound(snd_win);
    audio_play_sound(sound, 10, true);
}
