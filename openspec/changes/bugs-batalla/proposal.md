# Proposal

## Why

Prompt aprobado en `docs/prompt-bugs-batalla.md`: la recarga de Amaru usa el brillo en vez de su sprite de recarga, la carta de anulación ya no aparece en la mano y los acompañantes no se ven como el tojotojón, que es el enemigo genérico.

## What Changes

- `scr_batalla_sprites`: Amaru recarga con `spr_amaru_battle_carga`. Suyai sigue con la cura. `spr_amaru_battle_brillo` queda en el proyecto sin uso.
- `obj_player_battle/Create`: vuelve la carta de anulación (`spr_cardsNull`, 99, `"anulacion"`) a la mano inicial, también en el tutorial. Convive con el escudo de Wanku. Revierte en parte el BREAKING de `batalla-dinamica`.
- `scr_batalla_ia`: cada uso de la anulación suma a `anulacion_usos`; al tercero se quita de `aux_playerDeck` y la recarga ya no la devuelve.
- `scr_batalla_enemigos_crear`: los acompañantes (2.º y 3.º) son `obj_tojotojone`, con su aspecto y su ataque "paralizar".

## Capabilities

### New Capabilities

Ninguna.

### Modified Capabilities

Ninguna en delta (`skip_specs: true`): se corrige el comportamiento pedido por el usuario; la spec `player/battle-shield` no cambia porque el escudo se mantiene.

## Impact

`scripts/scr_batalla_equipo`, `scripts/scr_batalla_ia`, `scripts/scr_batalla_enemigos`, `objects/obj_player_battle/Create_0.gml` (03_Batalla). Sin `.yy` ni sprites. Rama `fix/bugs-auditoria`.
