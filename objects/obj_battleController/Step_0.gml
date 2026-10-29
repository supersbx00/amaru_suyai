global.win = win;

// F3: muestra u oculta las formas de colisión (prueba de que coinciden con los sprites)
if (keyboard_check_pressed(vk_f3))
    global.ver_colisiones = !global.ver_colisiones;

// Primera batalla fuera del tutorial con la vida baja: se recuerda el combo una sola vez por partida
if (room == rm_battle && !instance_exists(obj_control_tutorial) && !global.combo_recordado && !instance_exists(obj_tutorial_popUp) && !instance_exists(obj_tutorial_popUp1))
{
    if (obj_player_battle.barHealth > 0 && obj_player_battle.barHealth <= 30)
    {
        global.combo_recordado = 1;
        
        with (instance_create(camera_get_view_x(view_camera[0]) + 660, camera_get_view_y(view_camera[0]) + 368, obj_tutorial_popUp))
        {
            valor_popUp = "combo";
            sprite_index = spr_popUp_Combo; // desde el primer cuadro (su Step corre recién en el siguiente)
        }
    }
}

if (obj_player_battle.barHealth < 20)
    truco = 1;

if (enemigosCantidad == 0)
{
    win = 1;
    
    if (audio_is_playing(snd_battle))
    {
        audio_stop_sound(snd_battle);
        audio_play_sound(snd_win, 10, true);
    }
    
    global.enable_player = 0;
    global.enable_battle = 0;
    obj_player_battle.phy_active = 0;
    enemigosCantidad = -1;
    
    if (global.tipo_enemigo == "espiritu_luna")
    {
        global.espiritu_luna = 1;
        alarm[1] = 30;
    }
    else if (global.tipo_enemigo == "espiritu_agua")
    {
        global.espiritu_agua = 1;
        alarm[1] = 30;
    }
    else if (global.tipo_enemigo == "espiritu_fuego")
    {
        global.espiritu_fuego = 1;
        alarm[1] = 30;
    }
    else if (global.tipo_enemigo == "khoru")
    {
        global.khoru = 1;
        alarm[1] = 30;
    }
    else
    {
        alarm[0] = 30;
    }
}

if (instance_number(obj_dialogo_premio) != 0)
    dialogo = 1;

if (dialogo == 1 && alarm_trigger == 1)
{
    if (instance_number(obj_dialogo_premio) == 0)
    {
        if (!ds_list_empty(obj_game.escena_grabada))
        {
            alarm[2] = 60;
            alarm_trigger = 0;
        }
    }
}

if (obj_player_battle.barHealth <= 0 || obj_enemigo.barHealth <= 0)
{
    phase1 = 0;
    phase2 = 0;
    phase3 = 1;
}

if (phase3)
{
    if (obj_player_battle.barHealth <= 0 && alarm_trigger == 1)
    {
        obj_player_battle.sprite_index = spr_amaru_battle_defeat;
        obj_player_battle.enable_battle = 0;
        obj_player_battle.enable_player = 0;
        
        if (audio_is_playing(snd_battle))
        {
            audio_stop_sound(snd_battle);
            audio_play_sound(snd_defeat, 10, true);
        }
        
        defeat = 1;
        alarm_trigger = 0;
        alarm[3] = 150;
    }
    
    if (obj_enemigo.barHealth <= 0)
    {
        obj_enemigo.sprite_index = spr_enemigo_battle_defeat;
        obj_enemigo.barHealth = 0;
        obj_enemigo.phy_active = 0;
    }
}

depth = -1 * room_height;
script_execute(scr_anulacion);
