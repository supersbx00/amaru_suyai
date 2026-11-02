draw_sprite(spr_battle_healthBg, 1, 130, 35);

if (instance_exists(obj_player_battle))
    draw_sprite_ext(spr_battle_healthInner, 1, 130, 35, obj_player_battle.barHealth / 100, 1, 0, c_white, 1);

draw_sprite(spr_battle_vida, 1, 100, 15);
scr_batalla_escudo_barra(130, 58); // recarga del escudo, bajo la vida
// Cabeza del personaje que maneja el jugador; debajo, el compañero (con Suyai unida)
if (instance_exists(obj_player_battle))
    scr_batalla_cabeza(obj_player_battle.personaje, 70, 45, 1);
else
    draw_sprite(spr_amaru_battle_head, 1, 70, 45);

scr_batalla_equipo_hud();
draw_sprite(spr_battle_healthBg, 1, (room_width / 2) + 302, 35);

// Vida de todo el grupo enemigo
if (instance_exists(obj_enemigo) && total > 0)
    draw_sprite_ext(spr_battle_healthInner, 1, (room_width / 2) + 477, 35, -scr_batalla_vida_grupo() / total, 1, 0, c_white, 1);

draw_sprite_ext(spr_battle_vida, 1, (room_width / 2) + 508, 15, -1, 1, 0, c_white, 1);
draw_sprite(spr_enemigo_battle_head, 1, (room_width / 2) + 538, 45);

if (win == 1 && !instance_exists(obj_control_tutorial))
    draw_sprite(spr_victoria, 1, 653, 350);

if (defeat == 1)
    draw_sprite(spr_defeat, 1, 653, 350);

if (global.ver_colisiones)
    physics_world_draw_debug(phy_debug_render_shapes);
