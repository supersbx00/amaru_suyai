# Mapa de scripts

Este documento es una **propuesta** que acompaña a `mapa_objetos_y_rooms.md`. Los scripts siguen en `scripts/<nombre>/` y su código no cambia: solo cambia el grupo que se ve en GameMaker.

Son 108 scripts. Confianza: 91 alta, 12 media y 5 para revisar. "Revisar" significa que la búsqueda no encontró quién los llama; **no significa que se puedan borrar**.

## 1. Por grupo

| Grupo | Scripts | Cantidad |
|---|---|---|
| `00_Core/Compatibilidad_GMS1` | `__global_init`, `__global_object_depths`, `__init_action`, `__init_global`, `__init_view`, `__view_get`, `action_restart_game`, `action_set_motion`, `instance_create`, `object_get_depth` | 10 |
| `00_Core/Constantes` | `macros`, `variables_globales` | 2 |
| `01_Partida/Guardado` | `scr_cargar_cartas`, `scr_cargar_datos`, `scr_cargar_escenario`, `scr_cargar_item`, `scr_cargar_logros`, `scr_cargar_mazos`, `scr_cargar_receta`, `scr_guardaPartida`, `scr_guardar_cartas`, `scr_guardar_cuarto`, `scr_guardar_datos`, `scr_guardar_item`, `scr_guardar_logros`, `scr_guardar_mazo`, `scr_guardar_recetas`, `scr_partida_respaldar`, `scr_partida_restaurar`, `scr_sprite_cargado` | 18 |
| `01_Partida/Transiciones` | `scr_go_to_room`, `scr_room_transition` | 2 |
| `02_Jugador/Input` | `scr_amaru_clic` | 1 |
| `02_Jugador/Movimiento` | `scr_player_move` | 1 |
| `02_Jugador/Personajes` | `scr_cambiar_personaje`, `scr_sprite_personaje` | 2 |
| `02_Jugador/Posicion` | `scr_cargar_posicion` | 1 |
| `03_Batalla/Flujo` | `scr_anulacion`, `scr_batalla_enemigos`, `scr_batalla_equipo`, `scr_batalla_escudo`, `scr_batalla_ia` | 5 |
| `03_Batalla/Combatientes` | `scr_movimiento` | 1 |
| `03_Batalla/Combate` | `scr_ataque`, `scr_ataque_enemy`, `scr_colision`, `scr_combo_enemy`, `scr_danho`, `scr_listCombos` | 6 |
| `03_Batalla/Cartas` | `scr_asignaValores_segunCarta`, `scr_dibujaValores_cards`, `scr_dibujarCartas`, `scr_recuperarCartas`, `scr_rotarCartas` | 5 |
| `04_Enemigos/IA` | `scr_enemigo_espera`, `scr_enemigo_mover`, `scr_enemy_follow`, `scr_enemy_follow1`, `scr_enemy_static`, `scr_enemy_static1`, `scr_enemy_static_all`, `scr_enemy_static_all1`, `scr_start`, `scr_start1` | 10 |
| `05_Inventario_Creacion/Morral` | `scr_asignaSprite_segunNombre`, `scr_asignaValores_segunMaterial`, `scr_morral_agregar` | 3 |
| `05_Inventario_Creacion/Recetas` | `scr_desbloquearRecetas`, `scr_recetas`, `scr_recetas_MaterialesNecesarios` | 3 |
| `05_Inventario_Creacion/Materiales` | `scr_materiales_aparecer` | 1 |
| `06_Momia/Entrada` | `scr_momia_control` | 1 |
| `06_Momia/Materiales` | `scr_momia_materiales` | 1 |
| `08_NPCs_Dialogos/Dialogos` | `scr_cambiaSprite`, `scr_text`, `scr_text_draw`, `scr_text_draw_2`, `scr_text_mensajes`, `scr_text_npc`, `scr_text_step`, `scr_texto_actualizar` | 8 |
| `09_UI/Pausa` | `scr_controlVisor`, `scr_controlVisor_diario`, `scr_pause_avance`, `scr_pause_back`, `scr_pause_control`, `scr_pause_lb`, `scr_pause_mouse`, `scr_pause_rb`, `scr_pause_tutorial` | 9 |
| `09_UI/Mazos` | `scr_cleanDeck`, `scr_equipDeck`, `scr_menuDeck`, `scr_ordenaMazo`, `scr_renameDeck`, `scr_return_hdCard`, `scr_valorCP_total` | 7 |
| `09_UI/Menu` | `scr_menu` | 1 |
| `09_UI/Ayudas` | `scr_aviso_interaccion`, `scr_ayuda_espera` | 2 |
| `09_UI/Entrada` | `scr_boton_joy`, `scr_mouse_actualizar`, `scr_mouse_sobre`, `scr_tecla_z` | 4 |
| `09_UI/Logros` | `scr_actualiza_listaLogros`, `scr_lista_logros`, `scr_lista_logros_memorin`, `scr_logros` | 4 |

## 2. Para revisar

| Script | Grupo propuesto |
|---|---|
| `macros` | `00_Core/Constantes` |
| `scr_dibujaValores_cards` | `03_Batalla/Cartas` |
| `scr_guardaPartida` | `01_Partida/Guardado` |
| `scr_logros` | `09_UI/Logros` |
| `scr_pause_tutorial` | `09_UI/Pausa` |

## 3. Lista completa

| Script | Grupo propuesto | Confianza | Grupo actual | Quién lo usa |
|---|---|---|---|---|
| `__global_init` | `00_Core/Compatibilidad_GMS1` | Alta | `10_Compatibilidad_GMS1` | — |
| `__global_object_depths` | `00_Core/Compatibilidad_GMS1` | Alta | `10_Compatibilidad_GMS1` | `__global_init` |
| `__init_action` | `00_Core/Compatibilidad_GMS1` | Alta | `10_Compatibilidad_GMS1` | `__global_init` |
| `__init_global` | `00_Core/Compatibilidad_GMS1` | Alta | `10_Compatibilidad_GMS1` | `__global_init` |
| `__init_view` | `00_Core/Compatibilidad_GMS1` | Alta | `10_Compatibilidad_GMS1` | — |
| `__view_get` | `00_Core/Compatibilidad_GMS1` | Alta | `10_Compatibilidad_GMS1` | `obj_animals`, `obj_confirmar`, `obj_dialogo`, `obj_dialogo_premio` y 28 más |
| `action_restart_game` | `00_Core/Compatibilidad_GMS1` | Alta | `10_Compatibilidad_GMS1` | `obj_game` |
| `action_set_motion` | `00_Core/Compatibilidad_GMS1` | Alta | `10_Compatibilidad_GMS1` | `obj_player` |
| `instance_create` | `00_Core/Compatibilidad_GMS1` | Alta | `10_Compatibilidad_GMS1` | `cont_item`, `cont_item1`, `obj_agua`, `obj_aliado_battle` y 79 más |
| `macros` | `00_Core/Constantes` | Revisar | `99_Sin_Uso_Revisar/Scripts` | — |
| `object_get_depth` | `00_Core/Compatibilidad_GMS1` | Alta | `10_Compatibilidad_GMS1` | `instance_create` |
| `scr_actualiza_listaLogros` | `09_UI/Logros` | Alta | `02_Nucleo_Partida/Scripts` | `scr_menu` |
| `scr_amaru_clic` | `02_Jugador/Input` | Alta | `08_Jugador_CambioZona/Scripts` | `obj_companero`, `obj_game`, `obj_player`, `scr_aviso_interaccion` |
| `scr_anulacion` | `03_Batalla/Flujo` | Media | `01_Batalla/Scripts` | `obj_battleController` |
| `scr_asignaSprite_segunNombre` | `05_Inventario_Creacion/Morral` | Media | `02_Nucleo_Partida/Scripts` | `scr_recetas_MaterialesNecesarios` |
| `scr_asignaValores_segunCarta` | `03_Batalla/Cartas` | Alta | `02_Nucleo_Partida/Scripts` | `obj_battleController`, `obj_game`, `obj_khoru_camarones`, `obj_mensaje` y 4 más |
| `scr_asignaValores_segunMaterial` | `05_Inventario_Creacion/Morral` | Media | `01_Batalla/Scripts` | `obj_battleController`, `scr_morral_agregar` |
| `scr_ataque` | `03_Batalla/Combate` | Alta | `01_Batalla/Scripts` | `obj_player_battle` |
| `scr_ataque_enemy` | `03_Batalla/Combate` | Alta | `01_Batalla/Scripts` | `obj_enemigo_agua`, `obj_enemigo_fuego`, `obj_enemigo_luna`, `obj_khoru_battle` y 1 más |
| `scr_aviso_interaccion` | `09_UI/Ayudas` | Media | `02_Nucleo_Partida/Scripts` | `obj_agua`, `obj_ayuda`, `obj_ayuda1`, `obj_companero` y 27 más |
| `scr_ayuda_espera` | `09_UI/Ayudas` | Alta | `09_Pausa_Ayudas_Popups/Scripts` | `obj_popup_ayuda`, `obj_sabias`, `obj_tutorial_popUp`, `obj_tutorial_popUp1` y 1 más |
| `scr_batalla_enemigos` | `03_Batalla/Flujo` | Alta | `01_Batalla/Scripts` | `obj_aliado_battle`, `obj_bala`, `obj_battleController`, `obj_cuchilla` y 19 más |
| `scr_batalla_equipo` | `03_Batalla/Flujo` | Alta | `01_Batalla/Scripts` | `obj_aliado_battle`, `obj_battleController`, `obj_player_battle`, `rm_battle` y 1 más |
| `scr_batalla_escudo` | `03_Batalla/Flujo` | Alta | `01_Batalla/Scripts` | `obj_battleController`, `obj_especial`, `obj_player_battle`, `scr_colision` |
| `scr_batalla_ia` | `03_Batalla/Flujo` | Alta | `01_Batalla/Scripts` | `obj_player_battle` |
| `scr_boton_joy` | `09_UI/Entrada` | Alta | `09_Pausa_Ayudas_Popups/Scripts` | `obj_confirmar`, `obj_mensaje`, `obj_tutorial_popUp`, `obj_tutorial_popUp1` y 1 más |
| `scr_cambiaSprite` | `08_NPCs_Dialogos/Dialogos` | Media | `05_Textos_Carteles/Scripts` | `obj_npc`, `scr_pause_control` |
| `scr_cambiar_personaje` | `02_Jugador/Personajes` | Alta | `08_Jugador_CambioZona/Scripts` | `obj_companero`, `obj_player` |
| `scr_cargar_cartas` | `01_Partida/Guardado` | Alta | `02_Nucleo_Partida/Scripts` | `obj_confirmar`, `scr_guardar_cartas` |
| `scr_cargar_datos` | `01_Partida/Guardado` | Alta | `01_Batalla/Scripts` | `obj_confirmar` |
| `scr_cargar_escenario` | `01_Partida/Guardado` | Alta | `02_Nucleo_Partida/Scripts` | `obj_confirmar` |
| `scr_cargar_item` | `01_Partida/Guardado` | Alta | `02_Nucleo_Partida/Scripts` | `obj_confirmar` |
| `scr_cargar_logros` | `01_Partida/Guardado` | Alta | `01_Batalla/Scripts` | `obj_confirmar` |
| `scr_cargar_mazos` | `01_Partida/Guardado` | Alta | `02_Nucleo_Partida/Scripts` | `obj_confirmar` |
| `scr_cargar_posicion` | `02_Jugador/Posicion` | Media | `08_Jugador_CambioZona/Scripts` | `obj_player` |
| `scr_cargar_receta` | `01_Partida/Guardado` | Alta | `02_Nucleo_Partida/Scripts` | `obj_confirmar`, `obj_morral` |
| `scr_cleanDeck` | `09_UI/Mazos` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause` |
| `scr_colision` | `03_Batalla/Combate` | Media | `01_Batalla/Scripts` | `obj_cuchilla`, `obj_flecha` |
| `scr_combo_enemy` | `03_Batalla/Combate` | Alta | `01_Batalla/Scripts` | `obj_enemigo_agua`, `obj_enemigo_fuego`, `obj_enemigo_luna`, `obj_khoru_battle` y 1 más |
| `scr_controlVisor` | `09_UI/Pausa` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause`, `scr_pause_avance`, `scr_pause_rb` |
| `scr_controlVisor_diario` | `09_UI/Pausa` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause` |
| `scr_danho` | `03_Batalla/Combate` | Alta | `01_Batalla/Scripts` | `obj_aliado_battle`, `obj_especial`, `obj_flecha_espiritual`, `obj_proyectil` y 3 más |
| `scr_desbloquearRecetas` | `05_Inventario_Creacion/Recetas` | Alta | `07_NPCs_Puntaje/Scripts` | `obj_npc_2`, `obj_npc_4`, `obj_npc_estolica`, `obj_npc_personaje` y 1 más |
| `scr_dibujaValores_cards` | `03_Batalla/Cartas` | Revisar | `99_Sin_Uso_Revisar/Scripts` | — |
| `scr_dibujarCartas` | `03_Batalla/Cartas` | Alta | `01_Batalla/Scripts` | `obj_player_battle` |
| `scr_enemigo_espera` | `04_Enemigos/IA` | Alta | `01_Batalla/Scripts` | `obj_enemigo`, `obj_enemigo_agua`, `obj_enemigo_fuego`, `obj_enemigo_luna` |
| `scr_enemigo_mover` | `04_Enemigos/IA` | Alta | `01_Batalla/Scripts` | `obj_aliado_battle`, `obj_enemigo`, `obj_enemigo_agua`, `obj_enemigo_fuego` y 4 más |
| `scr_enemy_follow` | `04_Enemigos/IA` | Alta | `08_Jugador_CambioZona/Scripts` | `scr_start` |
| `scr_enemy_follow1` | `04_Enemigos/IA` | Alta | `08_Jugador_CambioZona/Scripts` | `scr_start1` |
| `scr_enemy_static` | `04_Enemigos/IA` | Alta | `02_Nucleo_Partida/Scripts` | `scr_start` |
| `scr_enemy_static1` | `04_Enemigos/IA` | Alta | `02_Nucleo_Partida/Scripts` | `scr_start1` |
| `scr_enemy_static_all` | `04_Enemigos/IA` | Alta | `08_Jugador_CambioZona/Scripts` | `scr_start` |
| `scr_enemy_static_all1` | `04_Enemigos/IA` | Alta | `08_Jugador_CambioZona/Scripts` | `scr_start1` |
| `scr_equipDeck` | `09_UI/Mazos` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause` |
| `scr_go_to_room` | `01_Partida/Transiciones` | Alta | `02_Nucleo_Partida/Scripts` | `__global_init`, `obj_agua`, `obj_battleController`, `obj_change` y 18 más |
| `scr_guardaPartida` | `01_Partida/Guardado` | Revisar | `02_Nucleo_Partida/Scripts` | — |
| `scr_guardar_cartas` | `01_Partida/Guardado` | Alta | `02_Nucleo_Partida/Scripts` | `obj_battleController`, `obj_mensaje`, `obj_pause`, `scr_guardaPartida` |
| `scr_guardar_cuarto` | `01_Partida/Guardado` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause`, `scr_guardaPartida` |
| `scr_guardar_datos` | `01_Partida/Guardado` | Alta | `07_NPCs_Puntaje/Scripts` | `obj_battleController`, `obj_info_anzota`, `obj_info_camarones`, `obj_info_capilla` y 19 más |
| `scr_guardar_item` | `01_Partida/Guardado` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause`, `scr_guardaPartida` |
| `scr_guardar_logros` | `01_Partida/Guardado` | Alta | `01_Batalla/Scripts` | `obj_pause` |
| `scr_guardar_mazo` | `01_Partida/Guardado` | Alta | `02_Nucleo_Partida/Scripts` | `obj_battleController`, `obj_pause`, `scr_guardaPartida` |
| `scr_guardar_recetas` | `01_Partida/Guardado` | Alta | `02_Nucleo_Partida/Scripts` | `obj_npc_personaje`, `obj_pause` |
| `scr_listCombos` | `03_Batalla/Combate` | Alta | `01_Batalla/Scripts` | `obj_player_battle` |
| `scr_lista_logros` | `09_UI/Logros` | Alta | `02_Nucleo_Partida/Scripts` | `obj_confirmar`, `obj_game` |
| `scr_lista_logros_memorin` | `09_UI/Logros` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause` |
| `scr_logros` | `09_UI/Logros` | Revisar | `99_Sin_Uso_Revisar/Scripts` | — |
| `scr_materiales_aparecer` | `05_Inventario_Creacion/Materiales` | Alta | `03_Mundo_Rooms/Scripts` | `obj_game`, `obj_materiales` |
| `scr_menu` | `09_UI/Menu` | Alta | `02_Nucleo_Partida/Scripts` | `obj_khoru_camarones`, `obj_pause` |
| `scr_menuDeck` | `09_UI/Mazos` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause` |
| `scr_momia_control` | `06_Momia/Entrada` | Alta | `04_Minijuego_Momia/Scripts` | `obj_arcilla_untar`, `obj_controlador`, `obj_cuerpo`, `obj_game` y 2 más |
| `scr_momia_materiales` | `06_Momia/Materiales` | Alta | `04_Minijuego_Momia/Scripts` | `obj_arcilla_untar`, `obj_inventario`, `obj_khoru_camarones`, `obj_materiales` y 6 más |
| `scr_morral_agregar` | `05_Inventario_Creacion/Morral` | Media | `01_Batalla/Scripts` | `obj_arcilla_untar`, `obj_game`, `obj_khoru_camarones`, `obj_materiales` y 4 más |
| `scr_mouse_actualizar` | `09_UI/Entrada` | Media | `02_Nucleo_Partida/Scripts` | `obj_game`, `obj_player_battle`, `scr_texto_actualizar` |
| `scr_mouse_sobre` | `09_UI/Entrada` | Media | `02_Nucleo_Partida/Scripts` | `obj_controlador`, `obj_cuerpo`, `obj_menuController`, `scr_pause_mouse` |
| `scr_movimiento` | `03_Batalla/Combatientes` | Alta | `01_Batalla/Scripts` | `obj_player_battle` |
| `scr_ordenaMazo` | `09_UI/Mazos` | Alta | `02_Nucleo_Partida/Scripts` | `scr_pause_back`, `scr_pause_control` |
| `scr_partida_respaldar` | `01_Partida/Guardado` | Alta | `02_Nucleo_Partida/Scripts` | `obj_game`, `obj_pause` |
| `scr_partida_restaurar` | `01_Partida/Guardado` | Alta | `02_Nucleo_Partida/Scripts` | `obj_confirmar` |
| `scr_pause_avance` | `09_UI/Pausa` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause` |
| `scr_pause_back` | `09_UI/Pausa` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause` |
| `scr_pause_control` | `09_UI/Pausa` | Alta | `09_Pausa_Ayudas_Popups/Scripts` | `obj_khoru_camarones`, `obj_pause`, `scr_mouse_actualizar` |
| `scr_pause_lb` | `09_UI/Pausa` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause` |
| `scr_pause_mouse` | `09_UI/Pausa` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause` |
| `scr_pause_rb` | `09_UI/Pausa` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause` |
| `scr_pause_tutorial` | `09_UI/Pausa` | Revisar | `99_Sin_Uso_Revisar/Scripts` | — |
| `scr_player_move` | `02_Jugador/Movimiento` | Alta | `99_Sin_Uso_Revisar/Scripts` | `obj_companero`, `obj_player`, `scr_amaru_clic` |
| `scr_recetas` | `05_Inventario_Creacion/Recetas` | Alta | `02_Nucleo_Partida/Scripts` | `obj_confirmar`, `obj_game`, `obj_menuController` |
| `scr_recetas_MaterialesNecesarios` | `05_Inventario_Creacion/Recetas` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause` |
| `scr_recuperarCartas` | `03_Batalla/Cartas` | Alta | `01_Batalla/Scripts` | `obj_player_battle` |
| `scr_renameDeck` | `09_UI/Mazos` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause` |
| `scr_return_hdCard` | `09_UI/Mazos` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause` |
| `scr_room_transition` | `01_Partida/Transiciones` | Alta | `02_Nucleo_Partida/Scripts` | `obj_transition` |
| `scr_rotarCartas` | `03_Batalla/Cartas` | Alta | `01_Batalla/Scripts` | `obj_player_battle` |
| `scr_sprite_cargado` | `01_Partida/Guardado` | Media | `02_Nucleo_Partida/Scripts` | `scr_cargar_cartas`, `scr_cargar_item`, `scr_cargar_mazos` |
| `scr_sprite_personaje` | `02_Jugador/Personajes` | Alta | `08_Jugador_CambioZona/Scripts` | `obj_companero`, `obj_player` |
| `scr_start` | `04_Enemigos/IA` | Alta | `08_Jugador_CambioZona/Scripts` | `obj_enemigo_normal`, `scr_enemy_follow`, `scr_enemy_static`, `scr_enemy_static_all` |
| `scr_start1` | `04_Enemigos/IA` | Alta | `08_Jugador_CambioZona/Scripts` | `obj_enemigo_normal1`, `scr_enemy_follow1`, `scr_enemy_static1`, `scr_enemy_static_all1` |
| `scr_tecla_z` | `09_UI/Entrada` | Alta | `02_Nucleo_Partida/Scripts` | `obj_agua`, `obj_ayuda`, `obj_ayuda1`, `obj_fuego` y 25 más |
| `scr_text` | `08_NPCs_Dialogos/Dialogos` | Alta | `02_Nucleo_Partida/Scripts` | `obj_game`, `obj_menuController`, `obj_pause`, `scr_menu` y 2 más |
| `scr_text_draw` | `08_NPCs_Dialogos/Dialogos` | Alta | `05_Textos_Carteles/Scripts` | `obj_dialogo`, `obj_dialogo_premio`, `obj_texto_anzota`, `obj_texto_camarones` y 5 más |
| `scr_text_draw_2` | `08_NPCs_Dialogos/Dialogos` | Alta | `05_Textos_Carteles/Scripts` | `obj_texto_capilla`, `obj_texto_pictogramas` |
| `scr_text_mensajes` | `08_NPCs_Dialogos/Dialogos` | Alta | `05_Textos_Carteles/Scripts` | `obj_dialogo`, `obj_dialogo_premio`, `obj_texto_anzota`, `obj_texto_camarones` y 7 más |
| `scr_text_npc` | `08_NPCs_Dialogos/Dialogos` | Alta | `06_Tutorial_Dialogos/Scripts` | `obj_dialogo`, `obj_dialogo_premio`, `obj_khoru_camarones`, `obj_npc_personaje` y 2 más |
| `scr_text_step` | `08_NPCs_Dialogos/Dialogos` | Alta | `05_Textos_Carteles/Scripts` | `obj_dialogo`, `obj_dialogo_premio`, `obj_texto_anzota`, `obj_texto_camarones` y 7 más |
| `scr_texto_actualizar` | `08_NPCs_Dialogos/Dialogos` | Alta | `02_Nucleo_Partida/Scripts` | `obj_arcilla_untar`, `obj_control_tutorial`, `obj_game`, `obj_mensaje` y 10 más |
| `scr_valorCP_total` | `09_UI/Mazos` | Alta | `02_Nucleo_Partida/Scripts` | `obj_pause`, `scr_pause_avance`, `scr_pause_back`, `scr_pause_mouse` |
| `variables_globales` | `00_Core/Constantes` | Media | `04_Minijuego_Momia/Scripts` | `obj_inventario` |

## 4. Límites

Es una búsqueda por texto. No detecta llamadas hechas con una variable o desde datos, y un nombre que aparece en un string o comentario puede contar como uso. La tabla `__global_object_depths` no cuenta como uso.
