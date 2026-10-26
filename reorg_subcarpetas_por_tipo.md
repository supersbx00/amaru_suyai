# Reorganización: subcarpetas por tipo dentro de cada comunidad

Complemento a `propuesta.md`. Esto documenta cómo se separaron objetos/scripts/rooms/sonidos/etc. dentro de cada carpeta de comunidad, en vez de dejarlos todos mezclados.

## Por qué

Las Fases 1-5 agruparon los 292 recursos por comunidad funcional (`01_Batalla`, `02_Nucleo_Partida`, etc.), pero dentro de cada una quedaban objetos, scripts, rooms, sonidos, etc. todos mezclados en la misma carpeta. GameMaker ya separa recursos por tipo en su estructura por defecto (`Objects`, `Scripts`, `Rooms`...) por una razón práctica: son paneles/editores distintos y es más fácil navegar cuando el tipo es predecible. Se pidió mantener esa separación por tipo, pero *dentro* de cada carpeta de comunidad.

## Cómo se hizo

Mismo mecanismo que toda la migración: el campo `"parent"` de cada `.yy` + las entradas `"Folders"` del `.yyp`. GameMaker ya tenía un precedente de anidar una carpeta de un tipo dentro de otra carpeta (`Scripts/Compatibility`, `Sprites/Tilesets`), así que se replicó ese mismo patrón: una subcarpeta con el nombre del tipo (`Objects`, `Scripts`, `Rooms`, `Sounds`, `Paths`, `Fonts`) anidada bajo cada carpeta de comunidad.

Regla aplicada: **solo se creó la subdivisión en las comunidades que mezclan más de un tipo de recurso.** Si una carpeta tiene un solo tipo, no hace falta subdividir (no hay nada que separar):

- `00_Core` → solo objetos (6) → queda plana, sin subcarpetas.
- `10_Compatibilidad_GMS1` → solo scripts (13) → queda plana.
- El resto (10 carpetas) mezclaba 2 a 4 tipos → se subdividieron.

## Estructura resultante

```
00_Core/                        (solo objetos, sin subcarpetas)
01_Batalla/
  Objects/   (29)
  Scripts/   (15)
  Sounds/    (4)
  Paths/     (3)
02_Nucleo_Partida/
  Scripts/   (37)
  Objects/   (9)
  Rooms/     (2)
  Fonts/     (2)
03_Mundo_Rooms/
  Objects/
  Rooms/
04_Minijuego_Momia/
  Objects/
  Rooms/
  Scripts/
05_Textos_Carteles/
  Fonts/
  Objects/
  Scripts/
06_Tutorial_Dialogos/
  Objects/
  Scripts/
07_NPCs_Puntaje/
  Objects/
  Scripts/
08_Jugador_CambioZona/
  Objects/
  Scripts/
09_Pausa_Ayudas_Popups/
  Objects/
  Scripts/
  Sounds/
10_Compatibilidad_GMS1/         (solo scripts, sin subcarpetas)
99_Sin_Uso_Revisar/
  Objects/
  Scripts/
```

27 subcarpetas nuevas en total, 240 recursos repunteados.

## Qué se corrigió en el camino

Al revisar el `.yyp` apareció una entrada huérfana — una carpeta `02_Nucleo_Partida` anidada por error dentro de `Scripts` (`folders/Scripts/02_Nucleo_Partida.yy`), sin ningún recurso apuntándole — quedó de un paso anterior de la migración. Se eliminó esa línea porque no tenía ninguna referencia (0 recursos la usaban), antes de insertar las 27 subcarpetas nuevas.

## Verificación

- 240/240 recursos con su `parent` apuntando exactamente a la ruta esperada.
- 27/27 subcarpetas presentes en `Folders` del `.yyp`.
- 0 referencias a la carpeta huérfana eliminada.

Sin cambios de código ni lógica — solo metadata de carpeta, igual que las Fases 1-5.
