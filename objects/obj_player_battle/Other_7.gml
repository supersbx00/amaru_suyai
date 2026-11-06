if (sprite_index == spr_b_atk)
{
    image_speed = 0.3;
    
    if (ancestral == 1)
        sprite_index = spr_amaru_stand_ancestral;
    else
        sprite_index = spr_b_stand;
}

if (sprite_index == spr_b_cura)
{
    image_speed = 0.3;
    
    if (ancestral == 1)
        sprite_index = spr_amaru_stand_ancestral;
    else
        sprite_index = spr_b_stand;
    
    actionActivate = 1;
}

if (sprite_index == spr_b_run)
    sprite_index = spr_b_stand;

if (sprite_index == spr_amaru_ancestral_run)
    sprite_index = spr_amaru_stand_ancestral;

if (sprite_index == spr_b_danho)
    sprite_index = spr_b_stand;

if (sprite_index == spr_b_defeat)
{
    phy_active = 0;
    image_index = image_number - 1;
    image_speed = 0;
}

if (sprite_index == spr_b_carga)
{
    if (ancestral == 1)
        sprite_index = spr_amaru_stand_ancestral;
    else
        sprite_index = spr_b_stand;
}
