# Design

## Context

Auditoría SOLID de `06_Momia` del 2026-11-05: 21 recursos, unas 1.260 líneas. Ver `proposal.md`, sección Why. Lo observado y relevante para el diseño:

- **Posiciones copiadas:** (622,123) para el cráneo y (607,253) para el esternón, en `obj_controlador/Step_0:122-130`, `obj_mensaje/Step_0:48` y `obj_cuerpo/Draw_0:38`.
- **Pasos sin nombre:** `global.numero` se compara con números en `obj_mensaje` (Create, Step, Draw), `obj_controlador`, `obj_inventario/Draw_0` y `obj_cuerpo/Draw_0`. `can_snap` usa los mismos números de paso (6, 9, 11, 12, 14, 15, 16 y 17).
- **Sprites de las piezas repetidos:**
  - `obj_controlador/Step_0:56-101,157-183`: `snap[i]` usa el sprite de la pieza `i + 1`.
  - `obj_inventario/Step_0:71-125`: `mouse_arrastrar = n` usa el sprite de la pieza `n`.
  - Ambos siguen la misma numeración que `scr_momia_costos` (1-6 madera, 7-8 relleno, 9 arcilla, 10 faldellín, 11 pelo, 12 máscara).
- **`global.controlsnap`** cuenta las piezas puestas y no es un número de paso.

## Goals / Non-Goals

**Goals:**
- Cada dato (posición, sprite o número de paso) está escrito en un solo lugar.
- El juego se comporta igual, y el diff lo demuestra: cada número se reemplaza por una macro del mismo valor y el código movido es idéntico.

**Non-Goals:**
- Mover archivos o cambiar grupos. En la segunda tanda los `.yy` se tocan solo en su `eventList`.
- Renombrar `global.controlsnap`, `can_snap` u otras variables existentes.
- Los puntos fuera de alcance de `proposal.md`.

## Decisions

### 1. Dónde vive cada cosa
- **En `scr_momia_control`:** las macros de paso, las posiciones del cráneo y el esternón, `scr_momia_craneo_cerrado()` y las 2 funciones extraídas del Step. Es el script que ya maneja el flujo del minijuego.
- **En `scr_momia_materiales`:** `scr_momia_piezas()`, porque es un dato hermano de `scr_momia_costos` y usa la misma numeración.
- **Alternativa descartada:** crear un script nuevo en `06_Momia/Pasos`. Obliga a crear un `.yy`, y la regla del cambio mínimo pide no hacerlo.

### 2. Tabla de piezas como función que devuelve un array
`scr_momia_piezas()` devuelve los sprites por número de pieza, con `-1` en el índice 0. Es el mismo estilo de `scr_momia_costos()`.
- La arcilla (9) queda con `spr_barro`, que es lo que hoy asigna `obj_inventario`.
- Las profundidades no van en la tabla, porque son distintas para el molde (`obj_snap`) y para la pieza en la mano (`obj_pieza`). Siguen en su lugar.
- **Alternativa descartada:** un struct con nombre, sprite y profundidad. Es más de lo necesario para dos usos.

### 3. Macros de paso con el valor actual
Los nombres siguen el texto de la abuela en `obj_mensaje/Create_0`, por ejemplo `MOMIA_PASO_PIEL = 3` y `MOMIA_PASO_CRANEO = 11`.
- Se reemplazan solo las comparaciones y los `case` de pasos, no los índices de `texto[]` ni de `paso_accion[]`, que siguen siendo una lista numerada.
- Al no cambiar ningún valor, el juego compila igual.

### 4. Funciones extraídas en el contexto de `obj_controlador`
`scr_momia_organos_arrastrar()` y `scr_momia_paso_avanzar()` se llaman desde su Step y usan sus variables (`offset_x`, `snap`, `can_snap`, `posicionX`). Un comentario de una línea lo indica. El orden de llamada es el mismo del bloque original.

## Risks / Trade-offs

- [Que una macro tome un valor distinto del número que reemplaza] → Se revisa en el diff número por número, y la prueba de mouse y joystick recorre todos los pasos.
- [Que la tabla de piezas desordene un sprite] → Se toma tal cual del `switch` de `obj_inventario`, y el de `obj_controlador` se compara con un desfase de 1.
- [Que el linter no cubra los objetos] → Se corre también sobre las carpetas de los objetos tocados.
- [Sin pruebas automáticas de GML] → La prueba manual del usuario es el criterio de aceptación (`specs/momia/pipeline/spec.md`).

## Migration Plan

Un commit por punto en `refactor/momia-solid`. Para revertir un punto, se hace `git revert` de su commit. La segunda tanda se propone después de la prueba del usuario.
