if (instance_exists(obj_enemigo) && count_total == 0)
{
    total = obj_enemigo.barHealth;
    count_total++;
}

if (!instance_exists(obj_control_tutorial) && !instance_exists(obj_escudo_tuto))
{
    if (obj_player_battle.barHealth <= 50 && truco == 1)
    {
        obj_player_battle.escudo_id = instance_create(x + 50, y + 20, obj_escudo_tuto);
        obj_player_battle.create = 1;
    }
}
