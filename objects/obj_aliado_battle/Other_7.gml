// Caído: se queda en el último cuadro
if (sprite_index == spr_b_defeat)
{
    image_speed = 0;
    image_index = image_number - 1;
    exit;
}

if (sprite_index == spr_b_atk || sprite_index == spr_b_danho || sprite_index == spr_b_cura || sprite_index == spr_b_run)
{
    sprite_index = spr_b_stand;
    image_speed = 0.3;
}
