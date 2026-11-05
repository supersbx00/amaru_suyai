# Auditoría SOLID (2026-11-05)

Revisión de solo lectura de `00_Core` a `09_UI`, sin `06_Momia` (ya refactorizada) ni `99_Sin_Uso_Revisar`. La hicieron 5 analistas en paralelo con las reglas de `.claude/rules/solid.md` y la sección 4 de `gamemaker.md`. El prompt y los encargos están en [auditoria-solid-prompt.md](auditoria-solid-prompt.md).

**Leyenda de verificación:** ✔ = confirmado leyendo el código tras el reporte. ? = por confirmar en el IDE. Sin marca = reportado por el analista, no revisado a mano.

## Resumen y orden propuesto

Casi todo el costo viene de tres causas que se repiten en todas las features:

1. **Índices numéricos de GMS1** (rooms, sprites, cartas). Son bugs silenciosos: ya rompieron el proyecto antes.
2. **Hijos que copian los eventos del padre** en vez de heredarlos (proyectiles, enemigos, `obj_texto_*`, NPCs).
3. **Tablas repetidas en varios archivos** (recetas, materiales, tipo de carta, entrega de cartas al morral).

Orden propuesto, de menor riesgo y mayor ganancia a mayor tamaño:

| # | Rama | Qué | Tamaño |
|---|---|---|---|
| 1 | `fix/bugs-auditoria` | Los bugs de una línea de la sección "Bugs" (guardado, inventario, pausa, enemigos). No es refactor: cambia comportamiento roto. | ~15 líneas |
| 2 | `refactor/rooms-por-nombre` | Cambiar los índices de room por `rm_*` en todas las features (atraviesa varias, por eso va en su propia rama). Antes, confirmar en el IDE qué room es cada número. | ~25 líneas |
| 3 | `refactor/batalla-solid` | Proyectiles y balas heredan de `obj_especial` / `obj_bala`; quitar `global.proyectil_1/2`; `usa_patrones`. | borra ~15 eventos |
| 4 | `refactor/mundo-solid` | `obj_texto_*` heredan de `obj_info`; `obj_info_*` con un script común. | borra ~27 archivos |
| 5 | `refactor/partida-solid` | Una sola tabla de recetas para cargar, iniciar y guardar. | media |
| 6 | `refactor/enemigos-solid` | Sprites de los enemigos de mapa en variables (borra los scripts `*1`); Step común de los espíritus. | grande |
| 7 | `refactor/ui-solid` | Macros para los pasos del tutorial; cierre de pausa en una función; visor de logros en un bloque. | media |
| 8 | `refactor/npcs-solid` | `obj_control_tutorial` compactado (`paso += 1`, un solo bloque de diálogo). | media |

## Bugs (fuera de SOLID, van primero)

| archivo:línea | bug | arreglo | ver. |
|---|---|---|---|
| `scr_guardar_recetas:19` | "Arpon de hueso" guarda en la sección `anzuelo_huesoAve`; el arpón nunca se guarda. | `"arpon_hueso"` | ✔ |
| `scr_cargar_logros` | `global.khoru` se guarda pero ningún script lo carga: al cargar partida, Khoru vuelve a estar sin derrotar. | `global.khoru = ini_read_real("Mision", "khoru", 0);` | ✔ |
| `obj_inventario/Step_0:31` | `* 16` con celdas de 67 px (la línea 3 usa `* 64`): solo se aceptan los primeros slots y con `+67` el índice puede salirse del array. | En las dos líneas `mouse_y < 16 + array_length(inventario) * 67` | ✔ |
| `obj_game/Create_0:79` | `show_message("entro")` de depuración en el primer arranque. | Borrar | ✔ |
| `obj_khoru_battle/Step_0:32` | `choose(20, 16, 18)`: índices GMS1 como sprite de carta. | `spr_card_moon/agua/fuego` | ✔ |
| `obj_enemigo_{agua,fuego,luna}`, `obj_khoru_battle` Step | `comboCarta_aux[0] = 14` (índice GMS1); el jugador ya usa `spr_deck_combo`. | `spr_deck_combo` en las 4 | ✔ |
| `scr_controlVisor_diario:89` | Asigna `visorRange_min_diario` dos veces; nunca `max`. | `visorRange_max_diario = 5` | ✔ |
| `scr_pause_control:25-34` | El `else if` repite la condición del `if`: nunca corre. | Revisar intención | ✔ |
| `scr_pause_control:36` | `room != rm_battle \|\| room != rm_battle_tutorial` siempre es verdadero. | `&&` | ✔ |
| `obj_pause/Step_0:429,432` | Compara con "Ver Cartas"; el estado real es "Ver cartas". | Minúscula | ✔ |
| `obj_npc_4/Step_0:28,32` | Dos condiciones iguales; la segunda rama nunca corre. | Probablemente `obj_player.x < x` | ✔ |
| `obj_player_battle/Alarm_1:23,26` | `curar >= 1 && curar == 5` (y `== 9`): la anulación solo revierte curas de 5 o 9. | `<=` | ✔ |
| `obj_battleController/Alarm_1:16` | Revisa `espiritu_fuego` dos veces y nunca `espiritu_agua`. | `espiritu_agua` | ✔ |
| `obj_flecha`, `obj_cuchilla` Step_0 | Reemplazan el Step de `obj_bala` y pierden "destruir si hay popUp". | Se arregla en el refactor 3 | ✔ |
| `obj_cartel_room/Step_0:1` | `camera_get_view_width(view_camera[0] / 2)` divide el id de cámara. | `camera_get_view_width(view_camera[0]) / 2` | ✔ |
| `scr_cargar_receta:22-24` | Cantidades del anzuelo leídas con `ini_read_string` ("No one") y usadas como subimagen. | `ini_read_real(..., 0)` | |
| `obj_khoru_battle/Step_0:68-81` | El combo no reinicia `comboCard_value = 0` (agua y fuego sí). | Agregar la línea | |
| `obj_agua/Step_0:44` | `count = 4` salta el bloque que vuelve a la room; `Create_0:3` dice `"espiritu_luna"`. | Revisar contra `obj_fuego` | |
| `obj_texto_anzota/Create_0:3-4` | Asigna `texto[1]` dos veces; una frase nunca se muestra. | `texto[2]`, `final = 3` | |
| `scr_lista_logros_memorin:73` | Usa `i` en vez de `k`. | `k` | |
| `scr_cleanDeck:8` | Compara `[1] != 13` y noCard es `[13, undefined, 0]`. | `[0]` (hoy inalcanzable) | |
| `scr_colision:4,13` | `creador == "player2"` entra en los dos `if` (latente: nadie asigna "player2"). | `else if` | |
| `cont_item*/Alarm_*:9-12` | `place_meeting` en un punto aleatorio y `phy_position` en otro: ítems dentro de paredes. | Usar el mismo punto | |
| `scr_listCombos:100` | `obj_flecha_espiritual.x` lee la primera flecha, no la creada. | `x` | |
| `obj_tuto_wanku/Step_0:24` | Z cerca de Wanku con el diálogo abierto avanza el paso y cambia el texto a mitad. | `!instance_exists(obj_dialogo)` | ? |
| `scr_enemy_static:23` (y `static1`) | `x = obj_player.x - 85` en la rama arriba-izquierda; la otra usa `+ 85`. Puede ser intencional (enemigo de espaldas abajo-izquierda). | | ? |
| `obj_npc/Step_0:1` | `with (obj_npc)` dentro del Step de `obj_npc`: N² por frame. | Borrar el `with` | |
| `obj_pause/Step_0:121-122` | En "Ver cartas" el cursor queda fijo en 0: Equipar, Limpiar, Renombrar y Borrar mazo no se alcanzan. ¿Recorte intencional? | | ? |
| `scr_room_transition:21-25` | `fadeState = -1` e `instance_destroy()` en el mismo frame: el fundido de entrada no ocurre. ¿Intencional? | | ? |
| `scr_cargar_mazos:16,20`, `scr_pause_rb:31`, `obj_pause/Step_0:2` | Restos de depuración, mensaje fuera del `if`, `clamp` sin asignar. | Limpieza | |

## 00_Core

| archivo:línea | principio | problema | arreglo mínimo | gravedad |
|---|---|---|---|---|
| `obj_game/KeyPress_112..115:9-12`, `Step_0:104` | D | Atajos F1-F4 y W+H+A con rooms numéricas (`temp[2] = 11/14/9/13`). | `rm_*` | media |
| `obj_game/Step_0:85-161` | S/dup | W+H+A arma su propia partida nueva (no resetea `suyai_unida`, personaje, combo) y copia el bucle de agregar cartas, que está en 6 lugares. | `scr_morral_agregar_carta()` junto a `scr_morral_agregar`; W+H+A reutiliza el bloque "nuevo" de `obj_confirmar` | media |
| `obj_game/Step_0:165-289` | S | Textos de ayuda de la pausa dentro del Step de `obj_game`; la misma posición se calcula ~20 veces. | Mover tal cual al Step de `obj_pause` | baja |
| `obj_game/Step_0:43-75` | S | Dos bloques fijan la visibilidad de capas y el segundo pisa al primero. | Una condición y un bucle | baja |

## 01_Partida

| archivo:línea | principio | problema | arreglo mínimo | gravedad |
|---|---|---|---|---|
| `obj_change`, `obj_change1`, `obj_change3`, `obj_change31` / Collision | O/D | Cada puerta es un `if (room == …)` con coordenadas y room numérica; 4 objetos casi iguales; además la lista `cambio_escena` crece en cada frame de contacto. | Un solo `obj_change` con Variable Definitions `destino`, `destino_x`, `destino_y`. Mínimo inmediato: nombres de room | media |
| `obj_cartel_room/Step_0:4-13` | O/D | Elige el título comparando con números de room; `rm_momificar` no tiene título. | Comparar con `rm_*` | media |
| `scr_guardaPartida` | dup | Sin callers; guarda a medias y dibuja fuera del Draw. | Borrarlo | baja |
| `scr_guardar_cartas:6-10`, `scr_guardar_item:6-10` | bug latente | El contador solo se pone en 0 si el .ini existía. | `ds_list_size(...)` | baja |

## 02_Jugador

| archivo:línea | principio | problema | arreglo mínimo | gravedad |
|---|---|---|---|---|
| `obj_player/Other_0:8,17` | D | `temp[2] = 12/11`: rooms numéricas (ya conocido). | `rm_*`, sin tocar `RoomOrderNodes` | alta |
| `obj_player/Step_0:12` + `obj_enemigo_normal*/Step_0` | D | El jugador depende de `instance_number(obj_enemigo_normal)` y los enemigos le escriben `enable_*`. | Mantener: todo enemigo de mapa hereda de `obj_enemigo_normal`. Desacoplar cuesta más | baja |
| `scr_amaru_clic:37-41` | O | Lista fija de objetos clicables. | Los nuevos heredan de `obj_npc` / `obj_info_*` | baja |

## 03_Batalla

| archivo:línea | principio | problema | arreglo mínimo | gravedad |
|---|---|---|---|---|
| `obj_proyectil`, `_ice`, `_ligth`, `obj_flecha_espiritual` | L | Hijos de `obj_especial` sin `event_inherited()`; Step, Alarm_0 y Other_0 copiados en los 4. ✔ | Subir los eventos a `obj_especial`; cada hijo queda con `event_inherited(); tipo = "..."` | alta |
| `obj_flecha`, `obj_cuchilla` / Step_0 | L | Reemplazan el Step de `obj_bala` y pierden el chequeo de popUp. ✔ | Un Step completo en `obj_bala`; borrar los de los hijos | alta |
| `scr_batalla_ia`, `obj_player_battle/Alarm_3`, `scr_listCombos`, `scr_ataque`, `scr_ataque_enemy`, `scr_combo_enemy` | O/dup | "Tipo de carta → acción y proyectil" repetido en 6 lugares, con 3 bloques casi iguales por especial. | En cada sitio juntar los 3 `especial_*` en uno; el objeto sale de una función de 3 filas | alta |
| `obj_proyectil*/Collision_obj_enemigo` | dup | 4 copias que solo cambian el sprite del aura que destruyen. | Un evento en `obj_especial` con `aura` en el Create de cada hijo | media |
| `scr_ataque:4`, `scr_ataque_enemy:6` | D | `global.proyectil_1/2 = 1` justo antes de cada llamada: un candado que nunca bloquea. | Borrar el `if` y las asignaciones | media |
| `obj_player_battle/Draw_0:4-21,57-58,65` | S (§4) | El Draw calcula cartas y resetea `popUp_on`; el Step lo lee un frame tarde. Igual que en la momia (`792913f`). | Mover esas líneas al Step | media |
| `scr_batalla_enemigos:171` | O | `if (object_index != obj_enemigo && object_index != obj_tojotojone)`. | `usa_patrones` en el Create (el ejemplo de `solid.md`) | media |
| `obj_battleController/Step_0:45-64`, `Alarm_1:4-27` | O/D | Una rama por espíritu o jefe; `sprite = 20/16/18` de GMS1. | `variable_global_set(global.tipo_enemigo, 1)`; `spr_card_*` | media |
| `cont_item`, `cont_item1` / Alarms | dup | Bucle de spawn copiado 4 veces (con el bug de posición). | `scr_item_spawn(obj)` | media |
| `obj_player_battle/Step_0:1-260` | S | Mezcla input, carta, combo, movimiento y una rama de tutorial duplicada. | Por ahora solo extraer el combo (58-122) | baja |
| `obj_escudo_tuto`, `obj_player_battle/Collision_obj_flecha` | dup | Colisiones por hijo que repiten la del padre; posible doble disparo. | Borrar las de los hijos y probar | baja ? |
| `scr_dibujaValores_cards` | dup | Idéntico a `scr_dibujarCartas`, sin callers. | Borrarlo | baja |

## 04_Enemigos

| archivo:línea | principio | problema | arreglo mínimo | gravedad |
|---|---|---|---|---|
| `scr_enemy_static:68,79`, `scr_enemy_static1:68,79` | D | `scr_go_to_room(5)` y `(4)`. ✔ | `rm_*` | alta |
| `scr_enemy_static/follow/static_all/start` y sus `*1` | S/O | 4 pares de scripts idénticos que solo cambian sprites. | `spr_quieto`, `spr_correr`… en el Create (como `scr_enemigo_mover`); borrar los `*1` | media |
| `obj_enemigo_{fuego,agua,luna}`, `obj_khoru_battle` / Step_0 | S/O | Step de ~135 líneas copiado; solo cambian 4 valores. | Pasar esos valores al Create y dejar un Step. Hacerlo después de los bugs | media |
| `obj_enemigo/Collision_obj_bala:3` | L/O | El padre fija `spr_enemigo_battle_danho` en todos los hijos; Khoru nunca muestra `spr_khoru_danho`. | `spr_danho` en el Create; borrar las colisiones de los hijos | media |
| Draw_0, Other_4, Other_11, Alarm_1, Alarm_2 de fuego/agua/khoru | S | Copias idénticas del padre. | Borrarlas | baja |
| `obj_enemigo_normal1/Create_0` | L | Rehace el Create del padre sin `event_inherited()`. | `event_inherited();` + sus 2 líneas | baja |
| `obj_enemigo/Create_0:28` | L | `tipo = undefined` pisa la línea 7; lo tapa `obj_battleController/Step_0:137` con `object_index == obj_enemigo`. | Borrar la línea 28 y la condición | baja |

## 05_Inventario_Creacion

| archivo:línea | principio | problema | arreglo mínimo | gravedad |
|---|---|---|---|---|
| `scr_asignaSprite_segunNombre`, `scr_asignaValores_segunMaterial`, `obj_materiales/Create_0` | O/dup | Tabla material↔sprite↔nombre en 3 lugares; la inversa no tiene las piezas de la momia. | Que una recorra a la otra: una sola tabla | media |
| `scr_cargar_receta:8-68` + `scr_recetas` + `scr_guardar_recetas` | O/dup | Cada receta es un bloque copiado y su clave .ini se repite en 3 scripts (de ahí nace el bug del arpón). | Un array de recetas con un bucle; guardar usa la misma clave | media |
| `scr_recetas_MaterialesNecesarios:13-24` | ruido | Las ramas `>=` y `<` hacen lo mismo. | Unificar, o pintar distinto lo que falta | baja |

## 07_Mundo

| archivo:línea | principio | problema | arreglo mínimo | gravedad |
|---|---|---|---|---|
| `obj_texto_*` / Step, Draw, Alarm_0 | L/dup | 9 hijos de `obj_info` (vacío) con los mismos eventos copiados. | Subir los eventos a `obj_info` y borrar los de los hijos (capilla y pictogramas conservan su Draw) | media |
| `obj_info_{anzota,…,rocas}` / Step, Draw | dup/O | 9 copias que solo cambian el texto, el radio y el depth. | `scr_info_interactuar(obj_texto_x, radio)` | media |
| `obj_moon`, `obj_agua`, `obj_fuego` / Step_0 | D/dup | Misma máquina de estados copiada, con rooms numéricas. ✔ | Mínimo: `rm_*`. Unificar cuesta más que el problema | media |

## 08_NPCs_Dialogos

| archivo:línea | principio | problema | arreglo mínimo | gravedad |
|---|---|---|---|---|
| `obj_npc_1/Step_0:30`, `obj_khoru/Step_0:76,106`, `obj_control_tutorial/Alarm_0:148-150` | D | `scr_go_to_room(3/4/15)`, `temp[2] = 11`. ✔ | `rm_*` | alta |
| `obj_control_tutorial/Step_0:97-296` | S/dup | 13 bloques iguales de diálogo de Wanku (y 5 de popUp) que solo cambian el número de paso. | Un `array_contains([...], paso)` con el cuerpo una vez | media |
| `obj_control_tutorial/Alarm_0:3-155` | S | 33 `case` que solo hacen `paso = N+1`. | `paso += 1` y los 4 efectos como `if` | media |
| NPCs con diálogo (`obj_npc`, `obj_npc_1..4`, `estolica`, `pescador`, `tejedora`, `obj_khoru`) | S/O | Copian el mismo patrón de interacción (radio, puntaje, guardado) y ya divergieron. Corrección: varios sí tienen padre (`obj_zone`); el analista dijo que ninguno. | No refactorizar los viejos; los NPC nuevos usan `obj_npc_personaje`, que ya funciona con datos | baja |
| `scr_texto_actualizar:15-18` | O | `global.texto_abierto` revisa una lista fija de 12 objetos de texto. | Padre vacío común (no `obj_dialogo`, que se usa como "diálogo de NPC abierto") | media |
| `obj_tutorial_popUp`, `obj_tutorial_popUp1`, `_popup_2` / Step | O/dup | Cadena de `if` string→sprite copiada. | `valor` con pares de sprites y `gamepad_is_connected(0)` como índice | media |
| `obj_khoru_camarones/Create_0:82-124`, `obj_tuto_wanku/Step_0:47-99` | dup | Entrega de cartas al morral copiada (6 lugares en total). | La misma `scr_morral_agregar_carta()` de 00_Core | media |
| Pasos del tutorial en 24 archivos (`obj_control_tutorial.paso == N`) | D | Números mágicos en batalla, pausa, enemigos y jugador. | `enum`/macros, solo si se toca el tutorial (ver 09_UI) | baja |
| Mínimo de cartas: `obj_wanku_aviso` `< 4`, `obj_khoru_camarones` `5`, `obj_pause` `< 5`… | D | Valores distintos escritos a mano. ¿4 y 5 son a propósito? | Un `#macro` por regla | baja ? |
| `obj_dialogo` + `obj_dialogo_premio` | dup | La posición del cuadro está 4 veces; premio es casi una copia. | Borrar el bloque del Create (el Step lo recalcula) | baja |

## 09_UI

| archivo:línea | principio | problema | arreglo mínimo | gravedad |
|---|---|---|---|---|
| `obj_confirmar/Step_0:39` | D | `scr_go_to_room(1)` para "Nuevo juego". ✔ | `rm_*` | alta |
| `scr_pause_control`, `scr_pause_back`, `scr_mouse_actualizar`, `obj_pause` Step/Draw, `scr_pause_mouse` | D/O | Pasos del tutorial (9, 10-12, 13-14, 15, 16) repetidos en ~10 lugares. | `#macro PASO_*` en un script, como `MOMIA_PASO_*` | alta |
| `scr_pause_control:48-69`, `scr_pause_back:11-28` | S/dup | "Cerrar pausa" copiado; ya divergió (`back` no revisa `instance_exists(obj_player)`). | Una función `scr_pause_cerrar()` | media |
| `scr_controlVisor_diario:2-111`, `obj_pause/Step_0:391-426` | O/dup | La misma lógica triplicada por `subMenu` (y una copia ya tiene el bug de la línea 89). | `variable_instance_get(id, "listaLogros_" + subMenu)` y un bloque | media |
| `scr_lista_logros_memorin:31-46` | O | `switch (posCursor)` con casos iguales; un logro nuevo pide otro `case`. | Quitar el switch | media |
| `scr_pause_avance:1-427` | S | Un script para mazo, borrado de cartas, momia y creación. | Una función local por bloque `menuOptions` | media |
| `scr_pause_avance:86-98,164-176`, `scr_pause_rb:11-23` | dup | Bucle de búsqueda de slot copiado 3 veces. | `scr_mazo_buscar_slot(vacio)` | media |
| `scr_pause_avance:144-162`, `scr_cleanDeck:6-24` | dup | "Devolver carta al inventario" duplicado y divergente. | Una función común | baja |
| `scr_pause_mouse:50-176` contra `obj_pause/Draw_0` | dup | Coordenadas de botones copiadas del Draw. | Arreglarlo cuesta más que el problema | baja |
| `obj_ayuda` / `obj_ayuda1` | dup | Draw idéntico; Step solo cambia el popup. | `obj_ayuda1` hijo de `obj_ayuda` con `popup_obj` | baja |
| `obj_sabias/Step_0:9-25` | O | Cadena `if (global.zona == N)`. | `maximo = [0,3,5,7,9,10,13][global.zona]` | baja |
| `obj_confirmar/Draw_0:6-48`, `obj_menuController/Draw_0:8-11` | dup/O | Bloques iguales que solo cambian el frame; sprites del menú a mano. | Un bloque con índice; usar `menuInicial_spr[i]` | baja |
| `scr_menuDeck:4` | D | Elige por índice con nombres distintos a `menuDeck[]` (la misma clase de bug ya corregida en `scr_menu`). | Elegir por nombre | baja |

## Límites de la revisión

- Nadie probó nada en el IDE. Las marcas ? necesitan tu confirmación.
- Quedaron leídos solo por estructura: `obj_pause/Draw_0` (780 líneas), los textos de `scr_text_npc` y la capa GMS1 de `00_Core`.
- Antes del refactor 2 hay que confirmar en el IDE qué room es cada número (1, 3, 4, 5, 9, 11, 12, 13, 14, 15): el índice de asset puede no coincidir con `RoomOrderNodes`.
