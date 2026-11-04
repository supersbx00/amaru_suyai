# Mapa de objetos y rooms

Este documento es una **propuesta**: todavía no se aplicó nada. Sirve para revisar y corregir dónde iría cada objeto antes de reorganizar los grupos de GameMaker.

Datos tomados del proyecto el 2026-11-04: 151 objetos y 17 rooms. Los archivos físicos y las rutas del `.yyp` no cambian: solo cambia el grupo que se ve en GameMaker.

## 1. Cómo leer este mapa

Un objeto no pertenece a una room. El objeto es un molde, y la room solo contiene copias. Por eso cada objeto se ordena por **lo que hace**:

1. **¿Qué hace?** Eso define su feature: Momia, Batalla, Jugador.
2. **¿Es parte del escenario de un lugar?** Va en `07_Mundo`.
3. **¿Lo usan varias features y no tiene otro dueño?** Va en `00_Core`.

**Confianza de la propuesta:**

- **Alta:** el grupo coincide con su uso visible (rooms, quién lo crea o sus objetos hijos).
- **Media:** se decidió en parte por el nombre, o tiene más de una ubicación razonable. Conviene que lo mires.
- **Revisar:** no está colocado en ninguna room, ningún código detectado lo crea y no tiene hijos. **No significa que se pueda borrar.**

## 2. Resumen

| Dónde aparece | Objetos |
|---|---|
| En una sola room | 53 |
| En varias rooms | 20 |
| En ninguna, lo crea el código | 58 |
| En ninguna, es padre de otros | 6 |
| En ninguna y sin creación detectada | 14 |

| Confianza | Objetos |
|---|---|
| Alta | 115 |
| Media | 22 |
| Revisar | 14 |

## 3. Objetos por grupo propuesto

| Grupo | Objetos | Cantidad |
|---|---|---|
| `00_Core/Hubs` | `obj_game`, `obj_morral`, `obj_sound_control` | 3 |
| `01_Partida/Transiciones` | `obj_cartel_room`, `obj_change`, `obj_change1`, `obj_change3`, `obj_change31`, `obj_transition` | 6 |
| `02_Jugador/Controlador` | `obj_player` | 1 |
| `02_Jugador/Input` | `obj_marca_clic` | 1 |
| `02_Jugador/Personajes` | `obj_companero` | 1 |
| `03_Batalla/Flujo` | `obj_battleController`, `obj_dialogo_premio` | 2 |
| `03_Batalla/Combatientes` | `obj_aliado_battle`, `obj_player_battle` | 2 |
| `03_Batalla/Proyectiles` | `obj_bala`, `obj_cuchilla`, `obj_especial`, `obj_flecha`, `obj_flecha_espiritual`, `obj_proyectil`, `obj_proyectilHealth`, `obj_proyectil_ice`, `obj_proyectil_ligth`, `obj_seguir`, `obj_transparente` | 11 |
| `03_Batalla/Cartas` | `obj_card`, `obj_escudo_tuto` | 2 |
| `03_Batalla/Items` | `cont_item`, `cont_item1`, `obj_go`, `obj_go_agua`, `obj_go_fuego`, `obj_go_luna`, `obj_item` | 7 |
| `04_Enemigos/Tipos` | `obj_boss`, `obj_enemigo`, `obj_enemigo_agua`, `obj_enemigo_fuego`, `obj_enemigo_luna`, `obj_khoru_battle`, `obj_tojotojone` | 7 |
| `04_Enemigos/En_Mapa` | `obj_enemigo_normal`, `obj_enemigo_normal1`, `obj_npc_corrupto` | 3 |
| `05_Inventario_Creacion/Materiales` | `obj_materiales` | 1 |
| `06_Momia/Entrada` | `obj_mouse` | 1 |
| `06_Momia/Pasos` | `obj_arcilla_untar`, `obj_controlador`, `obj_desp`, `obj_inventario`, `obj_mensaje` | 5 |
| `06_Momia/Piezas` | `obj_cerebro`, `obj_corazon`, `obj_craneo`, `obj_cuerpo`, `obj_esqueleto`, `obj_esternon`, `obj_higado`, `obj_huesos`, `obj_intestino`, `obj_organo`, `obj_pieza`, `obj_pulmon`, `obj_snap` | 13 |
| `07_Mundo/Limites` | `obj_pared`, `obj_pared_32`, `obj_zone` | 3 |
| `07_Mundo/Escenario` | `obj_animal_gaviota`, `obj_animals`, `obj_choza_1`, `obj_choza_2`, `obj_choza_3`, `obj_cueva`, `obj_faldellin`, `obj_fogata`, `obj_pasto`, `obj_personaje`, `obj_pesca`, `obj_pescado`, `obj_roca`, `obj_roca_2`, `obj_roca_3`, `obj_totora_1`, `obj_totora_2`, `obj_totora_3`, `obj_totora_5`, `obj_totora_6`, `objt_totora_4` | 21 |
| `07_Mundo/Interactuables` | `obj_agua`, `obj_fuego`, `obj_moon`, `obj_moon1` | 4 |
| `07_Mundo/Controladores` | `obj_generate`, `obj_room_controller` | 2 |
| `07_Mundo/Info_Lugares` | `obj_info`, `obj_info_anzota`, `obj_info_camarones`, `obj_info_capilla`, `obj_info_capilla1`, `obj_info_choza`, `obj_info_junquillo`, `obj_info_morro`, `obj_info_oasis`, `obj_info_rocas`, `obj_texto_anzota`, `obj_texto_camarones`, `obj_texto_capilla`, `obj_texto_choza`, `obj_texto_junquillo`, `obj_texto_morro`, `obj_texto_oasis`, `obj_texto_pictogramas`, `obj_texto_rocas` | 19 |
| `07_Mundo/Final` | `obj_evil_whanku`, `obj_imagen_final`, `obj_whanku_final` | 3 |
| `08_NPCs_Dialogos/NPCs` | `obj_npc`, `obj_npc_1`, `obj_npc_2`, `obj_npc_3`, `obj_npc_31`, `obj_npc_4`, `obj_npc_estolica`, `obj_npc_personaje`, `obj_npc_pescador`, `obj_npc_tejedora` | 10 |
| `08_NPCs_Dialogos/Khoru_y_Wanku` | `obj_khoru`, `obj_khoru_camarones`, `obj_wanku_aviso`, `obj_wanku_guia` | 4 |
| `08_NPCs_Dialogos/Dialogos` | `obj_dialogo`, `obj_text` | 2 |
| `08_NPCs_Dialogos/Tutorial` | `obj_control_tutorial`, `obj_khoru_tutorial`, `obj_tuto_wanku`, `obj_tutorial_popUp`, `obj_tutorial_popUp1`, `obj_tutorial_popup_2` | 6 |
| `09_UI/Pausa` | `obj_pause`, `obj_pauseBattle` | 2 |
| `09_UI/Menu` | `obj_ayuda_menu`, `obj_confirmar`, `obj_menuController` | 3 |
| `09_UI/Ayudas` | `obj_ayuda`, `obj_ayuda1`, `obj_popUp`, `obj_popup_ayuda`, `obj_sabias` | 5 |
| `99_Sin_Uso_Revisar` | `obj_prueba` | 1 |

## 4. Qué objetos tiene cada room

Las rooms están en el orden del proyecto. **Ese orden no debe cambiar**, porque hay código que viaja con números de room. "Exclusivos" son los objetos colocados solo en esa room.

| N.º | Room | Total | Exclusivos | Objetos colocados |
|---|---|---|---|---|
| 0 | `rm_menu` | 3 | 3 | `obj_game`, `obj_menuController`, `obj_morral` |
| 1 | `rm_tutorial_test` | 6 | 1 | `obj_ayuda1`, `obj_control_tutorial`, `obj_khoru_tutorial`, `obj_pared`, `obj_player`, `obj_tuto_wanku` |
| 2 | `rm_tutorial` | 4 | 0 | `obj_control_tutorial`, `obj_pared`, `obj_player`, `obj_tuto_wanku` |
| 3 | `rm_Momia` | 13 | 13 | `obj_cerebro`, `obj_controlador`, `obj_corazon`, `obj_craneo`, `obj_cuerpo`, `obj_desp`, `obj_esqueleto`, `obj_esternon`, `obj_higado`, `obj_intestino`, `obj_inventario`, `obj_mouse`, `obj_pulmon` |
| 4 | `rm_battle` | 4 | 0 | `obj_battleController`, `obj_pared`, `obj_pared_32`, `obj_player_battle` |
| 5 | `rm_battle_tutorial` | 4 | 0 | `obj_battleController`, `obj_pared`, `obj_pared_32`, `obj_player_battle` |
| 6 | `rm_anzota_2` | 11 | 4 | `obj_change`, `obj_change1`, `obj_change3`, `obj_change31`, `obj_info_anzota`, `obj_info_rocas`, `obj_npc_2`, `obj_pared`, `obj_pared_32`, `obj_personaje`, `obj_player` |
| 7 | `rm_cuevas_anzota` | 7 | 1 | `obj_change`, `obj_change1`, `obj_fuego`, `obj_npc_3`, `obj_pared`, `obj_pared_32`, `obj_player` |
| 8 | `rm_anzota_3` | 6 | 3 | `obj_agua`, `obj_change3`, `obj_enemigo_normal1`, `obj_npc_4`, `obj_pared`, `obj_player` |
| 9 | `rm_anzota` | 11 | 3 | `obj_ayuda`, `obj_ayuda1`, `obj_change`, `obj_change1`, `obj_info_anzota`, `obj_materiales`, `obj_pared`, `obj_player`, `obj_roca`, `obj_roca_2`, `obj_roca_3` |
| 10 | `rm_capilla` | 7 | 3 | `obj_change1`, `obj_faldellin`, `obj_info_capilla`, `obj_npc_3`, `obj_npc_tejedora`, `obj_pared`, `obj_player` |
| 11 | `rm_humedal` | 17 | 11 | `obj_ayuda1`, `obj_cueva`, `obj_fogata`, `obj_info_choza`, `obj_info_junquillo`, `obj_info_oasis`, `obj_materiales`, `obj_npc`, `obj_pared`, `obj_pared_32`, `obj_pause`, `obj_player`, `obj_totora_1`, `obj_totora_2`, `obj_totora_3`, `obj_totora_5`, `objt_totora_4` |
| 12 | `rm_costa_humedal` | 12 | 7 | `obj_ayuda1`, `obj_choza_2`, `obj_materiales`, `obj_moon`, `obj_npc_31`, `obj_npc_estolica`, `obj_npc_pescador`, `obj_pared`, `obj_pared_32`, `obj_pesca`, `obj_pescado`, `obj_player` |
| 13 | `rm_final_morro` | 5 | 3 | `obj_evil_whanku`, `obj_info_morro`, `obj_khoru`, `obj_pared`, `obj_player` |
| 14 | `rm_camarones` | 9 | 0 | `obj_ayuda`, `obj_info_camarones`, `obj_info_junquillo`, `obj_moon1`, `obj_npc_1`, `obj_npc_personaje`, `obj_pared`, `obj_pared_32`, `obj_player` |
| 15 | `rm_final_demo` | 1 | 1 | `obj_imagen_final` |
| 16 | `rm_momificar` | 9 | 0 | `obj_ayuda`, `obj_info_camarones`, `obj_info_junquillo`, `obj_moon1`, `obj_npc_1`, `obj_npc_personaje`, `obj_pared`, `obj_pared_32`, `obj_player` |

## 5. Los objetos para revisar

Decide uno por uno. Pueden crearse de una forma que la búsqueda no detecta, como una variable con el nombre del objeto.

| Objeto | Grupo propuesto | Quién lo nombra en el código |
|---|---|---|
| `obj_animals` | `07_Mundo/Escenario` | — |
| `obj_ayuda_menu` | `09_UI/Menu` | — |
| `obj_boss` | `04_Enemigos/Tipos` | — |
| `obj_choza_1` | `07_Mundo/Escenario` | — |
| `obj_choza_3` | `07_Mundo/Escenario` | — |
| `obj_enemigo_fuego` | `04_Enemigos/Tipos` | `scr_batalla_enemigos` |
| `obj_go` | `03_Batalla/Items` | — |
| `obj_info_capilla1` | `07_Mundo/Info_Lugares` | `scr_amaru_clic` |
| `obj_khoru_battle` | `04_Enemigos/Tipos` | `scr_batalla_enemigos` |
| `obj_npc_corrupto` | `04_Enemigos/En_Mapa` | — |
| `obj_pasto` | `07_Mundo/Escenario` | — |
| `obj_prueba` | `99_Sin_Uso_Revisar` | — |
| `obj_tojotojone` | `04_Enemigos/Tipos` | `scr_batalla_enemigos` |
| `obj_totora_6` | `07_Mundo/Escenario` | — |

## 6. Lista completa

| Objeto | Grupo propuesto | Confianza | Grupo actual | Rooms | Creado por | Padre |
|---|---|---|---|---|---|---|
| `cont_item` | `03_Batalla/Items` | Alta | `01_Batalla/Objects` | — | `rm_battle` | — |
| `cont_item1` | `03_Batalla/Items` | Alta | `01_Batalla/Objects` | — | `rm_battle` | — |
| `obj_agua` | `07_Mundo/Interactuables` | Media | `06_Tutorial_Dialogos/Objects` | `rm_anzota_3` | — | `obj_zone` |
| `obj_aliado_battle` | `03_Batalla/Combatientes` | Alta | `01_Batalla/Objects` | — | `scr_batalla_equipo` | — |
| `obj_animal_gaviota` | `07_Mundo/Escenario` | Alta | `03_Mundo_Rooms/Objects` | — | `obj_animals` | — |
| `obj_animals` | `07_Mundo/Escenario` | Revisar | `03_Mundo_Rooms/Objects` | — | — | — |
| `obj_arcilla_untar` | `06_Momia/Pasos` | Alta | `04_Minijuego_Momia/Objects` | — | `obj_controlador` | — |
| `obj_ayuda` | `09_UI/Ayudas` | Alta | `09_Pausa_Ayudas_Popups/Objects` | `rm_anzota`, `rm_camarones`, `rm_momificar` | — | — |
| `obj_ayuda1` | `09_UI/Ayudas` | Alta | `09_Pausa_Ayudas_Popups/Objects` | `rm_anzota`, `rm_costa_humedal`, `rm_humedal`, `rm_tutorial_test` | — | — |
| `obj_ayuda_menu` | `09_UI/Menu` | Revisar | `99_Sin_Uso_Revisar/Objects` | — | — | — |
| `obj_bala` | `03_Batalla/Proyectiles` | Alta | `01_Batalla/Objects` | — | — | — |
| `obj_battleController` | `03_Batalla/Flujo` | Alta | `00_Core` | `rm_battle`, `rm_battle_tutorial` | — | — |
| `obj_boss` | `04_Enemigos/Tipos` | Revisar | `01_Batalla/Objects` | — | — | — |
| `obj_card` | `03_Batalla/Cartas` | Alta | `01_Batalla/Objects` | — | `obj_battleController`, `obj_enemigo`, `obj_enemigo_agua`, `obj_enemigo_fuego` y 11 más | — |
| `obj_cartel_room` | `01_Partida/Transiciones` | Alta | `02_Nucleo_Partida/Objects` | — | `obj_generate`, `rm_anzota_3`, `rm_camarones`, `rm_capilla` y 3 más | — |
| `obj_cerebro` | `06_Momia/Piezas` | Alta | `04_Minijuego_Momia/Objects` | `rm_Momia` | — | `obj_organo` |
| `obj_change` | `01_Partida/Transiciones` | Alta | `02_Nucleo_Partida/Objects` | `rm_anzota`, `rm_anzota_2`, `rm_cuevas_anzota` | — | — |
| `obj_change1` | `01_Partida/Transiciones` | Alta | `08_Jugador_CambioZona/Objects` | `rm_anzota`, `rm_anzota_2`, `rm_capilla`, `rm_cuevas_anzota` | — | — |
| `obj_change3` | `01_Partida/Transiciones` | Alta | `08_Jugador_CambioZona/Objects` | `rm_anzota_2`, `rm_anzota_3` | — | — |
| `obj_change31` | `01_Partida/Transiciones` | Alta | `08_Jugador_CambioZona/Objects` | `rm_anzota_2` | — | — |
| `obj_choza_1` | `07_Mundo/Escenario` | Revisar | `99_Sin_Uso_Revisar/Objects` | — | — | — |
| `obj_choza_2` | `07_Mundo/Escenario` | Alta | `03_Mundo_Rooms/Objects` | `rm_costa_humedal` | — | — |
| `obj_choza_3` | `07_Mundo/Escenario` | Revisar | `99_Sin_Uso_Revisar/Objects` | — | — | — |
| `obj_companero` | `02_Jugador/Personajes` | Alta | `08_Jugador_CambioZona/Objects` | — | `obj_npc`, `obj_player` | — |
| `obj_confirmar` | `09_UI/Menu` | Alta | `02_Nucleo_Partida/Objects` | — | `obj_menuController`, `scr_menu` | — |
| `obj_control_tutorial` | `08_NPCs_Dialogos/Tutorial` | Alta | `00_Core` | `rm_tutorial`, `rm_tutorial_test` | — | — |
| `obj_controlador` | `06_Momia/Pasos` | Alta | `04_Minijuego_Momia/Objects` | `rm_Momia` | — | — |
| `obj_corazon` | `06_Momia/Piezas` | Alta | `04_Minijuego_Momia/Objects` | `rm_Momia` | — | `obj_organo` |
| `obj_craneo` | `06_Momia/Piezas` | Alta | `04_Minijuego_Momia/Objects` | `rm_Momia` | `obj_controlador` | `obj_huesos` |
| `obj_cuchilla` | `03_Batalla/Proyectiles` | Alta | `01_Batalla/Objects` | — | `scr_ataque_enemy` | `obj_bala` |
| `obj_cuerpo` | `06_Momia/Piezas` | Alta | `04_Minijuego_Momia/Objects` | `rm_Momia` | — | — |
| `obj_cueva` | `07_Mundo/Escenario` | Alta | `03_Mundo_Rooms/Objects` | `rm_humedal` | — | — |
| `obj_desp` | `06_Momia/Pasos` | Media | `04_Minijuego_Momia/Objects` | `rm_Momia` | — | — |
| `obj_dialogo` | `08_NPCs_Dialogos/Dialogos` | Alta | `06_Tutorial_Dialogos/Objects` | — | `obj_agua`, `obj_control_tutorial`, `obj_fuego`, `obj_khoru` y 17 más | — |
| `obj_dialogo_premio` | `03_Batalla/Flujo` | Media | `01_Batalla/Objects` | — | `obj_battleController` | — |
| `obj_enemigo` | `04_Enemigos/Tipos` | Alta | `01_Batalla/Objects` | — | `rm_battle_tutorial`, `scr_batalla_enemigos` | — |
| `obj_enemigo_agua` | `04_Enemigos/Tipos` | Alta | `01_Batalla/Objects` | — | `rm_battle_tutorial` | `obj_enemigo` |
| `obj_enemigo_fuego` | `04_Enemigos/Tipos` | Revisar | `01_Batalla/Objects` | — | — | `obj_enemigo` |
| `obj_enemigo_luna` | `04_Enemigos/Tipos` | Alta | `01_Batalla/Objects` | — | `rm_battle_tutorial` | `obj_enemigo` |
| `obj_enemigo_normal` | `04_Enemigos/En_Mapa` | Alta | `06_Tutorial_Dialogos/Objects` | — | `obj_control_tutorial` | — |
| `obj_enemigo_normal1` | `04_Enemigos/En_Mapa` | Alta | `03_Mundo_Rooms/Objects` | `rm_anzota_3` | `rm_anzota`, `rm_anzota_2`, `rm_costa_humedal`, `rm_humedal` | `obj_enemigo_normal` |
| `obj_escudo_tuto` | `03_Batalla/Cartas` | Media | `01_Batalla/Objects` | — | `obj_battleController`, `obj_control_tutorial`, `obj_player_battle` | — |
| `obj_especial` | `03_Batalla/Proyectiles` | Alta | `01_Batalla/Objects` | — | — | — |
| `obj_esqueleto` | `06_Momia/Piezas` | Alta | `04_Minijuego_Momia/Objects` | `rm_Momia` | — | — |
| `obj_esternon` | `06_Momia/Piezas` | Alta | `04_Minijuego_Momia/Objects` | `rm_Momia` | `obj_controlador` | `obj_huesos` |
| `obj_evil_whanku` | `07_Mundo/Final` | Alta | `03_Mundo_Rooms/Objects` | `rm_final_morro` | — | — |
| `obj_faldellin` | `07_Mundo/Escenario` | Media | `03_Mundo_Rooms/Objects` | `rm_capilla` | — | — |
| `obj_flecha` | `03_Batalla/Proyectiles` | Alta | `01_Batalla/Objects` | — | `obj_aliado_battle`, `scr_ataque`, `scr_ataque_enemy` | `obj_bala` |
| `obj_flecha_espiritual` | `03_Batalla/Proyectiles` | Alta | `01_Batalla/Objects` | — | `obj_player_battle`, `scr_listCombos` | `obj_especial` |
| `obj_fogata` | `07_Mundo/Escenario` | Alta | `03_Mundo_Rooms/Objects` | `rm_humedal` | — | — |
| `obj_fuego` | `07_Mundo/Interactuables` | Media | `06_Tutorial_Dialogos/Objects` | `rm_cuevas_anzota` | — | `obj_zone` |
| `obj_game` | `00_Core/Hubs` | Alta | `00_Core` | `rm_menu` | — | — |
| `obj_generate` | `07_Mundo/Controladores` | Media | `03_Mundo_Rooms/Objects` | — | `rm_anzota`, `rm_anzota_2`, `rm_anzota_3`, `rm_camarones` y 7 más | — |
| `obj_go` | `03_Batalla/Items` | Revisar | `99_Sin_Uso_Revisar/Objects` | — | — | — |
| `obj_go_agua` | `03_Batalla/Items` | Alta | `01_Batalla/Objects` | — | `cont_item1` | `obj_item` |
| `obj_go_fuego` | `03_Batalla/Items` | Alta | `01_Batalla/Objects` | — | `cont_item1` | `obj_item` |
| `obj_go_luna` | `03_Batalla/Items` | Alta | `01_Batalla/Objects` | — | `cont_item1` | `obj_item` |
| `obj_higado` | `06_Momia/Piezas` | Alta | `04_Minijuego_Momia/Objects` | `rm_Momia` | — | `obj_organo` |
| `obj_huesos` | `06_Momia/Piezas` | Alta | `04_Minijuego_Momia/Objects` | — | — | — |
| `obj_imagen_final` | `07_Mundo/Final` | Media | `02_Nucleo_Partida/Objects` | `rm_final_demo` | — | — |
| `obj_info` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | — | — | — |
| `obj_info_anzota` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | `rm_anzota`, `rm_anzota_2` | — | — |
| `obj_info_camarones` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | `rm_camarones`, `rm_momificar` | — | — |
| `obj_info_capilla` | `07_Mundo/Info_Lugares` | Alta | `07_NPCs_Puntaje/Objects` | `rm_capilla` | — | — |
| `obj_info_capilla1` | `07_Mundo/Info_Lugares` | Revisar | `07_NPCs_Puntaje/Objects` | — | — | — |
| `obj_info_choza` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | `rm_humedal` | — | — |
| `obj_info_junquillo` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | `rm_camarones`, `rm_humedal`, `rm_momificar` | — | — |
| `obj_info_morro` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | `rm_final_morro` | — | — |
| `obj_info_oasis` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | `rm_humedal` | — | — |
| `obj_info_rocas` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | `rm_anzota_2` | — | — |
| `obj_intestino` | `06_Momia/Piezas` | Alta | `04_Minijuego_Momia/Objects` | `rm_Momia` | — | `obj_organo` |
| `obj_inventario` | `06_Momia/Pasos` | Alta | `04_Minijuego_Momia/Objects` | `rm_Momia` | — | — |
| `obj_item` | `03_Batalla/Items` | Alta | `01_Batalla/Objects` | — | `cont_item` | — |
| `obj_khoru` | `08_NPCs_Dialogos/Khoru_y_Wanku` | Media | `06_Tutorial_Dialogos/Objects` | `rm_final_morro` | — | `obj_zone` |
| `obj_khoru_battle` | `04_Enemigos/Tipos` | Revisar | `01_Batalla/Objects` | — | — | `obj_enemigo` |
| `obj_khoru_camarones` | `08_NPCs_Dialogos/Khoru_y_Wanku` | Alta | `06_Tutorial_Dialogos/Objects` | — | `rm_momificar` | `obj_zone` |
| `obj_khoru_tutorial` | `08_NPCs_Dialogos/Tutorial` | Media | `09_Pausa_Ayudas_Popups/Objects` | `rm_tutorial_test` | `obj_control_tutorial` | — |
| `obj_marca_clic` | `02_Jugador/Input` | Media | `08_Jugador_CambioZona/Objects` | — | `scr_amaru_clic` | — |
| `obj_materiales` | `05_Inventario_Creacion/Materiales` | Media | `03_Mundo_Rooms/Objects` | `rm_anzota`, `rm_costa_humedal`, `rm_humedal` | `obj_battleController`, `obj_control_tutorial`, `scr_cargar_item`, `scr_materiales_aparecer` | — |
| `obj_mensaje` | `06_Momia/Pasos` | Media | `04_Minijuego_Momia/Objects` | — | `rm_Momia` | — |
| `obj_menuController` | `09_UI/Menu` | Alta | `02_Nucleo_Partida/Objects` | `rm_menu` | — | — |
| `obj_moon` | `07_Mundo/Interactuables` | Media | `06_Tutorial_Dialogos/Objects` | `rm_costa_humedal` | — | `obj_zone` |
| `obj_moon1` | `07_Mundo/Interactuables` | Media | `06_Tutorial_Dialogos/Objects` | `rm_camarones`, `rm_momificar` | — | `obj_zone` |
| `obj_morral` | `00_Core/Hubs` | Media | `00_Core` | `rm_menu` | — | — |
| `obj_mouse` | `06_Momia/Entrada` | Alta | `04_Minijuego_Momia/Objects` | `rm_Momia` | — | — |
| `obj_npc` | `08_NPCs_Dialogos/NPCs` | Alta | `05_Textos_Carteles/Objects` | `rm_humedal` | — | — |
| `obj_npc_1` | `08_NPCs_Dialogos/NPCs` | Alta | `07_NPCs_Puntaje/Objects` | `rm_camarones`, `rm_momificar` | — | `obj_zone` |
| `obj_npc_2` | `08_NPCs_Dialogos/NPCs` | Alta | `07_NPCs_Puntaje/Objects` | `rm_anzota_2` | — | `obj_zone` |
| `obj_npc_3` | `08_NPCs_Dialogos/NPCs` | Alta | `07_NPCs_Puntaje/Objects` | `rm_capilla`, `rm_cuevas_anzota` | — | `obj_zone` |
| `obj_npc_31` | `08_NPCs_Dialogos/NPCs` | Alta | `07_NPCs_Puntaje/Objects` | `rm_costa_humedal` | — | `obj_zone` |
| `obj_npc_4` | `08_NPCs_Dialogos/NPCs` | Alta | `07_NPCs_Puntaje/Objects` | `rm_anzota_3` | — | `obj_zone` |
| `obj_npc_corrupto` | `04_Enemigos/En_Mapa` | Revisar | `06_Tutorial_Dialogos/Objects` | — | — | `obj_enemigo_normal` |
| `obj_npc_estolica` | `08_NPCs_Dialogos/NPCs` | Alta | `07_NPCs_Puntaje/Objects` | `rm_costa_humedal` | — | `obj_zone` |
| `obj_npc_personaje` | `08_NPCs_Dialogos/NPCs` | Alta | `03_Mundo_Rooms/Objects` | `rm_camarones`, `rm_momificar` | `obj_khoru_camarones` | `obj_zone` |
| `obj_npc_pescador` | `08_NPCs_Dialogos/NPCs` | Alta | `07_NPCs_Puntaje/Objects` | `rm_costa_humedal` | — | `obj_zone` |
| `obj_npc_tejedora` | `08_NPCs_Dialogos/NPCs` | Alta | `07_NPCs_Puntaje/Objects` | `rm_capilla` | — | `obj_zone` |
| `obj_organo` | `06_Momia/Piezas` | Alta | `04_Minijuego_Momia/Objects` | — | — | — |
| `obj_pared` | `07_Mundo/Limites` | Alta | `03_Mundo_Rooms/Objects` | `rm_anzota`, `rm_anzota_2`, `rm_anzota_3`, `rm_battle` y 10 más | — | `obj_zone` |
| `obj_pared_32` | `07_Mundo/Limites` | Alta | `03_Mundo_Rooms/Objects` | `rm_anzota_2`, `rm_battle`, `rm_battle_tutorial`, `rm_camarones` y 4 más | — | `obj_zone` |
| `obj_pasto` | `07_Mundo/Escenario` | Revisar | `99_Sin_Uso_Revisar/Objects` | — | — | — |
| `obj_pause` | `09_UI/Pausa` | Alta | `00_Core` | `rm_humedal` | `obj_control_tutorial`, `rm_anzota`, `rm_anzota_2`, `rm_anzota_3` y 7 más | — |
| `obj_pauseBattle` | `09_UI/Pausa` | Alta | `09_Pausa_Ayudas_Popups/Objects` | — | `obj_battleController` | — |
| `obj_personaje` | `07_Mundo/Escenario` | Media | `03_Mundo_Rooms/Objects` | `rm_anzota_2` | — | — |
| `obj_pesca` | `07_Mundo/Escenario` | Alta | `03_Mundo_Rooms/Objects` | `rm_costa_humedal` | — | — |
| `obj_pescado` | `07_Mundo/Escenario` | Alta | `03_Mundo_Rooms/Objects` | `rm_costa_humedal` | — | — |
| `obj_pieza` | `06_Momia/Piezas` | Alta | `04_Minijuego_Momia/Objects` | — | `obj_inventario` | — |
| `obj_player` | `02_Jugador/Controlador` | Alta | `00_Core` | `rm_anzota`, `rm_anzota_2`, `rm_anzota_3`, `rm_camarones` y 8 más | `rm_anzota`, `rm_anzota_2`, `rm_anzota_3`, `rm_capilla` y 3 más | — |
| `obj_player_battle` | `03_Batalla/Combatientes` | Alta | `01_Batalla/Objects` | `rm_battle`, `rm_battle_tutorial` | `obj_battleController`, `obj_control_tutorial`, `scr_batalla_equipo` | — |
| `obj_popUp` | `09_UI/Ayudas` | Alta | `02_Nucleo_Partida/Objects` | — | `obj_pause`, `scr_pause_avance` | — |
| `obj_popup_ayuda` | `09_UI/Ayudas` | Alta | `09_Pausa_Ayudas_Popups/Objects` | — | `obj_ayuda` | — |
| `obj_proyectil` | `03_Batalla/Proyectiles` | Alta | `01_Batalla/Objects` | — | `scr_ataque`, `scr_ataque_enemy`, `scr_combo_enemy`, `scr_listCombos` | `obj_especial` |
| `obj_proyectilHealth` | `03_Batalla/Proyectiles` | Alta | `01_Batalla/Objects` | — | `scr_listCombos` | — |
| `obj_proyectil_ice` | `03_Batalla/Proyectiles` | Alta | `01_Batalla/Objects` | — | `scr_ataque`, `scr_ataque_enemy`, `scr_combo_enemy`, `scr_listCombos` | `obj_especial` |
| `obj_proyectil_ligth` | `03_Batalla/Proyectiles` | Alta | `01_Batalla/Objects` | — | `scr_ataque`, `scr_ataque_enemy`, `scr_combo_enemy`, `scr_listCombos` | `obj_especial` |
| `obj_prueba` | `99_Sin_Uso_Revisar` | Revisar | `99_Sin_Uso_Revisar/Objects` | — | — | — |
| `obj_pulmon` | `06_Momia/Piezas` | Alta | `04_Minijuego_Momia/Objects` | `rm_Momia` | — | `obj_organo` |
| `obj_roca` | `07_Mundo/Escenario` | Alta | `03_Mundo_Rooms/Objects` | `rm_anzota` | — | — |
| `obj_roca_2` | `07_Mundo/Escenario` | Alta | `03_Mundo_Rooms/Objects` | `rm_anzota` | — | — |
| `obj_roca_3` | `07_Mundo/Escenario` | Alta | `03_Mundo_Rooms/Objects` | `rm_anzota` | — | — |
| `obj_room_controller` | `07_Mundo/Controladores` | Media | `03_Mundo_Rooms/Objects` | — | `rm_anzota`, `rm_anzota_2`, `rm_anzota_3`, `rm_camarones` y 6 más | — |
| `obj_sabias` | `09_UI/Ayudas` | Alta | `02_Nucleo_Partida/Objects` | — | `obj_pause` | — |
| `obj_seguir` | `03_Batalla/Proyectiles` | Media | `01_Batalla/Objects` | — | `obj_boss`, `obj_enemigo` | — |
| `obj_snap` | `06_Momia/Piezas` | Alta | `04_Minijuego_Momia/Objects` | — | `obj_controlador` | — |
| `obj_sound_control` | `00_Core/Hubs` | Media | `01_Batalla/Objects` | — | `obj_game` | — |
| `obj_text` | `08_NPCs_Dialogos/Dialogos` | Alta | `02_Nucleo_Partida/Objects` | — | `scr_text` | — |
| `obj_texto_anzota` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | — | `obj_info_anzota` | `obj_info` |
| `obj_texto_camarones` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | — | `obj_info_camarones` | `obj_info` |
| `obj_texto_capilla` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | — | `obj_npc` | `obj_info` |
| `obj_texto_choza` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | — | `obj_info_choza` | `obj_info` |
| `obj_texto_junquillo` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | — | `obj_info_junquillo` | `obj_info` |
| `obj_texto_morro` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | — | `obj_info_morro` | `obj_info` |
| `obj_texto_oasis` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | — | `obj_info_oasis` | `obj_info` |
| `obj_texto_pictogramas` | `07_Mundo/Info_Lugares` | Alta | `07_NPCs_Puntaje/Objects` | — | `obj_info_capilla`, `obj_info_capilla1` | — |
| `obj_texto_rocas` | `07_Mundo/Info_Lugares` | Alta | `05_Textos_Carteles/Objects` | — | `obj_info_rocas` | `obj_info` |
| `obj_tojotojone` | `04_Enemigos/Tipos` | Revisar | `01_Batalla/Objects` | — | — | `obj_enemigo` |
| `obj_totora_1` | `07_Mundo/Escenario` | Alta | `03_Mundo_Rooms/Objects` | `rm_humedal` | — | — |
| `obj_totora_2` | `07_Mundo/Escenario` | Alta | `03_Mundo_Rooms/Objects` | `rm_humedal` | — | — |
| `obj_totora_3` | `07_Mundo/Escenario` | Alta | `03_Mundo_Rooms/Objects` | `rm_humedal` | — | — |
| `obj_totora_5` | `07_Mundo/Escenario` | Alta | `03_Mundo_Rooms/Objects` | `rm_humedal` | — | — |
| `obj_totora_6` | `07_Mundo/Escenario` | Revisar | `99_Sin_Uso_Revisar/Objects` | — | — | — |
| `obj_transition` | `01_Partida/Transiciones` | Alta | `02_Nucleo_Partida/Objects` | — | `scr_go_to_room` | — |
| `obj_transparente` | `03_Batalla/Proyectiles` | Media | `01_Batalla/Objects` | — | `scr_listCombos` | — |
| `obj_tuto_wanku` | `08_NPCs_Dialogos/Tutorial` | Media | `08_Jugador_CambioZona/Objects` | `rm_tutorial`, `rm_tutorial_test` | `obj_control_tutorial` | — |
| `obj_tutorial_popUp` | `08_NPCs_Dialogos/Tutorial` | Alta | `06_Tutorial_Dialogos/Objects` | — | `obj_battleController`, `obj_control_tutorial` | — |
| `obj_tutorial_popUp1` | `08_NPCs_Dialogos/Tutorial` | Alta | `09_Pausa_Ayudas_Popups/Objects` | — | `obj_pauseBattle` | — |
| `obj_tutorial_popup_2` | `08_NPCs_Dialogos/Tutorial` | Alta | `09_Pausa_Ayudas_Popups/Objects` | — | `obj_ayuda1` | — |
| `obj_wanku_aviso` | `08_NPCs_Dialogos/Khoru_y_Wanku` | Alta | `06_Tutorial_Dialogos/Objects` | — | `rm_humedal` | — |
| `obj_wanku_guia` | `08_NPCs_Dialogos/Khoru_y_Wanku` | Alta | `06_Tutorial_Dialogos/Objects` | — | `obj_khoru_camarones` | — |
| `obj_whanku_final` | `07_Mundo/Final` | Alta | `06_Tutorial_Dialogos/Objects` | — | `obj_khoru` | — |
| `obj_zone` | `07_Mundo/Limites` | Alta | `07_NPCs_Puntaje/Objects` | — | — | — |
| `objt_totora_4` | `07_Mundo/Escenario` | Alta | `03_Mundo_Rooms/Objects` | `rm_humedal` | — | — |

## 7. Límites de este mapa

- **Búsqueda por texto:** no detecta objetos creados con una variable o desde datos, y puede contar una mención dentro de un `with` o una condición si está en la misma línea que un `instance_create`.
- **Sin ejecutar el juego:** muestra lo que dice el proyecto, no lo que ocurre al jugar.
- **`__global_object_depths` no cuenta como uso:** es una tabla de compatibilidad que nombra casi todos los objetos.
- **Solo objetos:** los scripts, sprites y sonidos necesitarán su propia revisión.

## 8. Decisiones pendientes

1. ¿`obj_player` y `obj_control_tutorial` salen de `00_Core`, como propone el mapa?
2. ¿Cada objeto de la sección 5 se conserva o se retira?
3. ¿Te parecen bien los nombres de los grupos?
