function scr_cambiaSprite() {
with (obj_player)
{
    if (sprite_index == spr_amaru_walk_rightDown)
        sprite_index = spr_amaru_stand_rightDown;
    
    if (sprite_index == spr_amaru_walk_rightTop)
        sprite_index = spr_amaru_stand_rightTop;
}
}
