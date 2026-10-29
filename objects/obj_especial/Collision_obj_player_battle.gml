if (creador == "enemy")
{
    // Con el escudo de Wanku, el ataque desaparece sin hacer daño
    if (!instance_exists(obj_escudo_tuto))
        other.barHealth -= danho;

    instance_destroy();
}
