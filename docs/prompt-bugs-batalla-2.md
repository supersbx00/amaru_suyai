# Prompt: bugs de batalla, segunda tanda

Rama: `fix/bugs-auditoria`, en un commit aparte. Antes de empezar se hace el commit de la primera tanda (`bugs-batalla`).

## Contexto

Revisé el código de los cuatro pedidos.

1. **Suyai cae muy lento.** Su derrota (`spr_suyai_battle_defeat`) tiene 33 cuadros y la de Amaru tiene 6. Las dos se reproducen a `image_speed = 0.4`, así que la de Suyai dura unos 2,7 s y la de Amaru 0,5 s. Además, `obj_player_battle/Other_7:32` deja quieto el cuadro 5, que es el último de Amaru: con Suyai queda congelada a mitad de la caída.
2. **El enemigo caído no desaparece y su colisión sigue.** `obj_enemigo` apaga su física al morir, pero no se desvanece. `obj_tojotojone` (los acompañantes desde la primera tanda) ni siquiera apaga su física: por eso su colisión queda.
3. **Suyai recarga sin aura.** Hoy recarga con su sprite de cura, que no tiene brillo. Amaru recarga con un aura roja (`spr_amaru_battle_carga`), que es rojo puro con un borde suave de unos 6 px.
4. **La carta null no hace nada con dos enemigos vivos.** `scr_batalla_ia` aturde solo al enemigo que tiene el turno (`scr_batalla_enemigo_duelo`). Con un solo enemigo, ese enemigo es siempre el que ataca y el efecto se nota. Con dos, el aturdido puede no ser el que ataca en ese momento, y el otro sigue atacando como si nada. Esta causa la deduje leyendo el código; no la confirmé en el IDE.

## Tarea

1. Que Suyai caiga en el mismo tiempo que Amaru y quede en su último cuadro.
2. Que todo enemigo que cae se desvanezca y no deje colisión.
3. Crear `spr_suyai_battle_carga` (los cuadros de cura de Suyai con un aura azul, igual a la de Amaru) y usarlo al recargar.
4. Que la carta null aturda a todos los enemigos vivos.

## Cambios propuestos (mínimos)

| # | Archivo | Cambio |
|---|---|---|
| 1a | `obj_aliado_battle/Step_0`, `scr_batalla_equipo` (caída automática), `obj_battleController/Step_0:118` | Cambiar `image_speed = 0.4` por `image_speed = image_number / 15` al poner `spr_b_defeat`. Así toda caída dura 0,5 s; en Amaru da 0,4, igual que hoy. |
| 1b | `obj_player_battle/Other_7:35` | Cambiar `image_index = 5` por `image_index = image_number - 1`. |
| 2 | `obj_battleController/Step_0` | Un solo bloque para todos los tipos de enemigo: `with (obj_enemigo) if (barHealth <= 0) { phy_active = 0; image_alpha = max(0, image_alpha - 0.03); }`. Se desvanecen en ~1 s. No se destruyen, porque los turnos y la victoria cuentan instancias. |
| 3a | Sprite nuevo `spr_suyai_battle_carga` | 4 cuadros de 88×104 con origen (44, 52), en el grupo de sprites `Suyai`. Se genera con un script de Pillow que aplica el perfil de alfa medido en el aura de Amaru (221, 168, 128, 77, 38, 14) en azul `(30, 110, 255)`. Va sin paleta, porque el aura de Amaru tampoco la usa. |
| 3b | `scr_batalla_sprites` | En Suyai, `spr_b_carga = spr_suyai_battle_carga`. La cura no cambia. |
| 4 | `scr_batalla_ia` (bloque de `spr_cardsNull`) | Cambiar el `rival` del turno por `with (obj_enemigo) if (barHealth > 0) { player_cardBreaked = 1; anulable = 0; }`. El conteo de 3 usos no cambia. |

## Vista previa del aura (para aprobar)

![Comparación](img/suyai_carga_preview.png)

- **Fila 1:** la recarga de Amaru que hay hoy.
- **Fila 2:** la cura de Suyai que hay hoy (sin aura).
- **Fila 3:** la recarga nueva de Suyai.

## Restricciones

- No se modifica ningún sprite existente.
- El único recurso nuevo es `spr_suyai_battle_carga`. Se crea con GameMaker cerrado.
- No se destruyen enemigos.
- El cambio es mínimo, sin refactor.

## Preguntas abiertas (con mi recomendación)

1. **¿Se desvanecen también los espíritus y Khoru, o solo los tojotojones?** Recomiendo todos: el bloque está en un solo lugar y la batalla termina igual.
2. **¿El aura azul es como la de la vista previa, o la quieres más clara, más oscura o más ancha?** Recomiendo dejarla así, con el mismo ancho y la misma suavidad que la de Amaru.
3. **¿El null aturde a todos los enemigos, o solo al que va a atacar?** Recomiendo a todos: es lo más simple y se nota siempre. La carta ya está limitada a 3 usos.

## Verificación

**Claude:**
- Linter, diff y revisión de que el `.yy` nuevo esté bien formado: los cuadros, el origen y el parent `Suyai`.
- Comprobar con grep que `spr_suyai_battle_carga` solo se use en `scr_batalla_sprites`.

**Tú, en el IDE:**
1. Haz que derroten a Suyai: tiene que caer tan rápido como Amaru y quedarse tendida en el último cuadro.
2. Vence a un tojotojón acompañante: tiene que desvanecerse y tienes que poder caminar por donde estaba.
3. Lo mismo con el enemigo principal y con un espíritu.
4. Recarga con Suyai: tiene que verse el aura azul.
5. Recarga con Amaru: sigue el aura roja.
6. Con dos enemigos vivos, usa la carta null: los dos tienen que quedar aturdidos.
7. La batalla tiene que terminar bien: victoria, derrota y premio.
