# Proposal

## Why

Momia es la primera feature de la auditoría SOLID (`.claude/rules/solid.md`) y sirve de piloto para el formato del informe y del refactor. La auditoría del 2026-11-05 encontró datos copiados en varios archivos (posiciones del cráneo, sprites de las piezas), números de paso sin nombre en 6 archivos, un `Step` con tres trabajos y restos de depuración. Hoy, cambiar un paso o una pieza obliga a editar varios lugares, y si se olvida uno el minijuego se traba.

## What Changes

Primera tanda, aprobada por el usuario. Es un refactor sin cambio de comportamiento:

1. **Cráneo cerrado (D):** una función `scr_momia_craneo_cerrado()` y macros para las posiciones finales del cráneo y el esternón. Reemplaza las 3 copias en `obj_controlador`, `obj_mensaje` y `obj_cuerpo`.
2. **Pasos con nombre (D, O):** macros `MOMIA_PASO_*` para los números de paso que se comparan con `global.numero` y `can_snap`. Los valores no cambian.
3. **Tabla de piezas (O):** `scr_momia_piezas()` junto a `scr_momia_costos`, con el sprite de cada pieza. La usan `obj_controlador` y `obj_inventario` en vez de sus dos `switch`. Las profundidades se quedan donde están.
4. **Step en cascada (S):** se extraen de `obj_controlador/Step_0` las funciones `scr_momia_organos_arrastrar()` y `scr_momia_paso_avanzar()`, con el código idéntico y en el mismo orden.
5. **Limpieza:** se borran 4 `show_debug_message` de `obj_inventario` y las globales sin uso `global.inventario` y `global.iventario`.
6. **Ramas `refactor/`:** se agregan en `.claude/rules/git.md`. El trabajo se hace en `refactor/momia-solid`.

**Se descarta:** el constructor `MomiaEntrada` del plan anterior. Las globales del joystick ya están protegidas por `scr_momia_presiona` y `scr_momia_mantiene`, así que un constructor solo agregaría una capa (regla 4).

**Segunda tanda, aprobada después de la prueba de la primera:** la colisión con `obj_desp` en `obj_organo` y el input de `obj_cuerpo` del Draw al Step. Ambas tocan los `.yy`; el Step de `obj_cuerpo` se salta cuando su capa está oculta (pausa), igual que hoy el Draw.

**Fuera de alcance:** el posible bug del límite `* 16` en `obj_inventario/Step_0:33` (cambia comportamiento, va en un `fix` aparte) y la recompensa de `obj_mensaje/Other_10` (pertenece a `05_Inventario_Creacion`).

## Capabilities

### New Capabilities
- `momia/pipeline`: el minijuego de momia se refactoriza según la cascada y SOLID sin cambiar su comportamiento.

### Modified Capabilities
<!-- Ninguna: las specs de momia siguen vigentes sin cambios, porque el comportamiento se conserva. -->

## Impact

- **Scripts:** `scr_momia_control` (macros de paso, cráneo cerrado y las 2 funciones extraídas) y `scr_momia_materiales` (tabla de piezas).
- **Objetos:** solo sus `.gml`: `obj_controlador` (Create y Step), `obj_mensaje` (Step, Draw), `obj_inventario` (Step, Draw), `obj_cuerpo` (Draw), y `obj_craneo` y `obj_esternon` (Step, solo el número de paso). No se tocan los `.yy`.
- **Reglas:** `.claude/rules/git.md`.
- **Recursos nuevos de GameMaker:** ninguno; las funciones van en scripts existentes, que conservan su ruta y su grupo.
- **Escala:** con la tabla de piezas y los pasos con nombre, agregar un paso o una pieza toca menos archivos, y el informe sirve de molde para las demás features.
