# Design

## Context

- Cada `.yy` guarda su grupo en un único bloque `parent`. Se comprobó que los 287 recursos del mapeo tienen exactamente uno.
- El `.yyp` tiene 62 entradas `GMFolder`, una por línea, y no es JSON estricto. GameMaker y `gm_project_check` esperan orden IDE.
- `juego_reconstruido.resource_order` solo guarda hoy el orden de `grupo1`.
- `obj_player/Other_0` usa índices numéricos de room, así que el orden de rooms no puede cambiar.
- Fuera del mapeo quedan 340 sprites, 18 tilesets, 3 sonidos y 1 shader, que ya están en grupos vigentes.

## Goals / Non-Goals

**Goals:**
- Aplicar el mapeo de una sola vez, con un script repetible y revisable antes de escribir.

**Non-Goals:**
- Reagrupar sprites, cambiar el orden de rooms o borrar recursos sin uso: `99_Sin_Uso_Revisar` y las tablas "Revisar" solo marcan dudas.
- Refactorizar a pipeline Feature Cascade: queda para etapas por módulo.
- Corregir el linter: corresponde a `corregir-infra-sprites-y-git`.

## Decisions

### 1. Mapeo en `grupos.json`
Un único archivo relaciona cada `.yy` con su grupo. Los mapas `.md` son solo para leerlo. Asignar un grupo no compromete nada: los 14 objetos y 5 scripts por revisar se pueden mover después desde GameMaker.
- **Alternativa descartada:** un grupo por tipo dentro de cada feature, porque el usuario pidió no apilar por tipo.

### 2. Script único con ensayo previo
`aplicar_grupos.py`, dentro de este cambio, muestra por defecto lo que haría y solo escribe con `--aplicar`. Antes de escribir comprueba que cada `.yy` tenga un solo `parent` y que todo grupo destino exista en el resultado. Se escribe por texto para conservar el formato y los saltos de línea.
- **Alternativa descartada:** `gms-mcp` está configurado de solo lectura y `normalize_order` reescribiría muchas líneas.
- **Alternativa descartada:** mover 287 recursos a mano en el IDE es lento y propenso a errores.

### 3. Retiro seguro de grupos antiguos
Se retira una entrada de `Folders` solo si, tras el mapeo, ningún `.yy` del proyecto la usa como `parent` y no tiene subgrupos. Las entradas nuevas se insertan en orden IDE. `gm_project_check` confirma el orden.

### 4. Destino de sonidos, paths y fuentes
Los recursos propios de una feature van a esa feature, sin mezclar responsabilidades: `03_Batalla/Sonidos`, `03_Batalla/Rutas` y `09_UI/Sonidos`. Las 3 fuentes, usadas por varias features, van al grupo nativo `Fonts`.

### 5. `grupo1` se conserva
Lo creó el usuario y su cambio sigue sin commit. El script no lo toca y `resource_order` queda igual. Su retiro, si se quiere, se hace desde GameMaker.

### 6. Reglas alineadas con lo aplicado
`gamemaker.md` deja de pedir `scripts/<dominio>/` y `rooms/<categoría>/`. `openspec/config.yaml` deja de pedir `<Comunidad>/<Tipo>` y de citar `propuesta.md` y `reorg_subcarpetas_por_tipo.md`, que ya no rige.

### 7. Rooms en el grupo nativo `Rooms`
Una room mezcla recursos de varias features, así que ninguna es su dueña. Tras probar la agrupación por feature, el usuario decidió dejarlas juntas en `Rooms`; objetos y scripts siguen por feature.
- **Alternativa descartada:** `07_Mundo/Zonas/<Zona>` y `Escena` por feature, porque forzaban un dueño y repartían 17 rooms en 9 grupos.

## Risks / Trade-offs

- [GameMaker abierto sobrescribe los cambios] → El usuario lo cierra antes de aplicar y lo abre después.
- [Un `.yy` queda dañado o hay que revertir 287 archivos] → Se parte de un commit autorizado. Revertir es volver a ese commit.
- [Conflictos de merge con otras ramas] → Los `.yy` y el `.yyp` cambian en muchos puntos, así que conviene fusionar pronto y no reagrupar en paralelo.
- [`gm_project_check` no compila] → El criterio final es la prueba del usuario en GameMaker.
- [Búsqueda por texto: una clasificación puede ser imperfecta] → Solo afecta dónde se ve el recurso, no cómo funciona.
