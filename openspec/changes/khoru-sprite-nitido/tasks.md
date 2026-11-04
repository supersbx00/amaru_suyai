# Tasks

No se crean objetos, scripts ni rooms. `spr_khoru_1` conserva su grupo actual.

## 1. Arte en revisión

- [x] 1.1 Guardar los 6 PNG actuales en `originales/` y crear `khoru_nitido.py` en este cambio, con vista previa por defecto y `--aplicar`; verificar con `assert` que genera 6 cuadros de 66×102 y que dos corridas dan archivos idénticos.
- [x] 1.2 Mostrar al usuario la comparación de los 6 cuadros y la animación; verificar que los apruebe antes de seguir.

## 2. Aplicación

- [x] 2.1 Con GameMaker cerrado, ejecutar `khoru_nitido.py --aplicar` para actualizar los PNG, las capas y el `.yy`; verificar que el `.yy` indique 66×102 y origen (33,51), que conserve los identificadores de los 6 cuadros y que `git diff` no toque otros sprites.
- [x] 2.2 Cambiar la escala a 1 en `objects/obj_khoru_tutorial/Create_0.gml`, `objects/obj_khoru_tutorial/Draw_0.gml` (±1), `objects/obj_khoru_camarones/Create_0.gml` y la instancia de `rooms/rm_tutorial_test/rm_tutorial_test.yy`; verificar con búsqueda que no queden `0.89` ni escala `0.85` de Khoru y que `RoomOrderNodes` no cambie.
- [x] 2.3 Ejecutar `gm_project_check` y `python3 tools/gml_linter.py` sobre `scripts/`, `objects/obj_khoru_tutorial` y `objects/obj_khoru_camarones`; verificar que no haya problemas nuevos.

## 3. Validación

- [x] 3.1 El usuario prueba en GameMaker el tutorial (con los giros de los pasos 28 y 30), el desafío de los camarones (aviso, choque e interacción) y `rm_final_morro`; verificar que confirme los escenarios de `specs/world/khoru-map-sprite/spec.md`.
- [x] 3.2 Ejecutar `openspec validate khoru-sprite-nitido --strict` y revisar con `git status` y `git diff` que solo cambiaron los archivos de `proposal.md`; mostrar el resultado al usuario.

## Workflow follow-up

- Con autorización explícita: crear `feature/khoru-sprite` y hacer un commit en español con Conventional Commits, sin coautor.
- Archivar el cambio después de la prueba del usuario.
