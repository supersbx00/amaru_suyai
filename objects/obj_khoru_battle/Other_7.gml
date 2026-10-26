if (sprite_index == spr_khoru_danho)
{
    sprite_index = spr_khoru_run;
    image_speed = 0.3;
    obj_battleController.dueloFin = 1;
}

if (sprite_index == spr_khoru_defeat)
{
    image_speed = 0;
    image_index = 41;
    phy_active = 0;
    alarm[4] = 120;
}
