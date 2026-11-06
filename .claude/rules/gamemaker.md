# Reglas de Proyecto: GameMaker Studio 2 (GML) & Claude Code

## 1. Protocolo de Aprobación y Modificaciones (OpenSpec Plan-First & Prompt en MD)
- **Consulta Obligatoria:** NUNCA modifiques ni generes código (.gml), scripts (.py) ni documentación (.md) sin presentar un prompt previo y obtener aprobación explícita.
- **Prompt en archivo:** Ante un requerimiento nuevo, Claude escribe el prompt (Contexto, Tarea, Restricciones, Formato y Verificación, solo las piezas necesarias) en `docs/prompts/<tarea>.md`, no en el chat. Si el resultado no es el esperado, primero se revisa qué pieza faltó.
- **Respuesta en chat (corta):**
  1. Primera línea: "No apliqué nada, falta tu aprobación."
  2. Resumen de una línea y la ruta del `.md`.
  3. Las preguntas (entre 3 y 10) si algo no está claro, y los riesgos que el usuario deba saber.
  4. La pregunta de aprobación.
- **Verificación:** El `.md` separa lo que revisa Claude (linter, diff) de lo que prueba el usuario en el IDE, con pasos concretos.
- **Revisión:** El usuario puede editar el `.md` en su IDE o corregir por chat. Claude relee el archivo antes de aplicar.
- **Aprobación:** OpenSpec y los cambios reales empiezan solo con aprobación explícita del prompt.
- **Excepción:** No aplica a consultas, commits ni tareas de git.
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
- **Pipeline en Cascada:** Las mecánicas se estructuran como un pipeline ordenado de ejecución en el evento `Step` mediante structs/constructores ligeros en los scripts del grupo de la feature correspondiente:
  1. **Input / Intención:** Lectura de controles.
  2. **Movimiento & Colisión:** Actualización de `x`, `y`, `hsp`, `vsp`.
  3. **Físicas Secundarias:** Procesamiento de capas, colas (*ponytail*) o ropa usando la posición `x, y` final calculada.
  4. **Render:** Dibujo directo en el evento `Draw` (sin clases intermedias de vista).

## 5. Optimización de Contexto con gms-mcp
- **Consultas Ligeras:** Usa siempre las herramientas de `gms-mcp` para inspeccionar objetos, eventos y scripts. Queda prohibido leer archivos `.yy` o `.yyp` completos en la ventana de contexto.
- **Indexación Selectiva:** Lee únicamente los eventos o scripts del grupo involucrado en la tarea actual.
- **Subagentes con Medida:** No lanzar subagentes salvo que la tarea lo justifique (ej. una auditoría de todo el proyecto) y el usuario lo apruebe; cada uno parte de cero y gasta mucho.
- **Búsquedas Puntuales:** Investigar con greps acotados y leer solo las líneas necesarias, no archivos completos.

## 6. Disciplina Clean Code (Ponytail) & Linter
- **Built-in First:** Es obligatorio usar funciones nativas de GML (`instance_place`, `point_distance`, etc.) antes de construir algoritmos manuales.
- **Cambio Mínimo Correcto:** Resuelve los requerimientos modificando la menor cantidad de líneas posibles.
- **Validación Obligatoria:** Antes de dar por finalizada cualquier modificación `.gml`, ejecuta el linter estático que escanea recursivamente todas las subcarpetas:
  `python3 tools/gml_linter.py scripts/`