# Proposal

## Why

La auditoría SOLID (`docs/auditoria-solid.md`) encontró bugs de una línea que rompen progreso (guardado del arpón, carga de Khoru), dibujan sprites equivocados (índices GMS1) o dejan código que nunca corre. Se corrigen antes de los refactors para que estos partan de un comportamiento correcto.

## What Changes

Diecisiete correcciones puntuales, todas verificadas en el código:

1. `scr_guardar_recetas:19`: el arpón guarda en su sección `arpon_hueso`.
2. `scr_cargar_logros`: se carga `global.khoru`.
3. `obj_inventario/Step_0:3,31`: el límite del inventario usa celdas de 67 px.
4. `obj_game/Create_0:79`: se borra `show_message("entro")`.
5. `obj_khoru_battle/Step_0`: la carta de Khoru usa `spr_card_moon/agua/fuego`.
6. Enemigos agua, fuego, luna y Khoru: la carta combo usa `spr_deck_combo`.
7. `obj_khoru_battle/Step_0`: el combo reinicia `comboCard_value`.
8. `obj_battleController/Alarm_1:16`: el premio revisa `espiritu_agua`.
9. `obj_player_battle/Alarm_1`: la anulación revierte curas de 1-5 y 6-9.
10. `scr_controlVisor_diario:89`: se fija `visorRange_max_diario`.
11. `scr_lista_logros_memorin:73`: usa el índice del bucle (`k`).
12. `scr_cargar_receta:22-24`: cantidades del anzuelo como número.
13. `obj_cartel_room/Step_0:1`: el ancho de cámara se divide bien.
14. `obj_texto_anzota/Create_0`: se muestra la tercera frase.
15. `scr_listCombos:100`: la flecha creada mira su propia `x`.
16. `cont_item`, `cont_item1`: el ítem aparece donde se revisó la colisión.
17. `scr_colision:13`: `else if`, sin doble daño.

Fuera de alcance (decisión del usuario): pausa en batalla de `scr_pause_control`, el "Ver Cartas" de `obj_pause` y `obj_npc_4`. También los refactors (rooms por nombre, proyectiles), que tienen sus ramas.

## Capabilities

### New Capabilities

Ninguna.

### Modified Capabilities

Ninguna: las correcciones devuelven el comportamiento esperado sin requisitos nuevos (`skip_specs: true`).

## Impact

Solo `.gml` de 01_Partida, 03_Batalla, 04_Enemigos, 05_Inventario_Creacion, 06_Momia (`obj_inventario`), 07_Mundo, 09_UI y `obj_game`. Sin `.yy`, sin recursos nuevos, sin cambios de grupo. Rama `fix/bugs-auditoria`.

Supuesto: en el #9 se asume que `== 5` y `== 9` querían ser `<= 5` y `<= 9`.
