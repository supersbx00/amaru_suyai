# Tasks

No se crean recursos nuevos.

## 1. Cajas de batalla

- [x] 1.1 Sumar el origen del sprite a los puntos de `obj_player_battle`, `obj_aliado_battle`, `obj_enemigo`, `obj_enemigo_agua`, `obj_tojotojone`, `obj_evil_whanku`, `obj_cuchilla` y `obj_flecha`; verificar con `git diff` que solo cambian esos puntos y que cada caja conserva su tamaño.
- [x] 1.2 Ejecutar `gm_project_check` y `openspec validate colisiones-desde-esquina --strict`; verificar que no haya problemas.

## 2. Círculos de batalla

- [ ] 2.1 Confirmar con una captura de F3 del usuario cómo se calcula el radio de los círculos; verificar que coincida con al menos un enemigo normal.
- [ ] 2.2 Corregir `obj_enemigo_fuego`, `obj_enemigo_luna`, `obj_enemigo_normal`, `obj_enemigo_normal1`, `obj_khoru_battle`, `obj_proyectil`, `obj_proyectil_ice` y `obj_proyectil_ligth`; verificar con `git diff` y `gm_project_check`.
- [ ] 2.3 El usuario prueba con F3 una batalla completa, con arpón, balas enemigas, escudo y Suyai; verificar que confirme los escenarios de `specs/world/battle-hitboxes/spec.md`.

## 3. Mapa

- [ ] 3.1 Después de aprobar la batalla, corregir los NPC, `obj_khoru`, `obj_agua`, `obj_fuego`, `obj_moon` y los objetos restantes; verificar con `git diff` y `gm_project_check`.
- [ ] 3.2 El usuario prueba con F6 las salas del mapa; verificar que las formas calcen y que los pasos sigan abiertos.

## Workflow follow-up

- Con autorización explícita: hacer los commits en español, sin coautor, y archivar al terminar.
