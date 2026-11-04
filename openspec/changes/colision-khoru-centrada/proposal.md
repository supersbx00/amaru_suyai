# Proposal

## Why

En el desafío de `rm_momificar`, la colisión de Khoru queda arriba y a la izquierda de su dibujo, como muestra F6. Sus puntos se escribieron medidos desde el origen del sprite, pero la captura muestra que en este objeto se miden desde la esquina superior izquierda.

## What Changes

- Los puntos de `obj_khoru_camarones` pasan a una caja de (2,1) a (61,97), medida desde la esquina, que cubre todo el dibujo de `spr_khoru_1`.
- La especificación deja de afirmar que las formas se miden desde el origen del sprite.
- Otros 36 objetos escritos de la misma forma no se tocan: no hay evidencia de que estén mal y antes se revisaron con F6 y F3.

## Capabilities

### New Capabilities

Ninguna.

### Modified Capabilities

- `world/physics-shape-alignment`: el centrado se comprueba en el juego y la colisión de Khoru en el desafío cubre su dibujo.

## Impact

- **Objeto:** `objects/obj_khoru_camarones/obj_khoru_camarones.yy`, solo `physicsShapePoints`. No hay cambios en `.gml`, `.yyp` ni recursos nuevos.
- **Juego:** Amaru choca con Khoru donde se ve. Hablarle desde arriba queda cerca del límite de 100 px del aviso.
- **Escalabilidad:** si F6 y F3 muestran el mismo error en otros objetos, se corrigen en un cambio aparte.
