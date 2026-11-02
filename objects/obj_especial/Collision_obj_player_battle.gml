if (creador == "enemy")
{
    // Con el escudo de Wanku, el ataque desaparece sin hacer daño; con el escudo de Amaru, además aturde a quien lo lanzó
    if (!scr_batalla_escudo_bloquea(id) && !instance_exists(obj_escudo_tuto))
        other.barHealth -= scr_danho(danho);

    instance_destroy();
}
