# Prompt: bugs de batalla (recarga, anulación y acompañante)

Rama: `fix/bugs-auditoria`, en un commit aparte.

## Contexto

Revisé el código de los tres pedidos antes de escribir este prompt.

1. **Sprite de recarga.** Al recargar, `scr_recuperarCartas` pone `sprite_index = spr_b_carga`. Para Amaru, `scr_batalla_sprites` asigna `spr_b_carga = spr_amaru_battle_brillo` (los ojos celestes). Ese cambio entró el 2026-11-04 en `67a300e`, a pedido tuyo. El proyecto ya tiene `spr_amaru_battle_carga` (el aura roja, 4 cuadros), pero ningún código lo usa. Suyai no tiene sprite de recarga y usa el de cura.
2. **Carta de anulación.** No aparece porque se quitó a propósito el 2026-11-04 en el cambio `batalla-dinamica`: el escudo de Wanku (`scr_batalla_escudo`) la reemplazó. El efecto sigue en el código: `scr_batalla_ia` revisa `spr_cardsNull` y aturde al rival. Lo único que falta es agregarla a la mano en `obj_player_battle/Create`.
   - **Cómo vuelve hoy una carta:** las cartas usadas se borran de `playerDeck`. Al recargar, la mano se repone desde `aux_playerDeck`, que es la mano inicial. La cura usa ese mismo mecanismo para no volver (`cura_usada`).
3. **Segundo enemigo.** `scr_batalla_enemigos_crear` crea a los acompañantes como `obj_enemigo`, que tiene sprites propios (`spr_enemigo_battle_*`). `obj_tojotojone` es hijo de `obj_enemigo` y tiene todos sus sprites (`spr_tojone_*`).

## Tarea

1. Que la recarga de Amaru use `spr_amaru_battle_carga`.
2. Que la carta de anulación vuelva a la mano en cada batalla y desaparezca tras usarla 3 veces en esa batalla.
3. Que los acompañantes se vean como el tojotojón.

## Cambios propuestos (mínimos)

| # | Archivo | Cambio |
|---|---|---|
| 1 | `scr_batalla_equipo` (`scr_batalla_sprites`) | En Amaru, `spr_b_carga = spr_amaru_battle_carga`. Suyai sigue usando la cura. |
| 2a | `obj_player_battle/Create_0` | Volver a agregar la carta (`spr_cardsNull`, valor 99, tipo `"anulacion"`) antes de `ds_list_copy(aux_playerDeck, playerDeck)`, igual que antes de `45d4b6a`. Agregar `anulacion_usos = 0`. |
| 2b | `obj_player_battle/Step_0` (uso de carta) | Al usar una carta `"anulacion"`, sumar 1 a `anulacion_usos`. En el tercer uso, borrarla también de `aux_playerDeck` para que la recarga no la devuelva. |
| 3 | `scr_batalla_enemigos_crear` | Crear los acompañantes como `obj_tojotojone` y no como `obj_enemigo`. |

## Restricciones

- El escudo de Wanku se queda: la anulación convive con él.
- La anulación sigue sin poder usarse en combos (`Step_0:62` ya la excluye).
- No se tocan sprites ni `.yy`.
- El cambio es mínimo, sin refactor.

## Preguntas abiertas (con mi recomendación)

1. **¿`spr_amaru_battle_brillo` queda sin uso?** Recomiendo dejarlo en el proyecto, sin borrarlo, por si lo quieres usar en otra animación.
2. **¿La anulación también va en la batalla del tutorial?** Recomiendo que sí: el tutorial ya tiene sus popups (`spr_popUp_nullCard`) y antes la traía.
3. **¿El acompañante tiene que pelear como tojotojón o solo verse como él?** Recomiendo que pelee como él, con `obj_tojotojone`, porque es una sola línea. Pero eso trae su ataque "paralizar": a veces lanza la carta null, que paraliza a Amaru. Si solo quieres el aspecto, hay que reemplazar los ~15 sprites de `obj_enemigo` por los del tojotojón solo en los acompañantes. Es más código.
4. **¿El tercer enemigo, que aparece desde el primer espíritu, también es tojotojón?** Recomiendo que sí: el mismo cambio cubre a los dos acompañantes.

## Verificación

**Claude:**
- `python3 tools/gml_linter.py scripts/`.
- Revisar el diff archivo por archivo.
- Revisar con grep que nada dependa de que el acompañante sea `obj_enemigo` exacto (`object_index == obj_enemigo`).

**Tú, en el IDE:**
1. En una batalla con Amaru, gasta cartas y recarga: tiene que verse el aura roja y no el brillo de los ojos.
2. Haz lo mismo con Suyai: tiene que seguir usando la animación de cura.
3. La carta de anulación tiene que estar en la mano al empezar. Úsala: el enemigo del turno queda aturdido.
4. Recarga: la anulación vuelve. Úsala por tercera vez y recarga: ya no vuelve.
5. En una batalla nueva, la anulación tiene que estar otra vez en la mano.
6. Los acompañantes se ven como tojotojón en todas sus animaciones: quieto, correr, ataque, daño y muerte.
7. Ganar y perder siguen funcionando: el conteo de enemigos y el premio.
8. La batalla del tutorial sigue siendo 1 contra 1 y se puede terminar.
