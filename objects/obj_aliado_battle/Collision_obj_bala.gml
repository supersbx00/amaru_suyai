// Arpón o cuchilla enemiga: daño (×1,5, scr_danho) y animación de daño
if (!caido && (other.creador == "enemy" || other.creador == "player2"))
{
    barHealth -= scr_danho(other.danho);
    sprite_index = spr_b_danho;
    image_index = 0;
    image_speed = 0.2;
    
    with (other)
        instance_destroy();
}
