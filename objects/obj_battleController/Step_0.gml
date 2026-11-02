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

// Victoria: todo el grupo enemigo derrotado
if (enemigosCantidad == 0 && scr_batalla_vida_grupo() <= 0)
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
    
    // Desafío de Khoru en rm_momificar (solo se activa ahí): al volver entrega el premio
    if (global.desafio_camarones == 2 && global.tipo_enemigo == "tojone")
        global.desafio_camarones = 3;
    
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

// Equipo con Suyai: si cae el personaje controlado y el otro sigue en pie, el control pasa solo al otro.
// Tab, gatillo derecho (RT) o clic en el retrato del compañero: cambiar de personaje.
if (cura_suyai > 0)
    cura_suyai -= 1;

if (global.cambio_destello > 0)
    global.cambio_destello -= 1;

if (instance_exists(obj_aliado_battle))
{
    if (obj_player_battle.barHealth <= 0)
        scr_batalla_cambiar(1);
    else if (keyboard_check_pressed(vk_tab) || gamepad_button_check_pressed(0, gp_shoulderrb) || (mouse_check_button_pressed(mb_left) && scr_batalla_retrato_bajo_mouse()))
        scr_batalla_cambiar();
}

// El enemigo del turno murió o desapareció: le toca al siguiente vivo
if (enemigo_turno != noone && (!instance_exists(enemigo_turno) || enemigo_turno.barHealth <= 0))
    scr_batalla_turno_siguiente();

// Fin de la pelea: cayó todo el equipo (Amaru y Suyai) o todo el grupo enemigo
if (scr_batalla_equipo_vivo() == 0 || scr_batalla_vida_grupo() <= 0)
{
    phase1 = 0;
    phase2 = 0;
    phase3 = 1;
}

if (phase3)
{
    if (scr_batalla_equipo_vivo() == 0 && alarm_trigger == 1)
    {
        obj_player_battle.sprite_index = obj_player_battle.spr_b_defeat;
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
    
    with (obj_enemigo)
    {
        if (barHealth <= 0)
        {
            if (object_index == obj_enemigo)
                sprite_index = spr_enemigo_battle_defeat;
            
            barHealth = 0;
            phy_active = 0;
        }
    }
}

depth = -1 * room_height;
script_execute(scr_anulacion);
