// Arpón o cuchilla que toca a alguien. Se llama desde el evento de colisión del proyectil:
// self = el proyectil, other = a quien tocó (Amaru/Suyai controlado o un enemigo del grupo).
function scr_colision() {
if (creador == "player2" || creador == "enemy")
{
    // Con el escudo de Wanku, el ataque desaparece sin hacer daño; con el escudo de Amaru, además aturde a quien lo lanzó
    if (!scr_batalla_escudo_bloquea(id) && !instance_exists(obj_escudo_tuto))
        other.barHealth -= scr_danho(danho);

    instance_destroy();
}

if (creador == "player1" || creador == "player2")
{
    // Solo el enemigo golpeado pierde vida, no "el" primero del grupo
    other.barHealth -= scr_danho(danho);
    instance_destroy();
}
}
