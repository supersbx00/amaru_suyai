# Graph Report - proyecto_reconstruido_v2  (2026-10-26)

## Corpus Check
- cluster-only mode — file stats not available

## Summary
- 292 nodes · 1024 edges · 34 communities (11 shown, 23 thin omitted)
- Extraction: 97% EXTRACTED · 3% INFERRED · 0% AMBIGUOUS · INFERRED: 32 edges (avg confidence: 0.5)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Batalla jugador, enemigos y proyectiles|Batalla: jugador, enemigos y proyectiles]]
- [[_COMMUNITY_Núcleo obj_game, pausa, guardado y transiciones|Núcleo: obj_game, pausa, guardado y transiciones]]
- [[_COMMUNITY_Mundo rooms y escenarios|Mundo: rooms y escenarios]]
- [[_COMMUNITY_Minijuego de la momia (órganos y huesos)|Minijuego de la momia (órganos y huesos)]]
- [[_COMMUNITY_Textos informativos y carteles|Textos informativos y carteles]]
- [[_COMMUNITY_Tutorial, diálogos y espíritus|Tutorial, diálogos y espíritus]]
- [[_COMMUNITY_NPCs y puntaje|NPCs y puntaje]]
- [[_COMMUNITY_Jugador y cambio de zona|Jugador y cambio de zona]]
- [[_COMMUNITY_Pausa, ayudas y popups|Pausa, ayudas y popups]]
- [[_COMMUNITY_Compatibilidad GMS1 profundidades|Compatibilidad GMS1: profundidades]]
- [[_COMMUNITY_Compatibilidad GMS1 acciones|Compatibilidad GMS1: acciones]]
- [[_COMMUNITY_Animales (gaviotas)|Animales (gaviotas)]]
- [[_COMMUNITY_Compatibilidad (enlaces omitidos) __global_init|Compatibilidad (enlaces omitidos): __global_init]]
- [[_COMMUNITY_Compatibilidad (enlaces omitidos) __init_global|Compatibilidad (enlaces omitidos): __init_global]]
- [[_COMMUNITY_Compatibilidad (enlaces omitidos) __init_view|Compatibilidad (enlaces omitidos): __init_view]]
- [[_COMMUNITY_Compatibilidad (enlaces omitidos) __view_get|Compatibilidad (enlaces omitidos): __view_get]]
- [[_COMMUNITY_Compatibilidad (enlaces omitidos) action_restart_game|Compatibilidad (enlaces omitidos): action_restart_game]]
- [[_COMMUNITY_Compatibilidad (enlaces omitidos) instance_create|Compatibilidad (enlaces omitidos): instance_create]]
- [[_COMMUNITY_Sin uso macros|Sin uso: macros]]
- [[_COMMUNITY_Sin uso obj_ayuda_menu|Sin uso: obj_ayuda_menu]]
- [[_COMMUNITY_Sin uso obj_choza_1|Sin uso: obj_choza_1]]
- [[_COMMUNITY_Sin uso obj_choza_3|Sin uso: obj_choza_3]]
- [[_COMMUNITY_Sin uso obj_go|Sin uso: obj_go]]
- [[_COMMUNITY_Sin uso obj_pasto|Sin uso: obj_pasto]]
- [[_COMMUNITY_Sin uso obj_prueba|Sin uso: obj_prueba]]
- [[_COMMUNITY_Sin uso obj_totora_6|Sin uso: obj_totora_6]]
- [[_COMMUNITY_Sin uso scr_danho|Sin uso: scr_danho]]
- [[_COMMUNITY_Sin uso scr_dibujaValores_cards|Sin uso: scr_dibujaValores_cards]]
- [[_COMMUNITY_Sin uso scr_logros|Sin uso: scr_logros]]
- [[_COMMUNITY_Sin uso scr_pause_tutorial|Sin uso: scr_pause_tutorial]]
- [[_COMMUNITY_Sin uso scr_player_move|Sin uso: scr_player_move]]
- [[_COMMUNITY_Compatibilidad (enlaces omitidos) tile_get_count|Compatibilidad (enlaces omitidos): tile_get_count]]
- [[_COMMUNITY_Compatibilidad (enlaces omitidos) tile_get_id|Compatibilidad (enlaces omitidos): tile_get_id]]
- [[_COMMUNITY_Compatibilidad (enlaces omitidos) tile_set_alpha|Compatibilidad (enlaces omitidos): tile_set_alpha]]

## God Nodes (most connected - your core abstractions)
1. `obj_player` - 78 edges
2. `obj_game` - 57 edges
3. `obj_pause` - 50 edges
4. `obj_player_battle` - 48 edges
5. `obj_control_tutorial` - 48 edges
6. `obj_battleController` - 45 edges
7. `obj_morral` - 36 edges
8. `obj_enemigo` - 31 edges
9. `obj_dialogo` - 27 edges
10. `rm_humedal` - 27 edges

## Surprising Connections (you probably didn't know these)
- `obj_agua` --va_a--> `rm_battle`  [INFERRED]
  objects/obj_agua/obj_agua.yy → rooms/rm_battle/rm_battle.yy
- `obj_agua` --va_a--> `rm_costa_humedal`  [INFERRED]
  objects/obj_agua/obj_agua.yy → rooms/rm_costa_humedal/rm_costa_humedal.yy
- `obj_player` --va_a--> `rm_costa_humedal`  [INFERRED]
  objects/obj_player/obj_player.yy → rooms/rm_costa_humedal/rm_costa_humedal.yy
- `obj_player` --va_a--> `rm_humedal`  [INFERRED]
  objects/obj_player/obj_player.yy → rooms/rm_humedal/rm_humedal.yy
- `obj_game` --va_a--> `rm_anzota`  [INFERRED]
  objects/obj_game/obj_game.yy → rooms/rm_anzota/rm_anzota.yy

## Import Cycles
- None detected.

## Communities (34 total, 23 thin omitted)

### Community 0 - "Batalla: jugador, enemigos y proyectiles"
Cohesion: 0.10
Nodes (63): cont_item, cont_item1, global.anciana, global.count, global.espiritu_agua, global.espiritu_fuego, global.espiritu_luna, global.khoru (+55 more)

### Community 1 - "Núcleo: obj_game, pausa, guardado y transiciones"
Cohesion: 0.07
Nodes (58): description, global.gp, global.ide, global.last_paso, global.last_room, global.transicion, little, obj_cartel_room (+50 more)

### Community 2 - "Mundo: rooms y escenarios"
Cohesion: 0.11
Nodes (37): global.zona, obj_choza_2, obj_cueva, obj_enemigo_normal1, obj_evil_whanku, obj_faldellin, obj_fogata, obj_generate (+29 more)

### Community 3 - "Minijuego de la momia (órganos y huesos)"
Cohesion: 0.18
Nodes (26): global.controlsnap, global.index, global.numero, global.objeto_mouse, global.prioridad, obj_cerebro, obj_controlador, obj_corazon (+18 more)

### Community 4 - "Textos informativos y carteles"
Cohesion: 0.17
Nodes (23): general, obj_info, obj_info_anzota, obj_info_camarones, obj_info_choza, obj_info_junquillo, obj_info_morro, obj_info_oasis (+15 more)

### Community 5 - "Tutorial, diálogos y espíritus"
Cohesion: 0.26
Nodes (16): global.cinematica, global.enable_battle, global.enable_player, global.tipo_enemigo, obj_agua, obj_control_tutorial, obj_dialogo, obj_enemigo_normal (+8 more)

### Community 6 - "NPCs y puntaje"
Cohesion: 0.38
Nodes (16): global.puntaje_total, global.puntaje_total_descrasheo, obj_info_capilla, obj_info_capilla1, obj_npc_1, obj_npc_2, obj_npc_3, obj_npc_31 (+8 more)

### Community 7 - "Jugador y cambio de zona"
Cohesion: 0.19
Nodes (13): global.escena, obj_change1, obj_change3, obj_change31, obj_player, obj_tuto_wanku, scr_cargar_posicion, scr_enemy_follow (+5 more)

### Community 8 - "Pausa, ayudas y popups"
Cohesion: 0.24
Nodes (10): global.pause, obj_ayuda, obj_ayuda1, obj_khoru_tutorial, obj_pauseBattle, obj_popup_ayuda, obj_tutorial_popUp1, obj_tutorial_popup_2 (+2 more)

### Community 9 - "Compatibilidad GMS1: profundidades"
Cohesion: 0.67
Nodes (3): __global_object_depths, global.__objectID2Depth, object_get_depth

### Community 10 - "Compatibilidad GMS1: acciones"
Cohesion: 0.67
Nodes (3): __init_action, action_set_motion, global.__argument_relative

## Knowledge Gaps
- **71 isolated node(s):** `obj_animal_gaviota`, `obj_ayuda_menu`, `snd_defeat`, `obj_choza_1`, `obj_choza_2` (+66 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **23 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `obj_player` connect `Jugador y cambio de zona` to `Núcleo: obj_game, pausa, guardado y transiciones`, `Mundo: rooms y escenarios`, `Textos informativos y carteles`, `Tutorial, diálogos y espíritus`, `NPCs y puntaje`?**
  _High betweenness centrality (0.149) - this node is a cross-community bridge._
- **Why does `obj_game` connect `Núcleo: obj_game, pausa, guardado y transiciones` to `Batalla: jugador, enemigos y proyectiles`, `Mundo: rooms y escenarios`, `Tutorial, diálogos y espíritus`, `NPCs y puntaje`, `Jugador y cambio de zona`, `Pausa, ayudas y popups`?**
  _High betweenness centrality (0.147) - this node is a cross-community bridge._
- **Why does `obj_control_tutorial` connect `Tutorial, diálogos y espíritus` to `Batalla: jugador, enemigos y proyectiles`, `Núcleo: obj_game, pausa, guardado y transiciones`, `Mundo: rooms y escenarios`, `NPCs y puntaje`, `Jugador y cambio de zona`, `Pausa, ayudas y popups`?**
  _High betweenness centrality (0.124) - this node is a cross-community bridge._
- **Are the 2 inferred relationships involving `obj_player` (e.g. with `rm_costa_humedal` and `rm_humedal`) actually correct?**
  _`obj_player` has 2 INFERRED edges - model-reasoned connections that need verification._
- **Are the 4 inferred relationships involving `obj_game` (e.g. with `rm_anzota` and `rm_camarones`) actually correct?**
  _`obj_game` has 4 INFERRED edges - model-reasoned connections that need verification._
- **What connects `obj_animal_gaviota`, `obj_ayuda_menu`, `snd_defeat` to the rest of the system?**
  _71 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Batalla: jugador, enemigos y proyectiles` be split into smaller, more focused modules?**
  _Cohesion score 0.10343061955965181 - nodes in this community are weakly interconnected._