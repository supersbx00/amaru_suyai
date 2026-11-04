# Design

## Context

F6 en `rm_momificar` mostró la caja de Khoru unos 33 px a la izquierda y 51 px arriba de lo esperado, justo el origen de `spr_khoru_1` (33,51). El círculo de Amaru, con centro en (36,61), también calza si se mide desde la esquina de su sprite.

## Goals / Non-Goals

**Goals:** que la colisión de `obj_khoru_camarones` cubra su dibujo.

**Non-Goals:** cambiar otros objetos, la colisión de Amaru, el aviso de interacción o el sprite.

## Decisions

- **Caja de (2,1) a (61,97), medida desde la esquina.** Es el recuadro que ocupan los 6 cuadros del sprite, y el usuario pidió cubrir todo el dibujo. La alternativa de solo mover la caja actual de 56×92 dejaba partes del dibujo sin cubrir.
- **Editar solo `physicsShapePoints`.** Corrige la causa sin agregar código.
- **No corregir los otros 36 objetos ahora.** Solo hay evidencia de Khoru y Amaru, y esos objetos se revisaron antes en el juego. Falta explicar esa diferencia con F6 y F3.

## Risks / Trade-offs

- [Desde arriba o las esquinas, Amaru puede quedar cerca o justo fuera de los 100 px del aviso] → El usuario lo prueba por todos los lados; si falla, se ajusta en este cambio.
- [Khoru aparece mientras Amaru está en el mismo lugar] → Su caja es más grande que antes y puede empujarla; se revisa en la prueba.
- [GameMaker abierto durante el cambio] → Se recarga el proyecto sin guardar.
