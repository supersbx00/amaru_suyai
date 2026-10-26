if (!instance_exists(obj_control_tutorial))
{
    if (instance_exists(obj_enemigo))
    {
        truco = 1;
        
        if (obj_enemigo.barHealth > 100)
            obj_enemigo.barHealth = 100;
    }
}
