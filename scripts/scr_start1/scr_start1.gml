function scr_start1() {
var dist = point_distance(x, y, obj_player.x, obj_player.y);

if (dist > 150)
    count = 0;

if (dist > 100 && dist <= 150)
    state = 55;
else if (dist < 100)
    state = 56;
else if (dist > 250)
    state = 54;
}
