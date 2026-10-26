id1 = id;

if (creador != other.creador)
{
    if (tipo != other.tipo)
    {
        if (tipo == "fuego" && other.tipo == "agua")
            instance_destroy();
        else if (tipo == "agua" && other.tipo == "rayo")
            instance_destroy();
        else if (tipo == "rayo" && other.tipo == "fuego")
            instance_destroy();
        else if (danho <= other.danho)
            instance_destroy();
    }
    else if (danho <= other.danho)
    {
        instance_destroy();
    }
}

if (instance_exists(obj_player_battle))
{
    if (creador == "player1" && obj_player_battle.player_cardBreaked == 1)
        instance_destroy();
}
