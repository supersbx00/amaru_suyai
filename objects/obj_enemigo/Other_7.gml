if (sprite_index == spr_enemigo_battle_atk)
{
    image_speed = 0.3;
    sprite_index = spr_enemigo_battle_stand;
    obj_battleController.dueloFin = 1;
}

if (sprite_index == spr_enemigo_battle_danho)
{
    sprite_index = spr_enemigo_battle_stand;
    image_speed = 0.3;
    obj_battleController.dueloFin = 1;
}

if (sprite_index == spr_enemigo_battle_defeat)
{
    phy_active = 0;
    image_speed = 0;
    image_index = 5;
    obj_battleController.enemigosCantidad -= 1;
    alarm[4] = 120;
}
