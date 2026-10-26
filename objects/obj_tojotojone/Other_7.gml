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
    obj_battleController.enemigosCantidad -= 1;
}
