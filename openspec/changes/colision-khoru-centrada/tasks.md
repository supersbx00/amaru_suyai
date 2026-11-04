# Tasks

No se crean recursos nuevos.

## 1. Colisión

- [x] 1.1 Cambiar `physicsShapePoints` de `obj_khoru_camarones` a (2,1), (61,1), (61,97) y (2,97); verificar con `git diff` que solo cambian esos 4 puntos y que la caja cubre el recuadro de los 6 cuadros de `spr_khoru_1`.
- [x] 1.2 Ejecutar `gm_project_check` y `openspec validate colision-khoru-centrada --strict`; verificar que no haya problemas.

## 2. Validación

- [x] 2.1 El usuario prueba en `rm_momificar` con F6 que la caja cubre a Khoru, y choca y le habla desde los cuatro lados; verificar que confirme los escenarios de `specs/world/physics-shape-alignment/spec.md`.

## Workflow follow-up

- De paso, el usuario presiona F6 cerca de la anciana y F3 en una batalla, para decidir si hace falta otro cambio.
- Con autorización explícita: hacer el commit en español, sin coautor, y archivar después de la prueba.
