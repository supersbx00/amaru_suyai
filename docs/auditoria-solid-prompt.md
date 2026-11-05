# Prompt de la auditoría SOLID (para estudio)

Cómo se armó la auditoría de [auditoria-solid.md](auditoria-solid.md). Tiene tres piezas: el prompt acordado con el usuario, el encargo común que recibió cada analista y el encargo propio de cada uno.

## 1. Prompt acordado

**Contexto**
- El proyecto es de GameMaker y está ordenado por features.
- La momia ya se refactorizó con SOLID y sirve de ejemplo de lo que se espera.
- Las reglas que mandan son `solid.md` y `gamemaker.md`. Si chocan, gana la sección 4 de `gamemaker.md`: nada de mappers, DTOs ni capas que GML no trae.

**Tarea**
Encontrar en las features `00_Core` a `09_UI`, sin `06_Momia`, el código que no cumple S, O, L, I o D. Con eso se arma un informe que sirva para elegir qué refactorizar primero.

**Restricciones**
- Los analistas solo leen: no tocan archivos, no corren git y no abren la CLI de GameMaker.
- Para inspeccionar usan `gms-mcp` o leen los `.gml` directamente. No leen los `.yy` ni el `.yyp` completos.
- Solo reportan problemas con un costo real: un bug, código duplicado o algo que obligue a editar condiciones cada vez que se agrega contenido.
- Cada arreglo propuesto debe ser el cambio mínimo, sin abstracciones nuevas.
- `99_Sin_Uso_Revisar` queda fuera.

**Reparto (5 analistas en paralelo, unas 3.000 líneas cada uno)**

| Analista | Features | Recursos / líneas |
|---|---|---|
| A | `03_Batalla` | 41 / 3.430 |
| B | `04_Enemigos` + `02_Jugador` | 28 / 2.951 |
| C | `08_NPCs_Dialogos` | 30 / 3.258 |
| D | `09_UI` | 37 / 3.491 |
| E | `00_Core` + `01_Partida` + `05_Inventario_Creacion` + `07_Mundo` | 101 / 3.343 |

Las líneas se contaron sumando los `.gml` de cada recurso cuyo `.yy` tiene de `parent` un grupo de la feature.

**Formato**
Cada analista devuelve una tabla: archivo:línea, principio, problema, costo real, arreglo mínimo y gravedad. Después se unen en un solo informe con un resumen del orden de refactor, una sección por feature y los bugs aparte.

**Verificación**
- **Claude:** abre en el código cada hallazgo de gravedad alta y descarta los que no se sostienen; comprueba con `git status` que solo hay archivos nuevos en `docs/`.
- **Usuario:** lee el informe y elige qué feature va primero. No hay prueba en el IDE, porque no cambia código.

## 2. Encargo común de los analistas

### Encargo común: auditoría SOLID (SOLO LECTURA)

Repo: /workspaces/proyecto_reconstruido_v2 (GameMaker Studio 2, GML).

#### Reglas duras
- SOLO LEER. No crear, editar ni borrar archivos. No correr git, ni la CLI de GameMaker, ni el linter con escritura.
- Leer los .gml (objects/<obj>/*.gml, scripts/<scr>/*.gml) directamente con Read/grep. NO leer archivos .yy ni el .yyp completos. Si necesitas el padre de un objeto: `grep -o '"parentObjectId":[^}]*}' objects/<obj>/<obj>.yy`.
- Puedes hacer grep en todo el repo para ver quién llama a qué (callers fuera de tu feature cuentan).

#### Criterio
Lee primero /workspaces/proyecto_reconstruido_v2/.claude/rules/solid.md (los 5 principios con ejemplos GML) y la sección 4 de .claude/rules/gamemaker.md. Precedencia: nada de mappers, DTOs, capas ni abstracciones que GML no trae. SOLID es guía, no excusa para agregar código.

Reporta SOLO problemas con costo real:
- causa o puede causar un bug (ej. hijo sin event_inherited() que pierde variables que el padre usa; índices numéricos de room/recurso; globales fijadas antes de una llamada en vez de argumentos),
- código duplicado que hay que cambiar en varios lugares a la vez,
- agregar un enemigo/batalla/NPC/ítem nuevo obliga a editar condiciones existentes (if object_index == ..., switch por nombre),
- un evento/script que mezcla varias responsabilidades y por eso es difícil de tocar sin romper algo.
NO reportes estilo, nombres, "podría ser más elegante", ni código muerto de la capa de compatibilidad GMS1 salvo que tenga un bug.

Para cada hallazgo propone el ARREGLO MÍNIMO (menos líneas, funciones nativas de GML, sin abstracciones nuevas). Si el arreglo sería más grande que el problema, dilo y bájale la gravedad.

Verifica cada hallazgo leyendo el código real; cita la línea exacta. No inventes.

#### Formato de respuesta (en español)
Una tabla markdown por feature:

| archivo:línea | principio | problema (1 frase) | costo real | arreglo mínimo | gravedad |

gravedad = alta (bug o lo frena seguido) / media / baja.
Después de las tablas, una sección "Bugs vistos de paso" (cosas que no son SOLID pero parecen errores), con archivo:línea.
Al final, 2-3 líneas: qué refactor de tu zona harías primero y por qué. Máximo ~60 líneas en total.

## 3. Encargo de cada analista

Cada uno recibió: "Eres el analista X de una auditoría SOLID de solo lectura. Lee primero el encargo común y síguelo al pie de la letra", más su zona con la lista completa de scripts y objetos. Notas propias de cada zona:

- **A (03_Batalla):** sin notas extra.
- **B (04_Enemigos + 02_Jugador):** `obj_player/Other_0` usa índices de room (conocido); reportarlo sin proponer tocar `RoomOrderNodes`.
- **C (08_NPCs_Dialogos):** sin notas extra.
- **D (09_UI):** el atajo W+H+A del menú es intencional; no reportarlo.
- **E (Core, Partida, Inventario, Mundo):** la capa GMS1 (`__*`, `action_*`, `instance_create`, `object_get_depth`) solo se revisa por bugs; `scr_recetas` borra los guardados a propósito; revisar además el posible `* 16` de `obj_inventario/Step_0`.

## 4. Qué se aprendió

- **Verificar cada hallazgo alto vale la pena.** El analista C dijo que ningún NPC tenía padre, pero varios son hijos de `obj_zone` (probablemente su grep no calzó con el formato del `.yy`). Se corrigió en el informe.
- **Pedir el "costo real" filtró el ruido.** Casi no llegaron hallazgos de estilo; los que llegaron venían con la gravedad bajada por el propio analista.
- **Pedir "bugs vistos de paso" rindió más que SOLID.** Los arreglos de una línea más valiosos (guardado del arpón, carga de Khoru, inventario) salieron de esa sección.
- **Las causas se repiten entre features** (índices GMS1, hijos que copian al padre, tablas repetidas). Un refactor por causa, como `refactor/rooms-por-nombre`, a veces sirve más que uno por feature.
