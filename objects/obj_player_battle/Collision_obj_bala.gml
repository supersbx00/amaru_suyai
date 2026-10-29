// Con el escudo de Wanku no hay daño: Amaru sigue con su animación
if (other.creador != "player1" && ancestral == 0 && !instance_exists(obj_escudo_tuto))
{
    sprite_index = spr_amaru_battle_danho;
    image_speed = 0.2;
}
