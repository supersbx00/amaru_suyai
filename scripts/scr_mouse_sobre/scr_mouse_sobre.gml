function scr_mouse_sobre(_spr, _x, _y, _xs, _ys) {
// _spr = sprite, _x/_y = posición donde se dibuja, _xs/_ys = escala x/y
// Devuelve si el mouse está sobre la caja de colisión (bbox) del sprite tal como se dibuja.
var spr = _spr;
var xs = _xs;
var ys = _ys;
var x1 = _x + ((sprite_get_bbox_left(spr) - sprite_get_xoffset(spr)) * xs);
var x2 = _x + ((sprite_get_bbox_right(spr) + 1 - sprite_get_xoffset(spr)) * xs);
var y1 = _y + ((sprite_get_bbox_top(spr) - sprite_get_yoffset(spr)) * ys);
var y2 = _y + ((sprite_get_bbox_bottom(spr) + 1 - sprite_get_yoffset(spr)) * ys);
return point_in_rectangle(mouse_x, mouse_y, min(x1, x2), min(y1, y2), max(x1, x2), max(y1, y2));
}
