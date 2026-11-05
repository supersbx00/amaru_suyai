# Tasks

No se crean recursos nuevos de GameMaker ni se tocan los `.yy`. Los scripts y objetos conservan su ruta y su grupo.

## 1. Referencia y reglas

- [x] 1.1 Prueba de referencia de `rm_Momia` con mouse y joystick, y de la pestaña Momificar de Creación. El usuario la repitió el 2026-11-05 y todo funciona bien.
- [x] 1.2 Agregar ramas `refactor/` en `.claude/rules/git.md`; verificar con `git diff`.

## 2. Primera tanda

- [x] 2.1 Agregar a `scr_momia_control` las macros de las posiciones del cráneo y el esternón y la función `scr_momia_craneo_cerrado()`, y usarlas en `obj_controlador/Step_0`, `obj_mensaje/Step_0` y `obj_cuerpo/Draw_0`; verificar con búsqueda que no quede `622`, `123`, `607` ni `253` en esos archivos.
- [x] 2.2 Agregar a `scr_momia_control` las macros `MOMIA_PASO_*` y reemplazar las comparaciones de pasos con `global.numero` y `can_snap` en `obj_mensaje`, `obj_controlador`, `obj_inventario`, `obj_cuerpo`, `obj_craneo` y `obj_esternon`; verificar en el diff que cada macro vale lo mismo que el número que reemplaza.
- [x] 2.3 Agregar `scr_momia_piezas()` a `scr_momia_materiales` y usarla en vez de los `switch` de sprites de `obj_controlador/Step_0` y `obj_inventario/Step_0`, dejando las profundidades donde están; verificar en el diff que cada sprite corresponde a su pieza.
- [x] 2.4 Extraer de `obj_controlador/Step_0` las funciones `scr_momia_organos_arrastrar()` y `scr_momia_paso_avanzar()` a `scr_momia_control`, en el mismo orden; verificar en el diff que el código movido es idéntico, salvo la indentación.
- [x] 2.5 Borrar los 4 `show_debug_message` de `obj_inventario/Step_0`, `global.inventario` de `obj_controlador/Create_0` y `global.iventario` de `obj_controlador/Step_0`; verificar con búsqueda que no queden en el proyecto.
- [x] 2.6 Ejecutar `python3 tools/gml_linter.py scripts/` y el linter sobre `objects/obj_controlador`, `objects/obj_mensaje`, `objects/obj_inventario` y `objects/obj_cuerpo`; verificar que no haya errores nuevos.

## 3. Validación

- [x] 3.1 El usuario repite en GameMaker la prueba de la tarea 1.1, según `specs/momia/pipeline/spec.md`; verificar que confirme que todo funciona igual.
- [x] 3.2 Revisar con `git status` y `git diff` que solo cambiaron los archivos de `proposal.md`, y ejecutar `openspec validate momia-feature-cascade --strict`.

## 4. Segunda tanda

- [x] 4.1 Mover `Collision_obj_desp` de los 5 órganos a su padre `obj_organo` (archivo `.gml` y `eventList` de los 6 `.yy`); verificar que los 5 `.gml` eran idénticos y que ningún hijo conserva el evento.
- [x] 4.2 Pasar el input de `objects/obj_cuerpo/Draw_0.gml` (líneas 1-22) a un evento Step nuevo, con `if (!layer_get_visible(layer)) exit;` para que no cuente clics en pausa, y registrarlo en `obj_cuerpo.yy`; verificar en el diff que el código movido es idéntico.
- [x] 4.3 Ejecutar el linter sobre `scripts/` y los objetos tocados; verificar que no haya errores nuevos.
- [x] 4.4 El usuario prueba en el IDE: los 5 órganos desaparecen en el agujero; la piel se retira igual con clic y con A, y un clic sobre el cuerpo con la pausa abierta no la cambia.

## Workflow follow-up

- Un commit por punto, solo con autorización: Conventional Commits en español, sin coautor, con `git add -f openspec/changes/momia-feature-cascade`.
- Aparte: `fix` del límite `* 16` en `obj_inventario/Step_0:33`, si el usuario lo confirma.
