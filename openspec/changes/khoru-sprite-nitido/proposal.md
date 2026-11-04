# Proposal

## Why

Khoru se ve borroso y con menos calidad que Amaru y Suyai en el mapa y el tutorial. Parte del problema es que `spr_khoru_1` se dibuja reducido a 0.89×0.85 con interpolación y no tiene contorno. El usuario aprobó esta mejora parcial mientras no exista un dibujo de mejor calidad.

## What Changes

- `spr_khoru_1` pasa de 74×120 a 66×102, el tamaño con que ya se ve en el tutorial, con la silueta limpia y contorno oscuro en piel y hueso. Conserva los 6 cuadros, la piel y los ojos rojos.
- Khoru se dibuja a escala 1 en `obj_khoru_tutorial`, `rm_tutorial_test` y `obj_khoru_camarones`, incluidos los giros de los pasos 28 y 30 del tutorial.
- En `rm_final_morro`, donde ya estaba a escala 1, Khoru queda del mismo tamaño que en las otras salas, por lo que se ve más chico que hoy.
- No se crean objetos, scripts ni rooms, y `spr_khoru_1` sigue en su grupo actual. No se tocan los sprites de batalla de Khoru.

## Capabilities

### New Capabilities

- `world/khoru-map-sprite`: cómo se ve Khoru fuera de la batalla (tamaño, nitidez y contorno).

### Modified Capabilities

Ninguna. `battle/khoru-sprite` solo cubre `spr_khoru_run`.

## Impact

- **Sprite:** `sprites/spr_khoru_1` (PNG y `.yy`).
- **Código:** `objects/obj_khoru_tutorial/Create_0.gml`, `objects/obj_khoru_tutorial/Draw_0.gml`, `objects/obj_khoru_camarones/Create_0.gml`.
- **Room:** escala de la instancia de Khoru en `rooms/rm_tutorial_test/rm_tutorial_test.yy`. El orden de rooms no cambia.
- **Colisiones:** las formas de física se conservan. La máscara de `obj_khoru_camarones` se reduce al tamaño dibujado.
- **Escalabilidad:** no agrega lógica a los hubs de `00_Core`; una sala nueva usa el sprite a escala 1 sin código extra.
