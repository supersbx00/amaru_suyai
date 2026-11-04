# Design

## Context

Khoru y Amaru mostraron con F6 que los puntos se miden desde la esquina del sprite. En las cajas, sumar el origen del sprite conserva el tamaño y deja cada forma sobre su dibujo.

## Goals / Non-Goals

**Goals:** corregir la posición de las formas, partiendo por batalla.

**Non-Goals:** cambiar su tamaño, ajustar daño o dificultad, o tocar `obj_player`, que ya está medido desde la esquina.

## Decisions

- **Cajas primero.** Su cálculo es seguro: cada punto suma el origen del sprite asignado al objeto.
- **Círculos después de una captura con F3.** En Amaru, el radio visto fue cerca de 32, mientras que la distancia entre sus dos puntos es 4. Eso sugiere que el radio sale del `x` del segundo punto, pero es un solo dato. La alternativa de convertirlos en cajas cambiaría su forma sin necesidad.
- **Mapa en una segunda etapa.** Cambia por dónde se puede pasar, así que se prueba aparte.

## Risks / Trade-offs

- [Cajas y círculos quedan alineados de forma distinta hasta terminar la etapa 1] → Los choques entre ellos pueden verse raros en esa prueba; se resuelve con la captura y la tarea 2.2.
- [La batalla cambia de dificultad, porque se ajustó con las colisiones corridas] → El usuario lo evalúa; si hace falta, se ajusta en otro cambio.
- [`obj_cuchilla` sigue más alta que su dibujo, con caja de 69 px sobre un sprite de 29 px] → Se mantiene el tamaño, como pidió el usuario.
- [GameMaker abierto durante el cambio] → Se recarga el proyecto sin guardar.
