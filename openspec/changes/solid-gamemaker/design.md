# Design

## Context

La regla 4 de `gamemaker.md` ya fija la cascada por evento y prohíbe las abstracciones pesadas. GML no tiene interfaces ni clases. Lo que sí trae: objetos padre con `event_inherited()`, structs, funciones y macros. Ver `proposal.md`, sección Why.

## Goals / Non-Goals

**Goals:**
- Que cada principio se pueda aplicar con lo nativo de GML.
- Que cada caso del documento sea código real y citable (`archivo:línea`).

**Non-Goals:**
- Definir interfaces simuladas, inyección de dependencias o capas nuevas.
- Corregir los casos que el documento muestra: eso es trabajo de la auditoría.

## Decisions

1. **Precedencia:** si un principio pide una capa extra, gana la regla 4. La regla lo dice en su primera línea. Alternativa descartada: SOLID completo, que choca con la regla 4.
2. **Dos archivos:** la regla es corta porque se carga en cada sesión, y el documento es largo porque es para estudiar. Alternativa descartada: un solo archivo, que gastaría contexto en cada sesión.
3. **Casos reales elegidos** (revisados al proponer; se confirman las líneas al aplicar):
   - **S:** la cascada de la regla 4 como forma correcta, y `scr_batalla_escudo` como script de una sola responsabilidad.
   - **O:** `scr_enemigo_elegir_patron` (`scripts/scr_batalla_enemigos`) decide con `object_index != obj_enemigo && object_index != obj_tojotojone`, así que un enemigo nuevo obliga a editar la función. Como contraste bien hecho, `scr_batalla_enemigo_principal`, donde una batalla nueva solo agrega una fila.
   - **L:** `obj_tojotojone`, `obj_khoru_battle` y los espíritus heredan de `obj_enemigo`. Las colisiones contra el padre también los alcanzan, así que todos deben tener las variables que esos eventos usan.
   - **I:** un `obj_enemigo` que acumule lo que solo usa un tipo de enemigo obliga a todos sus hijos a cargarlo.
   - **D:** `global.proyectil_2 = 1` justo antes de cada `scr_ataque_enemy(...)`: una global que hace de argumento escondido. Y los índices numéricos de sala, la clase de bug que ya arreglamos.
4. **Formato del "después":** GML válido y corto, marcado como ilustrativo. Alternativa descartada: aplicarlo ya, que es la auditoría y cambia comportamiento.

## Risks / Trade-offs

- [Que se use SOLID para justificar capas] → la regla empieza por la precedencia de la regla 4.
- [Que el código cambie y el caso citado quede viejo] → el documento cita archivo y función, y la auditoría lo actualiza al corregir cada caso.
- [Que la regla engorde el contexto de cada sesión] → máximo una línea y 5 líneas de ejemplo por principio.
