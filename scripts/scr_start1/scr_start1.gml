function scr_start1() {
var dist = point_distance(x, y, obj_player.x, obj_player.y);

if (dist > 150)
    count = 0;

if (dist > 100 && dist <= 150)
    state = scr_enemy_follow1;
else if (dist < 100)
    state = scr_enemy_static1;
else if (dist > 250)
    state = scr_enemy_static_all1;
}
