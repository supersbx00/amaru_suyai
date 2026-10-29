// Tutorial: el enemigo no puede caer antes de terminar las ayudas de batalla (paso 25);
// si muriera antes, se volvería a la sala con el tutorial a medias (Wanku invisible, sin evento con Khoru)
if (instance_exists(obj_control_tutorial) && obj_control_tutorial.paso < 25 && instance_exists(obj_enemigo))
{
    if (obj_enemigo.barHealth < 1)
        obj_enemigo.barHealth = 1;
}

if (instance_exists(obj_enemigo) && count_total == 0)
{
    total = obj_enemigo.barHealth;
    count_total++;
}

if (!instance_exists(obj_control_tutorial) && !instance_exists(obj_escudo_tuto))
{
    if (obj_player_battle.barHealth <= 50 && truco == 1 && !escudo_vida_baja_usado)
    {
        escudo_vida_baja_usado = 1;
        obj_player_battle.escudo_id = instance_create(x + 50, y + 20, obj_escudo_tuto);
        obj_player_battle.create = 1;
        obj_player_battle.alarm[6] = 240; // 8 s, igual que el escudo que se recoge (Alarm_6 lo destruye)
    }
}
