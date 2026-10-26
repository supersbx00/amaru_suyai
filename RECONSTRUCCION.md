# Reconstrucción v2: con los datos reales del `data.win`

Fuentes:
- **Código:** los 739 `.gml` exportados por UndertaleModTool, copiados byte a byte.
- **Estructura:** `amaru_suyai/data.win` (GameMaker Studio 2.0, bytecode 16), leído directamente.
- **Imágenes de sprites:** la carpeta `sprites/` (coinciden con el `data.win` en tamaño y en número de frames).

## Formato: GameMaker 2024.13.1.193

El lector de proyectos de GameMaker 2024 es estricto: exige la versión exacta de cada registro (`"$GMObject":"..."`), solo admite los campos que conoce y los quiere en orden alfabético.
El esquema se extrajo de un proyecto creado con tu IDE (`Chinhcorro_pvp`, solo lectura) y de los shaders de ejemplo del runtime 2024.13. Está en `_recuperado/herramientas/gm_schema_2024_13.json` y el generador ajusta cada registro a ese esquema antes de escribirlo.

Cuatro tipos no tenían referencia en tu equipo. Se ajustaron con los mensajes de error del propio IDE: `GMTileSet` `v1` (sin el campo `tileAnimation`, que 2024.13 ya no acepta), `GMRGraphic` `v1`, y `GMRTileLayer` y `GMRAssetLayer` con versión `""`.

## Contenido

| Recurso | Cantidad | Detalle |
|---|---|---|
| Objetos | 144 | Sprite, máscara, padre, sólido, visible, persistente y física reales. 468 eventos |
| Rooms | 16 | 1.390 instancias con posición, escala, rotación, color y código de creación; capas con su profundidad; vistas; mundo físico |
| Tiles | 18 tilesets, 8 capas, 5.113 tiles | Imagen de cada tileset reconstruida desde la textura compilada; datos en el formato comprimido de 2024 |
| Sprites | 293 + 18 de tilesets | Origen, caja de colisión, tipo de máscara y velocidad de animación reales |
| Scripts | 87 + `__global_init` | Cuerpo intacto dentro de `function nombre() { }` |
| Sonidos | 8 | 6 WAV extraídos del `data.win` + `snd_battle.ogg` y `sound_wind.ogg` |
| Fuentes | 3 | `general` (Gisha 18), `little` (Gisha 10 negrita), `description` (Gisha 16), con su textura y glifos originales |
| Shader | `sh_pixel` | Código GLSL ES original (sin la cabecera que añade el compilador) |
| Paths | 3 | `move_path`, `move_path2`, `move_path3` |
| Opciones | — | 30 FPS, ventana de 1320×780, interpolación de píxeles según el original |

## Verificación

`validate_v2.py` vuelve a leer el `data.win` y compara cada recurso con su fuente. Resultado: **0 errores**.
- 468 eventos y todos los códigos de room e instancia: idénticos byte a byte a los `.gml` exportados.
- 1.390 instancias: mismo objeto, posición, código y orden de creación.
- 5.113 tiles: descomprimidos y comparados celda por celda con el original.
- Sprites, padres y propiedades de los 144 objetos: iguales al original.
- El orden de las rooms es el mismo que el original.

Además, `schema.py` compara cada tipo de registro con tu GameMaker 2024.13: todos los que tienen referencia coinciden en versión, campos y orden.

Se renderizaron `rm_anzota_2` y `rm_cuevas_anzota` usando solo los archivos generados (están en `_recuperado/vistas_previas/`).

## Decisiones a tener en cuenta

1. **Tilesets.** El `data.win` guarda cada tileset compilado, con bordes entre los tiles. Se recortaron y reempaquetaron en sprites nuevos con el sufijo `_img`, dentro de la carpeta `Sprites/Tilesets`. Los índices de tile son los mismos del original.
2. **Índices de room.** El código cambia de room con números (`scr_go_to_room(7)`). El orden de las rooms es el original. `__global_init` comprueba al arrancar que los índices coinciden: si ves `[reconstruccion] AVISO: la room ...` en la consola, hay que ajustarlo. **No se modificó ningún código del juego.**
3. **Nombres de instancia.** Siguen el formato `inst_<id original>`. El código no hace referencia a ninguno.
4. **Scripts vacíos en el original:** `scr_pause_tutorial` y `scr_logros` se incluyen como funciones vacías.
5. **Fuente Gisha.** Las texturas son las originales, así que no necesitas tener Gisha instalada, salvo que pulses "Regenerate".
6. **Comportamiento antiguo.** Las opciones *legacy* (copy-on-write en arrays y compatibilidad de colisiones) están activadas para que el juego se comporte como en GMS 2.0.
7. **Textos con `#`.** En GMS 2.0 el `#` era un salto de línea. GameMaker 2024 lo muestra tal cual. No se cambió.

## Regenerar

Desde la carpeta de los `.gml` (requiere Python 3 y Pillow):

```
python proyecto_reconstruido_v2/_recuperado/herramientas/rebuild_v2.py . amaru_suyai proyecto_reconstruido_v3
python proyecto_reconstruido_v2/_recuperado/herramientas/validate_v2.py . amaru_suyai proyecto_reconstruido_v3
```

**Importante:** genera siempre en una carpeta nueva (por ejemplo `_v3`). Si usas una carpeta que ya existe, el generador sobrescribe los archivos pero no borra los que sobran, y pueden quedar restos de la versión anterior.

## Mapa del proyecto (graphify)

`graphify-out/graph.html` es un mapa interactivo del juego; ábrelo en el navegador (necesita internet para cargar la librería de visualización). `GRAPH_REPORT.md` es el informe de graphify.

Graphify no soporta GML, así que el grafo lo genera `_recuperado/herramientas/gml_graph.py` y graphify solo hace la agrupación, el HTML y las consultas:

```
python proyecto_reconstruido_v2/_recuperado/herramientas/gml_graph.py proyecto_reconstruido_v2
graphify cluster-only proyecto_reconstruido_v2
graphify explain obj_player --graph proyecto_reconstruido_v2/graphify-out/graph.json
graphify path obj_confirmar rm_battle --graph proyecto_reconstruido_v2/graphify-out/graph.json
```

- **Nodos (292):** objetos, scripts, rooms, sonidos, fuentes, shader, paths y variables `global.*` que usan dos o más recursos. Los sprites y tilesets van como dato dentro de cada nodo, para no llenar el mapa.
- **Relaciones:** `hereda_de`, `colisiona_con`, `crea`, `va_a`, `contiene`, `llama`, `controla_con_with`, `consulta`, `escribe`/`lee`, `referencia` y `usa_*`. Las del mismo par de nodos se fusionan en una arista; la lista completa está en el campo `relaciones`.
- **`va_a` por índice numérico** (`scr_go_to_room(7)`) se marca como `INFERRED`, resuelto con el orden real de las rooms.
- **Se omiten las llamadas a scripts de compatibilidad** (`instance_create`, `__view_get`...), porque se usan en todas partes y taparían el mapa.
- **Comunidades "Sin uso":** objetos y scripts que ninguna room coloca y ningún código menciona.
- **Etiquetas:** los nombres de las comunidades están en `graphify-out/.graphify_labels.json`. Los puse a mano, sin IA. Si regeneras con cambios grandes, revísalos.
