draw_self();
draw_set_halign(fa_center);
draw_sprite(spr_menuBase, 1, (room_width / 1.6) + 60, (room_height / 2) - 30);

for (var i = 0; i < array_length(menuInicial); i++)
    draw_sprite(spr_maderuchaMenu, 1, (room_width / 1.6) + 60, ((room_height / 2) - 50) + (menuInicial_paso * i));

draw_sprite(spr_newGame, 1, (room_width / 1.6) + 60, (room_height / 2) - 50);
draw_sprite(spr_momificar, 1, (room_width / 1.6) + 60, ((room_height / 2) - 50) + menuInicial_paso);
draw_sprite(spr_loadGame, 1, (room_width / 1.6) + 60, ((room_height / 2) - 50) + (menuInicial_paso * 2));
draw_sprite(spr_credito, 1, (room_width / 1.6) + 60, ((room_height / 2) - 50) + (menuInicial_paso * 3));

var sprCursor = menuInicial_spr[menuInicial_cursor];
var anchoCursor = (sprite_get_bbox_left(sprCursor) - sprite_get_bbox_right(sprCursor)) / 1.5;
var yCursor = ((room_height / 2) - 50) + (menuInicial_cursor * menuInicial_paso);
draw_sprite(spr_cursorMenu_inicial, -1, ((room_width / 1.6) + 60) - anchoCursor, yCursor);
draw_sprite(spr_cursorMenu_inicial2, -1, (room_width / 1.6) + 60 + anchoCursor, yCursor);
