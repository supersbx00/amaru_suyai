draw_self();
draw_set_halign(fa_center);
draw_sprite(spr_menuBase, 1, (room_width / 1.6) + 60, (room_height / 2) - 30);
draw_sprite(spr_maderuchaMenu, 1, (room_width / 1.6) + 60, (room_height / 2) - 50);
draw_sprite(spr_maderuchaMenu, 1, (room_width / 1.6) + 60, (room_height / 2) + 50);
draw_sprite(spr_maderuchaMenu, 1, (room_width / 1.6) + 60, (room_height / 2) + 150);
draw_sprite(spr_newGame, 1, (room_width / 1.6) + 60, (room_height / 2) - 50);
draw_sprite(spr_loadGame, 1, (room_width / 1.6) + 60, (room_height / 2) + 50);
draw_sprite(spr_credito, 1, (room_width / 1.6) + 60, (room_height / 2) + 150);

if (menuInicial_cursor == 0)
{
    draw_sprite(spr_cursorMenu_inicial, -1, ((room_width / 1.6) + 60) - ((sprite_get_bbox_left(spr_newGame) - sprite_get_bbox_right(spr_newGame)) / 1.5), ((room_height / 2) - 50) + (menuInicial_cursor * 100));
    draw_sprite(spr_cursorMenu_inicial2, -1, (room_width / 1.6) + 60 + ((sprite_get_bbox_left(spr_newGame) - sprite_get_bbox_right(spr_newGame)) / 1.5), ((room_height / 2) - 50) + (menuInicial_cursor * 100));
}

if (menuInicial_cursor == 1)
{
    draw_sprite(spr_cursorMenu_inicial, -1, ((room_width / 1.6) + 60) - ((sprite_get_bbox_left(spr_loadGame) - sprite_get_bbox_right(spr_loadGame)) / 1.5), ((room_height / 2) - 50) + (menuInicial_cursor * 100));
    draw_sprite(spr_cursorMenu_inicial2, -1, (room_width / 1.6) + 60 + ((sprite_get_bbox_left(spr_loadGame) - sprite_get_bbox_right(spr_loadGame)) / 1.5), ((room_height / 2) - 50) + (menuInicial_cursor * 100));
}

if (menuInicial_cursor == 2)
{
    draw_sprite(spr_cursorMenu_inicial, -1, ((room_width / 1.6) + 60) - ((sprite_get_bbox_left(spr_multiplayer) - sprite_get_bbox_right(spr_multiplayer)) / 1.5), ((room_height / 2) - 50) + (menuInicial_cursor * 100));
    draw_sprite(spr_cursorMenu_inicial2, -1, (room_width / 1.6) + 60 + ((sprite_get_bbox_left(spr_multiplayer) - sprite_get_bbox_right(spr_multiplayer)) / 1.5), ((room_height / 2) - 50) + (menuInicial_cursor * 100));
}
