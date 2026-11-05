# Proposal

## Why

Al volver a una sala persistente, GameMaker rehace los cuerpos físicos y rechaza un círculo con `image_xscale = -1` ("Image scale for physics object using circle collision should not vary across axes: obj_moon"). El juego se cae. `scr_room_transition` ya normaliza a Amaru y los enemigos; faltan los objetos volteados en el código de creación de su sala.

## What Changes

- `scr_room_transition`: antes de `room_goto`, `image_xscale = 1` también para `obj_moon` y `obj_npc_31` (rm_costa_humedal), `obj_npc_2` (rm_anzota_2), `obj_agua` (rm_anzota_3) y `obj_npc_3` (rm_capilla).
- Consecuencia aceptada por el usuario (opción A): al volver a la sala esos personajes miran a la derecha.

## Capabilities

### New Capabilities

Ninguna.

### Modified Capabilities

Ninguna: corrección de un crash (`skip_specs: true`).

## Impact

Solo `scripts/scr_room_transition` (01_Partida). Rama `fix/bugs-auditoria`.
