function scr_batalla_ia() {
cartaPlayer = argument0;
global.ataque_player1 = cartaPlayer;
ataque = cartaPlayer[2];
danho = cartaPlayer[1];

if (cartaPlayer[0] == 4)
{
    obj_enemigo.player_cardBreaked = 1;
    obj_enemigo.anulable = 0;
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
