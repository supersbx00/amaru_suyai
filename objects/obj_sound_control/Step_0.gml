if (room == rm_final_morro)
{
    if (audio_is_playing(snd_background) && count == 0)
    {
        audio_stop_sound(snd_background);
        sound = 4;
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
