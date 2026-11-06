# Proposal

## Why

Prompt aprobado en `docs/prompt-bugs-batalla-2.md`: Suyai cae muy lento y queda a mitad de caída, los enemigos caídos no desaparecen y el tojotojón deja su colisión, Suyai recarga sin aura y la carta null no se nota con dos enemigos vivos.

## What Changes

- Caída de Amaru o Suyai: `image_speed = image_number / 15` (0,5 s para todos) y el último cuadro con `image_number - 1`.
- `obj_battleController/Step`: todo enemigo con vida 0 apaga su física y se desvanece (~1 s), sin destruirse.
- Sprite nuevo `spr_suyai_battle_carga` (grupo de sprites `Suyai`, 88×104, origen 44,52), generado con `tools/gen_suyai_carga.py`: cuadros de cura con aura azul que copia el perfil del aura de Amaru. Sin paleta. Se usa como `spr_b_carga` de Suyai.
- `scr_batalla_ia`: la carta null aturde a todos los enemigos vivos.

## Capabilities

### New Capabilities

Ninguna.

### Modified Capabilities

Ninguna en delta (`skip_specs: true`).

## Impact

`obj_aliado_battle`, `obj_battleController`, `obj_player_battle`, `scr_batalla_equipo`, `scr_batalla_ia` (03_Batalla); sprite nuevo y su entrada en el `.yyp`; `tools/gen_suyai_carga.py`. Rama `fix/bugs-auditoria`.
