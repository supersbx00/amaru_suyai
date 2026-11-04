# Tasks

No se crean objetos, scripts ni rooms. Los recursos existentes reciben el `parent` indicado en `grupos.json`.

## 1. Preparación

- [ ] 1.1 Pedir autorización para un commit de partida con el estado actual y pedir al usuario que cierre GameMaker; verificar con `git status` que el árbol quedó limpio.
- [x] 1.2 Crear `aplicar_grupos.py` en este cambio, con ensayo por defecto, `--aplicar` y comprobaciones sobre `parent`, grupos destino y orden; verificar con el ensayo que informa 287 recursos sin errores y lista los grupos a crear y retirar.

## 2. Aplicación

- [ ] 2.1 Ejecutar `aplicar_grupos.py --aplicar`; verificar que cada `.yy` del mapeo apunte a su grupo y que cada grupo destino exista en `Folders`.
- [ ] 2.2 Revisar el alcance: `git diff` cambia solo `parent` en 287 `.yy` y solo `Folders` en el `.yyp`, sin cambios en `.gml`, rutas de recursos ni `RoomOrderNodes`; `grupo1` y los grupos de sprites siguen presentes.
- [ ] 2.3 Ejecutar `gm_project_check` con el cliente del MCP y `python3 tools/gml_linter.py scripts/`; verificar que no haya errores nuevos y dejar constancia de que el linter aún no revisa recursos.

## 3. Reglas y cambios relacionados

- [ ] 3.1 Reescribir las secciones 2 y 3 de `.claude/rules/gamemaker.md` y actualizar `openspec/config.yaml`, con rutas por defecto más grupos `<Feature>/<Responsabilidad>`; verificar con búsqueda que no queden referencias a `<Comunidad>/<Tipo>`, `propuesta.md` ni `reorg_subcarpetas_por_tipo.md`.
- [ ] 3.2 Actualizar `momia-feature-cascade` para quitar el movimiento físico y `scripts/momia/`, conservando `MomiaEntrada`, el pipeline de `obj_controlador` y las ramas `refactor/`; verificar con `openspec validate momia-feature-cascade --strict`.

## 4. Validación final

- [ ] 4.1 PUNTO DE CONTROL: el usuario abre el proyecto en GameMaker, revisa el árbol, ejecuta el juego, guarda y cierra; verificar que confirme que no hay recursos faltantes y que `git diff` conserve los grupos. Si falla, volver al commit de partida con su autorización.
- [ ] 4.2 Ejecutar `openspec validate reorganizar-grupos-por-feature --strict` y mostrar al usuario `git status`.

## Workflow follow-up

- Con autorización explícita: hacer un commit en español con Conventional Commits, sin coautor, usando `git add -f openspec/changes/reorganizar-grupos-por-feature`.
- Después, proponer los sprites en un cambio aparte y seguir con la cascada de momia.
