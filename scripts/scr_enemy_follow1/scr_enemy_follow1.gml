function scr_enemy_follow1() {
var dist = point_distance(x, y, obj_player.x, obj_player.y);
var dir = point_direction(obj_player.x, obj_player.y, x, y);

if (dist <= 250 && dist > 100 && count == 0)
{
    dx = lengthdir_x(8.203, dir);
    dy = lengthdir_y(4.095, dir);
    phy_position_x -= dx;
    phy_position_y -= dy;
    
    if (dir > 270 && dir <= 359)
    {
        sprite_index = spr_tojone_espalda;
        image_speed = 0.3;
        image_xscale = -1;
    }
    else if (dir > 100 && dir <= 180)
    {
        sprite_index = spr_tojone;
        image_speed = 0.3;
        image_xscale = -1;
    }
    else if (dir > 0 && dir <= 90)
    {
        sprite_index = spr_tojone;
        image_speed = 0.3;
        image_xscale = 1;
    }
    else if (dir > 180 && dir <= 270)
    {
        sprite_index = spr_tojone_espalda;
        image_speed = 0.3;
        image_xscale = 1;
    }
}
else
{
    state = scr_start1;
}
}
