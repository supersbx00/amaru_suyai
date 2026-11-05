# Tasks

## 1. Guardado y carga

- [x] 1.1 `scr_guardar_recetas:19`: sección `"arpon_hueso"`. Prueba: crear el arpón, guardar, cargar; sigue desbloqueado.
- [x] 1.2 `scr_cargar_logros`: `global.khoru = ini_read_real("Mision", "khoru", 0);`. Prueba: vencer a Khoru, guardar, cargar; sigue vencido.
- [x] 1.3 `scr_cargar_receta:22-24`: `ini_read_real(..., 0)`. Prueba: la receta del anzuelo muestra sus cantidades.

## 2. Batalla y enemigos

- [x] 2.1 `obj_khoru_battle/Step_0:32-44`: `choose(spr_card_moon, spr_card_agua, spr_card_fuego)` y comparaciones por nombre. Prueba: la carta normal de Khoru se ve bien.
- [x] 2.2 `comboCarta_aux[0] = spr_deck_combo` en agua, fuego, luna y Khoru. Prueba: la carta combo enemiga se ve bien.
- [x] 2.3 `obj_khoru_battle/Step_0` (combo): `id1.comboCard_value = 0;` antes del bucle. Prueba: el combo de Khoru no se acumula entre turnos.
- [x] 2.4 `obj_battleController/Alarm_1:16`: `espiritu_agua`. Prueba: premio correcto tras el espíritu de agua.
- [x] 2.5 `obj_player_battle/Alarm_1:23,26`: `<= 5` y `<= 9`. Prueba: la anulación revierte una cura de cualquier valor.
- [x] 2.6 `scr_listCombos:100`: `x`. Prueba: la flecha espiritual mira hacia el lado correcto.
- [x] 2.7 `cont_item/Alarm_0`, `cont_item1/Alarm_0,1,2`: `phy_position_x/y = x/y` tras elegir el punto. Prueba: los ítems no aparecen dentro de paredes.
- [x] 2.8 `scr_colision:13`: `else if`. Diff revisado.

## 3. Inventario, UI y mundo

- [x] 3.1 `obj_inventario/Step_0:3,31`: `mouse_y < 16 + array_length(inventario) * 67`. Prueba: soltar piezas en los slots bajos de la momia.
- [x] 3.2 `obj_game/Create_0:79`: borrar `show_message("entro")`. Prueba: arranque sin `recetas.ini` sin popup.
- [x] 3.3 `scr_controlVisor_diario:89`: `visorRange_max_diario = 5`. Prueba: la pestaña flora/fauna del diario.
- [x] 3.4 `scr_lista_logros_memorin:73`: `k`. Prueba: idem.
- [x] 3.5 `obj_cartel_room/Step_0:1`: `camera_get_view_width(view_camera[0]) / 2`. Prueba: el cartel de la room queda centrado.
- [x] 3.6 `obj_texto_anzota/Create_0:4-6`: `texto[2]`, `final = 3`. Prueba: Anzota muestra 3 frases.

## 4. Cierre

- [x] 4.1 `python3 tools/gml_linter.py scripts/` sin errores nuevos y diff revisado archivo por archivo.
- [x] 4.2 El usuario prueba en el IDE los pasos de cada tarea.
