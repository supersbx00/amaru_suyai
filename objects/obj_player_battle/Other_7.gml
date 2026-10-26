if (sprite_index == spr_amaru_battle_atk)
{
    image_speed = 0.3;
    
    if (ancestral == 1)
        sprite_index = spr_amaru_stand_ancestral;
    else
        sprite_index = spr_amaru_battle_stand;
}

if (sprite_index == spr_amaru_battle_cura)
{
    image_speed = 0.3;
    
    if (ancestral == 1)
        sprite_index = spr_amaru_stand_ancestral;
    else
        sprite_index = spr_amaru_battle_stand;
    
    actionActivate = 1;
}

if (sprite_index == spr_amaru_battle_run)
    sprite_index = spr_amaru_battle_stand;

if (sprite_index == spr_amaru_ancestral_run)
    sprite_index = spr_amaru_stand_ancestral;

if (sprite_index == spr_amaru_battle_danho)
    sprite_index = spr_amaru_battle_stand;

if (sprite_index == spr_amaru_battle_defeat)
{
    phy_active = 0;
    image_index = 5;
    image_speed = 0;
}

if (sprite_index == spr_amaru_battle_carga)
{
    if (ancestral == 1)
        sprite_index = spr_amaru_stand_ancestral;
    else
        sprite_index = spr_amaru_battle_stand;
}
