function scr_start() {
var dist = point_distance(x, y, obj_player.x, obj_player.y);

if (dist > 150)
    count = 0;

if (dist > 100 && dist <= 150)
    state = 51;
else if (dist < 100)
    state = 52;
else if (dist > 250)
    state = 50;
}
