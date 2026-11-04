# Reglas de Proyecto: GameMaker Studio 2 (GML) & Claude Code

## 1. Protocolo de Aprobación y Modificaciones (OpenSpec Plan-First)
- **Consulta Obligatoria:** NUNCA modifiques ni generes código (.gml), scripts (.py) ni documentación (.md) sin presentar un plan previo y obtener aprobación explícita.
- **Flujo Plan-First:** Ante cualquier requerimiento, define la propuesta técnica brevemente, consulta dudas aclaratorias y espera la confirmación antes de modificar archivos.

## 2. Estructura del Proyecto: Rutas por Defecto + Grupos (OBLIGATORIO)
- **Rutas Nativas:** Cada recurso permanece en la ruta por defecto de GameMaker (`scripts/<nombre>/`, `objects/<nombre>/`, `rooms/<nombre>/`). Queda prohibido mover archivos físicos a carpetas por dominio o cambiar sus rutas en el `.yyp`.
- **Grupos por Feature:** El orden vive en los grupos virtuales de GameMaker, con la forma `<Feature>/<Responsabilidad>` (ej. `02_Jugador/Movimiento`, `06_Momia/Pasos`). No se crean subgrupos por tipo como `Scripts` u `Objects` dentro de una feature. Las rooms son la excepción (ver sección 3).
- **Dónde Ubicar un Recurso:**
  1. En la feature cuya mecánica implementa.
  2. Si es escenario de un lugar, en `07_Mundo`.
  3. Si lo usan varias features y ninguna es su dueña, en `00_Core`.
- **Features:** `00_Core`, `01_Partida`, `02_Jugador`, `03_Batalla`, `04_Enemigos`, `05_Inventario_Creacion`, `06_Momia`, `07_Mundo`, `08_NPCs_Dialogos`, `09_UI` y `99_Sin_Uso_Revisar`.

## 3. Organización de Rooms
- **Grupo Nativo:** Cada room conserva su ruta por defecto y va directamente en el grupo `Rooms` de GameMaker, sin subgrupos ni grupos por feature. Una room mezcla recursos de varias features, así que ninguna es su dueña.
- **Orden Intocable:** Mover una room de grupo no cambia su orden de ejecución. No se altera `RoomOrderNodes` sin revisar antes `obj_player/Other_0`, que usa índices numéricos de room.

## 4. Arquitectura Feature Cascade Idiomática (Nativa de GML)
- **Sin Mappers ni DTOs:** Prohibido crear Mappers, DTOs o abstracciones empresariales pesadas. GameMaker resuelve la asignación visual de forma nativa (`draw_sprite_ext`, `sprite_index`).
- **Pipeline en Cascada:** Las mecánicas se estructuran como un pipeline ordenado de ejecución en el evento `Step` mediante structs/constructores ligeros en la subcarpeta del dominio correspondiente:
  1. **Input / Intención:** Lectura de controles.
  2. **Movimiento & Colisión:** Actualización de `x`, `y`, `hsp`, `vsp`.
  3. **Físicas Secundarias:** Procesamiento de capas, colas (*ponytail*) o ropa usando la posición `x, y` final calculada.
  4. **Render:** Dibujo directo en el evento `Draw` (sin clases intermedias de vista).

## 5. Optimización de Contexto con gms-mcp
- **Consultas Ligeras:** Usa siempre las herramientas de `gms-mcp` para inspeccionar objetos, eventos y scripts. Queda prohibido leer archivos `.yy` o `.yyp` completos en la ventana de contexto.
- **Indexación Selectiva:** Lee únicamente los eventos o scripts de la subcarpeta involucrada en la tarea actual.

## 6. Disciplina Clean Code (Ponytail) & Linter
- **Built-in First:** Es obligatorio usar funciones nativas de GML (`instance_place`, `point_distance`, etc.) antes de construir algoritmos manuales.
- **Cambio Mínimo Correcto:** Resuelve los requerimientos modificando la menor cantidad de líneas posibles.
- **Validación Obligatoria:** Antes de dar por finalizada cualquier modificación `.gml`, ejecuta el linter estático que escanea recursivamente todas las subcarpetas:
  `python3 tools/gml_linter.py scripts/`