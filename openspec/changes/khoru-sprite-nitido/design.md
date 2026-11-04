# Design

## Context

`spr_khoru_1` tiene 6 cuadros de 74×120 con origen (37,60), y sale de un JPG de 241×429 recortado a mano (ver `archive/2026-10-29-khoru-batalla-nuevo-diseno/`). Amaru y Suyai salen de PNG limpios con el doble de reducción. Por eso este cambio mejora la nitidez, pero no iguala su calidad.

El sprite lo usan tres objetos:
- `obj_khoru_tutorial`: escala 0.89×0.85 en `Create` y ±0.89 en `Draw`. La instancia de `rm_tutorial_test` también tiene 0.89×0.85.
- `obj_khoru_camarones`: `escala_x` y `escala_y` de 0.89×0.85 en `draw_sprite_ext`.
- `obj_khoru`: escala 1 en `rm_final_morro`.

## Goals / Non-Goals

**Goals:** eliminar el reescalado en el juego, limpiar la silueta y agregar contorno.

**Non-Goals:** rehacer el dibujo, igualar la calidad de Amaru y Suyai, o tocar los sprites de batalla.

## Decisions

- **Reducir una sola vez a 66×102.** Es 74×0.89 y 120×0.85, redondeados, así que Khoru ocupa el mismo lugar en el tutorial y el desafío. Se reduce con LANCZOS y alfa premultiplicado para no ensuciar los bordes. La alternativa de mantener 74×120 y solo agregar contorno conservaba el desenfoque del juego.
- **Partir de copias de los originales.** Los 6 PNG actuales se guardan en `originales/` dentro de este cambio. Así, repetir el script da el mismo resultado en vez de reducir otra vez un sprite ya reducido.
- **Silueta:** alfa menor a 60 pasa a 0 y alfa de 110 o más pasa a 255. Después se conserva solo la zona conectada más grande, para quitar los píxeles sueltos junto a la capa.
- **Contorno:** los píxeles del borde con brillo mayor a 70 se oscurecen hacia marrón (62,24,16). El pelo y la capa ya son oscuros y no cambian.
- **Sin aplanar colores.** Se probó una paleta de 40 colores: perdía los ojos rojos y ensuciaba la falda.
- **Sin paleta ni `sprite_processor.py`.** `palette_reference.png` no existe y el arreglo del procesador sigue pendiente en `corregir-infra-sprites-y-git`. Se documenta como excepción para este sprite.
- **Escala 1 en los objetos actuales.** En `obj_khoru_camarones` se conservan `escala_x` y `escala_y` con valor 1, porque es el cambio mínimo.
- **`rm_final_morro` sin mover la instancia.** Khoru se reduce alrededor de su centro, así que su colisión no cambia. Los pies quedan unos 8 px más arriba que hoy.

## Risks / Trade-offs

- [Khoru sigue notándose distinto a Amaru y Suyai] → Si llega un dibujo mejor, se reemplaza el sprite con un cambio nuevo.
- [Máscara más chica en `obj_khoru_camarones`, que hoy es la del sprite completo] → El usuario prueba `Collision_obj_player` y la interacción en la tarea 3.1.
- [Pies más arriba en `rm_final_morro`] → El usuario lo revisa en la tarea 3.1; si se nota, se ajusta `y` en un cambio aparte, moviendo también la colisión.
- [GameMaker abierto durante la aplicación] → El usuario lo cierra antes de la tarea 2.1.
