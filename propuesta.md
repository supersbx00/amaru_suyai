# Propuesta de reorganización — `juego_reconstruido`

Basado en el análisis de `graphify-out/` (292 nodos, 1024 edges, 34 comunidades detectadas, 97% de relaciones extraídas directamente del código).

## 1. Diagnóstico del estado actual

El proyecto `.yyp` está organizado **solo por tipo de recurso de GameMaker**, no por dominio/funcionalidad:

```
folders/Objects.yy
folders/Scripts.yy
  folders/Scripts/Compatibility.yy   (única subcarpeta real)
folders/Rooms.yy
folders/Sprites.yy
  folders/Sprites/Tilesets.yy
folders/Sounds.yy
folders/Paths.yy
folders/Fonts.yy
folders/Shaders.yy
```

144 objetos y 88 scripts conviven en dos carpetas planas. No hay ninguna agrupación que diga "esto es batalla", "esto es el minijuego de la momia", "esto es el núcleo del juego". Para encontrar algo hay que conocer el nombre exacto o recorrer todo.

Graphify, en cambio, reconstruyó la estructura **real** de dependencias (llamadas, colisiones, instanciación, referencias a rooms/sprites) y agrupó el código en comunidades funcionales con buena cohesión. Esa es la base de la propuesta: usar esas comunidades como carpetas virtuales en el proyecto.

## 2. Lo que dice el grafo

**Hubs (god nodes)** — los objetos más conectados, que actúan de columna vertebral y aparecen referenciados desde varias comunidades:

| Objeto | Conexiones | Rol |
|---|---|---|
| `obj_player` | 78 | jugador, bridge entre casi todas las comunidades |
| `obj_game` | 57 | controlador global / orquestador |
| `obj_pause` | 50 | sistema de pausa |
| `obj_player_battle` | 48 | jugador en modo batalla |
| `obj_control_tutorial` | 48 | tutorial, bridge entre comunidades |
| `obj_battleController` | 45 | orquestador de batalla |
| `obj_morral` | 36 | inventario |
| `obj_enemigo` | 31 | enemigos |
| `obj_dialogo` | 27 | diálogos |
| `rm_humedal` | 27 | room más conectada |

`obj_player`, `obj_game` y `obj_control_tutorial` tienen alta "betweenness centrality": no pertenecen a un solo módulo, son **puentes** entre módulos. Esto importa para la reorganización: si se las mete a la fuerza dentro de una sola carpeta temática, se pierde la noción de que son núcleo transversal.

**Comunidades con buena cohesión** (candidatas directas a carpeta):

| # | Nombre | Nodos | Cohesión |
|---|---|---|---|
| 0 | Batalla: jugador, enemigos y proyectiles | 63 | 0.10 (difusa, ver 6) |
| 1 | Núcleo: obj_game, pausa, guardado y transiciones | 58 | 0.07 (difusa) |
| 2 | Mundo: rooms y escenarios | 37 | 0.11 |
| 3 | Minijuego de la momia (órganos y huesos) | 26 | 0.18 |
| 4 | Textos informativos y carteles | 23 | 0.17 |
| 5 | Tutorial, diálogos y espíritus | 16 | 0.26 |
| 6 | NPCs y puntaje | 16 | **0.38** |
| 7 | Jugador y cambio de zona | 13 | 0.19 |
| 8 | Pausa, ayudas y popups | 10 | 0.24 |
| 9 | Compat. GMS1: profundidades | 3 | 0.67 |
| 10 | Compat. GMS1: acciones | 3 | 0.67 |
| 11 | Animales (gaviotas) | 2 | — |

Las comunidades 0 y 1 son grandes y con cohesión baja (0.10 y 0.07): el propio reporte lo marca como pregunta abierta ("¿debería dividirse Batalla en módulos más chicos?"). Son "cajones" razonables para empezar, pero con el tiempo conviene partirlas.

**Capa de compatibilidad GMS1→GMS2** (9 nodos, cohesión altísima 0.67 — están muy aislados del resto): `__global_init`, `__init_global`, `__init_view`, `__view_get`, `action_restart_game`, `action_set_motion`, `instance_create`, `tile_get_count`, `tile_get_id`, `tile_set_alpha`, `object_get_depth`, `__global_object_depths`, `__init_action`. Son shims que reimplementan funciones de GM8/Studio 1. Ya existe una carpeta `Scripts/Compatibility` a medias — conviene completarla y aislarla del resto del código de gameplay.

**71 nodos aislados o con ≤1 conexión** (35 scripts, 28 objetos, 3 paths, 2 sonidos, 2 fuentes, 1 shader) — candidatos a "no se usan / revisar antes de borrar". Ejemplos: `obj_choza_1/2/3`, `obj_pasto`, `obj_go`, `obj_prueba`, `obj_totora_1/2/3/5/6`, `obj_roca/2/3`, `scr_danho`, `scr_logros`, `scr_player_move`, `scr_pause_tutorial`, `snd_defeat`, `snd_khoru`, `sh_pixel`. El grafo no detectó ciclos de importación (buena noticia).

**5 relaciones inferidas a verificar**: `obj_agua`→`rm_battle`, `obj_agua`→`rm_costa_humedal`, `obj_player`→`rm_costa_humedal`, `obj_player`→`rm_humedal`, `obj_game`→`rm_anzota` (y `rm_camarones`). Son solo el 3% del grafo, confianza media (0.5) — antes de mover nada que dependa de ellas, vale la pena confirmarlas a mano.

## 3. Estructura propuesta

No se reorganizan carpetas físicas de disco (eso rompe GUIDs/paths del `.yyp`). Se reorganiza el **árbol de carpetas virtuales dentro del proyecto GameMaker** (`folders/*.yy`), que es justamente lo que ya existe hoy con `Scripts/Compatibility`. Dentro de GameMaker esto se hace arrastrando recursos en el Asset Browser; no implica tocar código ni archivos `.yy` de cada recurso más que su referencia de carpeta padre.

```
📁 00_Core                      ← obj_player, obj_game, obj_control_tutorial, obj_pause,
                                   obj_battleController, obj_morral  (los hubs transversales,
                                   visibles aparte para que no se "escondan" en un módulo)
📁 01_Batalla                   ← Comunidad 0 (63 nodos: enemigos, proyectiles, items de batalla)
   📁 Objetos
   📁 Scripts
📁 02_Nucleo_Partida             ← Comunidad 1 menos los ya listados en 00_Core
                                   (pausa, guardado, transiciones de room)
📁 03_Mundo_Rooms                ← Comunidad 2 (rooms y escenarios) + Comunidad 11 (animales)
📁 04_Minijuego_Momia            ← Comunidad 3 (órganos y huesos)
📁 05_Textos_Carteles            ← Comunidad 4
📁 06_Tutorial_Dialogos          ← Comunidad 5
📁 07_NPCs_Puntaje               ← Comunidad 6 (la de mejor cohesión, 0.38)
📁 08_Jugador_CambioZona          ← Comunidad 7
📁 09_Pausa_Ayudas_Popups        ← Comunidad 8
📁 10_Compatibilidad_GMS1        ← Comunidades 9 y 10 + los 6 "enlaces omitidos"
                                   (ampliar la carpeta Scripts/Compatibility que ya existe)
📁 99_Sin_Uso_Revisar            ← los 71 nodos aislados, para auditar y decidir baja
📁 Rooms / Sprites / Sounds / Fonts / Paths / Shaders
                                   (se mantienen como están — son recursos "hoja" sin
                                   lógica propia, reordenarlos no aporta tanto como
                                   reordenar objetos/scripts)
```

Notas sobre el diseño:

- **`00_Core` es la novedad clave.** El reporte es explícito en que `obj_player`, `obj_game` y `obj_control_tutorial` son puentes entre comunidades (alta betweenness). Meterlos dentro de "Batalla" o "Tutorial" porque ahí los puso el clustering automático escondería su rol real. Separarlos aparte documenta la arquitectura tal como es.
- **Las comunidades 0 y 1 son grandes y de cohesión baja.** Se proponen como punto de partida, pero a futuro conviene dividirlas (el propio reporte sugiere evaluar partir "Batalla" en sub-módulos: enemigos / proyectiles / items).
- **`10_Compatibilidad_GMS1`** aísla deuda técnica heredada de una migración GM8→Studio 1→GMS2. Separarla ayuda a no confundir "lógica de juego" con "parches de compatibilidad del motor".
- **`99_Sin_Uso_Revisar`** no es borrado automático — es una zona de cuarentena para que alguien confirme uno por uno si cada asset se usa (podría haber referencias dinámicas que graphify no detecta, p. ej. `asset_get_index`/strings con nombres de sprite).

## 4. Plan de migración (sin tocar código)

1. **Fase 0 — Verificación**: confirmar a mano las 5 relaciones inferidas y revisar los 71 nodos aislados (¿de verdad no se usan, o hay referencias dinámicas?).
2. **Fase 1 — Compatibilidad**: mover los 13 scripts de compat GMS1 a `10_Compatibilidad_GMS1` (bajo riesgo, ya están casi todos juntos).
3. **Fase 2 — Núcleo**: crear `00_Core` con los 6 hubs.
4. **Fase 3 — Comunidades grandes**: crear `01_Batalla` y `02_Nucleo_Partida` moviendo los nodos restantes de las comunidades 0 y 1.
5. **Fase 4 — Resto de comunidades**: crear las carpetas 03 a 09 según la tabla.
6. **Fase 5 — Cuarentena**: mover los 71 aislados a `99_Sin_Uso_Revisar`; después de un tiempo sin romper nada, decidir baja definitiva.

Cada fase es solo mover recursos de carpeta virtual en el editor de GameMaker (drag & drop en el Asset Browser) — no cambia código, eventos ni GUIDs, así que es reversible y de bajo riesgo. Se puede hacer incremental, una fase por sesión, probando que el juego sigue abriendo/compilando entre cada una.

## 5. Preguntas abiertas (del propio reporte)

- ¿Vale la pena dividir "Batalla" (cohesión 0.10) en submódulos de enemigos / proyectiles / items?
- ¿Las comunidades "Textos informativos" y "Tutorial/diálogos" deberían fusionarse (ambas giran en torno a UI narrativa)?
- ¿Los 71 nodos aislados son candidatos reales a eliminar, o hay uso dinámico no detectado?
