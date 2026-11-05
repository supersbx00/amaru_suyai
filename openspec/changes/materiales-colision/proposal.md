# Proposal

## Why

Al recoger un material colocado en el mapa (ej. humedal), `obj_materiales` se oculta e intenta apagar su física con `phy_active = false` dentro del evento de colisión, donde GameMaker no lo aplica. Queda un cuerpo invisible que Amaru empuja y que lo frena.

## What Changes

- `obj_materiales.yy`: `physicsSensor` de `false` a `true`. El evento de colisión con Amaru sigue disparándose (se recoge igual), pero el material nunca frena ni se empuja, antes o después de recogerlo.

Sin cambios en guardado (`global.materiales_recogidos`) ni en la reaparición al cargar.

## Capabilities

### New Capabilities

Ninguna.

### Modified Capabilities

Ninguna: corrección de un bug, sin requisitos nuevos (`skip_specs: true`).

## Impact

Una línea de `objects/obj_materiales/obj_materiales.yy` (05_Inventario_Creacion). Rama `fix/bugs-auditoria`.
