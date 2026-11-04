# Proposal

## Why

Los grupos actuales de GameMaker mezclan recursos por tipo y por comunidades antiguas, así que cuesta encontrar qué pertenece a cada mecánica. Mover carpetas físicas ya se descartó, y GameMaker permite ordenar el proyecto con grupos virtuales sin tocar rutas ni código.

## What Changes

- Mover 151 objetos, 108 scripts y 17 rooms a grupos virtuales por feature y responsabilidad, sin subcarpetas `Scripts`/`Objects`/`Rooms`. El mapeo completo está en `grupos.json`, y se puede revisar en `mapa_objetos_y_rooms.md` y `mapa_scripts.md`.
- Mover también 11 recursos que dependen de grupos que se retiran: 4 sonidos a `03_Batalla/Sonidos`, 1 sonido a `09_UI/Sonidos`, 3 paths a `03_Batalla/Rutas` y 3 fuentes al grupo `Fonts`.
- Retirar del `.yyp` y de `juego_reconstruido.resource_order` los grupos antiguos que queden vacíos. `grupo1`, creado por el usuario, y los grupos de sprites se conservan.
- Actualizar las secciones 2 y 3 de `.claude/rules/gamemaker.md` y `openspec/config.yaml`: rutas por defecto de GameMaker más grupos `<Feature>/<Responsabilidad>`.
- Actualizar `momia-feature-cascade` para quitar el movimiento físico y conservar el constructor y el pipeline.

No cambian los archivos físicos, las rutas de recursos del `.yyp`, el código GML ni el orden de rooms. Los sprites quedan para un cambio posterior.

## Capabilities

### New Capabilities
- `project-structure`: dónde viven los recursos del juego y cómo se agrupan en GameMaker.

### Modified Capabilities
<!-- Ninguna: el comportamiento de las capacidades del juego no cambia. -->

## Impact

- **Archivos:** 287 `.yy` (solo `parent`), `juego_reconstruido.yyp` (solo `Folders`), `juego_reconstruido.resource_order` si cambia un grupo con orden propio, `.claude/rules/gamemaker.md`, `openspec/config.yaml` y los artefactos de `momia-feature-cascade`.
- **Grupos destino:** `00_Core`, `01_Partida`, `02_Jugador`, `03_Batalla`, `04_Enemigos`, `05_Inventario_Creacion`, `06_Momia`, `07_Mundo`, `08_NPCs_Dialogos`, `09_UI` y `99_Sin_Uso_Revisar`, con sus subgrupos en `grupos.json`.
- **Recursos nuevos de GameMaker:** ninguno; solo se crean grupos.
- **Hubs:** `obj_game`, `obj_morral` y `obj_sound_control` quedan en `00_Core/Hubs`. `obj_player` pasa a `02_Jugador/Controlador`, `obj_control_tutorial` a `08_NPCs_Dialogos/Tutorial` y `obj_pause` a `09_UI/Pausa`. Su código no cambia.
- **Escalabilidad:** una room o mecánica nueva entra en el grupo de su feature, sin duplicar lógica de los hubs ni agregar carpetas por tipo. Esta etapa solo ordena; la cascada dentro del código se hará módulo por módulo, empezando por momia.
