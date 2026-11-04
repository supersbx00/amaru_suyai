# Proposal

## Why

La prueba de `colision-khoru-centrada` confirmó en el juego que `physicsShapePoints` se mide desde la esquina superior izquierda del sprite. Muchos objetos tienen sus puntos escritos desde el origen, por lo que sus colisiones pueden quedar corridas, sobre todo en batalla.

## What Changes

- **Etapa 1, batalla:** se corrigen las cajas de `obj_player_battle`, `obj_aliado_battle`, `obj_enemigo`, `obj_enemigo_agua`, `obj_tojotojone`, `obj_evil_whanku`, `obj_cuchilla` y `obj_flecha`, sumando el origen de su sprite a cada punto.
- **Etapa 1, círculos:** `obj_enemigo_fuego`, `obj_enemigo_luna`, `obj_enemigo_normal`, `obj_enemigo_normal1`, `obj_khoru_battle`, `obj_proyectil`, `obj_proyectil_ice` y `obj_proyectil_ligth` se corrigen después de confirmar con F3 cómo se calcula el radio.
- **Etapa 2, mapa:** NPC, `obj_khoru`, `obj_agua`, `obj_fuego`, `obj_moon` y los objetos restantes, después de probar la batalla.
- Se mantiene el tamaño de las formas, como pidió el usuario.

## Capabilities

### New Capabilities

Ninguna.

### Modified Capabilities

- `world/battle-hitboxes`: las colisiones de batalla se comprueban en el juego y dejan de definirse como medidas desde el origen.

## Impact

- **Objetos:** solo `physicsShapePoints` en los `.yy` indicados. No hay cambios en `.gml`, `.yyp` ni recursos nuevos.
- **Juego:** cambia dónde pegan los ataques, por lo que la dificultad de la batalla puede variar.
- **Escalabilidad:** los objetos nuevos deben escribir sus puntos desde la esquina del sprite.
