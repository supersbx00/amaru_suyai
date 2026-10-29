// El escudo recibe el ataque del enemigo antes de que llegue a Amaru
with (other.id)
{
    if (creador != "player1")
        instance_destroy();
}
