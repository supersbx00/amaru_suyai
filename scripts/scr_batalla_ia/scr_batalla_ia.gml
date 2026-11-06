function scr_batalla_ia() {
cartaPlayer = argument0;
global.ataque_player1 = cartaPlayer;
ataque = cartaPlayer[2];
danho = cartaPlayer[1];

if (cartaPlayer[0] == spr_cardsNull) // carta null: paraliza al enemigo (antes índice GMS1 4)
{
    // Aturde a todo el grupo: con uno solo, el que no tenía el turno seguía atacando
    with (obj_enemigo)
    {
        if (barHealth > 0)
        {
            player_cardBreaked = 1;
            anulable = 0;
        }
    }
    
    // Al tercer uso deja de volver con la recarga (aux_playerDeck es la mano que repone)
    anulacion_usos += 1;
    
    if (anulacion_usos >= 3)
    {
        var p = ds_list_find_index(aux_playerDeck, cartaPlayer);
        
        if (p != -1)
            ds_list_delete(aux_playerDeck, p);
    }
}

if (cartaPlayer[3] == "rojo")
{
    with (obj_player_battle)
    {
        if (!alarmTrigger)
        {
            tipo = "normal";
            can_atk = 0;
            alarm[0] = 4;
            alarmTrigger = 1;
        }
    }
}

if (cartaPlayer[3] == "azul")
{
    with (obj_player_battle)
    {
        if (!alarmTrigger)
        {
            can_atk = 0;
            alarm_set(1, 10);
            alarmTrigger = 1;
        }
    }
}

if (cartaPlayer[3] == "especial_fuego")
{
    with (obj_player_battle)
    {
        if (!alarmTrigger)
        {
            tipo = "especial_fuego";
            can_atk = 0;
            alarm_set(0, 10);
            alarmTrigger = 1;
        }
    }
}

if (cartaPlayer[3] == "especial_agua")
{
    with (obj_player_battle)
    {
        if (!alarmTrigger)
        {
            tipo = "especial_agua";
            can_atk = 0;
            alarm_set(0, 10);
            alarmTrigger = 1;
        }
    }
}

if (cartaPlayer[3] == "especial_luna")
{
    with (obj_player_battle)
    {
        if (!alarmTrigger)
        {
            tipo = "especial_luna";
            can_atk = 0;
            alarm_set(0, 10);
            alarmTrigger = 1;
        }
    }
}

if (cartaPlayer[3] == "multicombo")
{
    with (obj_player_battle)
    {
        if (!alarmTrigger)
        {
            alarm_set(3, 10);
            alarmTrigger = 1;
        }
    }
}

if (cartaPlayer[3] == "unicombo")
{
    with (obj_player_battle)
    {
        if (!alarmTrigger)
        {
            alarm_set(2, 3);
            alarmTrigger = 1;
        }
    }
}
}
