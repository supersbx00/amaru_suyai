if (sprite_index == spr_tojone_atack)
{
    image_speed = 0.3;
    sprite_index = spr_tojone_stand;
    obj_battleController.dueloFin = 1;
}

if (sprite_index == spr_tojone_danho)
{
    sprite_index = spr_tojone_stand;
    image_speed = 0.3;
    obj_battleController.dueloFin = 1;
}

if (sprite_index == spr_tojone_muerte)
{
    image_speed = 0;
    image_index = 5;
    // Una sola vez por enemigo, aunque la animación de caída se repita (con varios enemigos daba la victoria antes de tiempo)
    if (!contado_muerte)
    {
        contado_muerte = 1;
        obj_battleController.enemigosCantidad -= 1;
    }
}
