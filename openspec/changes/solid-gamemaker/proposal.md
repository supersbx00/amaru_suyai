# Proposal

## Why

El proyecto sale de una decompilación y acumula acoplamientos que ya costaron bugs, como los índices numéricos y las globales que hacen de bandera. No hay una guía que diga cómo debe escribirse el código nuevo, ni con qué criterio revisar el viejo. Esta guía es la base de la auditoría por feature que viene después.

## What Changes

- Nueva regla `.claude/rules/solid.md`: los 5 principios SOLID adaptados a GML, con una línea y un ejemplo de 5 líneas como máximo por principio. Queda subordinada a la regla 4 de `gamemaker.md` (sin mappers, DTOs ni abstracciones pesadas).
- Nuevo documento de estudio `docs/solid-gamemaker.md`: una sección por principio, con un caso real del proyecto antes y después.
- No cambia código `.gml` ni recursos `.yy`; los "después" del documento son ilustrativos y no se aplican.
- Fuera de alcance: la auditoría y el refactor por feature. Irán en cambios posteriores, empezando por `06_Momia` junto a `momia-feature-cascade`.

## Capabilities

### New Capabilities

Ninguna. Es documentación y no cambia el comportamiento del juego, así que el cambio declara `skip_specs: true`.

### Modified Capabilities

Ninguna. `repo-tracking` ya exige versionar `.claude/rules/`, y la regla nueva cae en esa carpeta.

## Impact

- Archivos nuevos: `.claude/rules/solid.md` y `docs/solid-gamemaker.md` (carpeta `docs/` nueva, versionada).
- Recursos de GameMaker: ninguno, así que no hay grupos `<Feature>/<Responsabilidad>` que asignar.
- Escala: los informes de auditoría por feature citarán estos principios por su letra, sin repetir la explicación.
