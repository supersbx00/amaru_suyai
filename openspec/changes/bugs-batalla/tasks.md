# Tasks

## 1. Batalla

- [x] 1.1 `scr_batalla_sprites`: `spr_b_carga = spr_amaru_battle_carga` en Amaru. Prueba: recargar con Amaru muestra el aura roja; con Suyai, la cura.
- [x] 1.2 `obj_player_battle/Create_0`: carta de anulación antes de `ds_list_copy` y `anulacion_usos = 0`. Prueba: la carta está en la mano al empezar cualquier batalla, incluido el tutorial.
- [x] 1.3 `scr_batalla_ia`: contar usos de la anulación y quitarla de `aux_playerDeck` al tercero. Prueba: vuelve en las dos primeras recargas; tras el tercer uso ya no.
- [x] 1.4 `scr_batalla_enemigos_crear`: acompañantes como `obj_tojotojone`. Prueba: se ven como tojotojón en todas sus animaciones; ganar y perder siguen funcionando.

## 2. Cierre

- [x] 2.1 Linter `python3 tools/gml_linter.py scripts/` y diff revisado.
- [x] 2.2 El usuario prueba en el IDE los pasos de `docs/prompt-bugs-batalla.md`.
