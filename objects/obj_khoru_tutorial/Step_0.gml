if (obj_control_tutorial.paso == 25)
{
    x = obj_player.x - 300;
    y = obj_player.y;
}

if (obj_control_tutorial.paso == 26)
{
    if (image_alpha < 1)
    {
        if (audio_is_playing(snd_background) && !audio_is_playing(snd_khoru))
        {
            audio_stop_sound(snd_background);
            audio_play_sound(snd_khoru, 10, true);
        }
        
        image_alpha += 0.1;
    }
}

if (obj_control_tutorial.paso == 27)
{
    if (image_alpha > 0)
        image_alpha -= 0.1;
}

if (obj_control_tutorial.paso == 28)
{
    if (image_alpha < 1)
        image_alpha += 0.1;
    
    x = obj_player.x + 100;
    y = obj_player.y;
}

if (obj_control_tutorial.paso == 29)
{
    if (image_alpha > 0)
        image_alpha -= 0.1;
}

if (obj_control_tutorial.paso == 30)
{
    if (image_alpha < 1)
        image_alpha += 0.1;
    
    x = obj_player.x - 300;
    y = obj_player.y;
}

if (obj_control_tutorial.paso == 31)
{
    if (image_alpha > 0)
        image_alpha -= 0.1;
}

if (obj_control_tutorial.paso == 32)
{
    if (image_alpha < 1)
    {
        if (audio_is_playing(snd_khoru) && !audio_is_playing(snd_background))
        {
            audio_stop_sound(snd_khoru);
            audio_play_sound(snd_background, 10, true);
        }
    }
}
