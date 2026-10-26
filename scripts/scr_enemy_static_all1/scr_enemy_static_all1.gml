function scr_enemy_static_all1() {
var dist = point_distance(x, y, obj_player.x, obj_player.y);
playerx = obj_player.x;
playery = obj_player.y;
enemyx = x;
enemyy = y;

if ((playery < enemyy && playerx < enemyx) && dist > 250)
    sprite_index = spr_tojone_back_stand;

if ((playery > enemyy && playerx > enemyx) && dist > 250)
    sprite_index = spr_tojone_stand;

if ((playery > enemyy && playerx < enemyx) && dist > 250)
    sprite_index = spr_tojone_stand;

if ((playery < enemyy && playerx > enemyx) && dist > 250)
    sprite_index = spr_tojone_back_stand;
else if (dist < 250)
    state = 53;
}
