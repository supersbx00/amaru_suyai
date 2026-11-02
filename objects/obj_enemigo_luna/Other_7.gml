if (sprite_index == spr_enemigo_battle_atk)
{
    image_speed = 0.3;
    sprite_index = spr_enemigo_battle_stand;
    obj_battleController.dueloFin = 1;
}

if (sprite_index == spr_moon_danho)
{
    sprite_index = spr_moon;
    image_speed = 0.3;
    obj_battleController.dueloFin = 1;
}

if (sprite_index == spr_moon_defeat)
{
    image_speed = 0;
    image_index = 0;
    // Una sola vez por enemigo, aunque la animación de caída se repita (con varios enemigos daba la victoria antes de tiempo)
    if (!contado_muerte)
    {
        contado_muerte = 1;
        obj_battleController.enemigosCantidad -= 1;
    }
    phy_active = 0;
    alarm[4] = 120;
}
