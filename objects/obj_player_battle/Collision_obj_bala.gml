// Con el escudo de Wanku o el de Amaru no hay daño: Amaru sigue con su animación
if (other.creador != "player1" && ancestral == 0 && !instance_exists(obj_escudo_tuto) && !scr_batalla_escudo_activo())
{
    sprite_index = spr_b_danho;
    image_speed = 0.2;
}
