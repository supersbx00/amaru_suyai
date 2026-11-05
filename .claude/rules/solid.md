# Principios SOLID adaptados a GML

**Precedencia:** la sección 4 de `gamemaker.md` gana. Si un principio pide una capa, un mapper o una abstracción que GML no trae, no se aplica. SOLID es una guía para escribir y revisar, no una razón para agregar código. Estudio y casos reales en `docs/solid-gamemaker.md`.

## S · Una responsabilidad
Cada script, función o evento hace una sola cosa. En el Step, cada paso de la cascada es una llamada.
```gml
// Step de obj_player_battle
scr_batalla_escudo();
scr_movimiento(1);
```

## O · Abierto a extender, cerrado a modificar
Un enemigo, patrón o batalla nueva se agrega con un objeto hijo, una variable o una fila, sin editar condiciones que ya existen.
```gml
// Create del hijo, en vez de: if (object_index != obj_enemigo && ...)
usa_patrones = false;
```

## L · Sustitución
Un hijo debe servir en cualquier lugar donde sirve su padre. Llama a `event_inherited()` y conserva las variables que usan los eventos del padre y las colisiones contra él.
```gml
// Create de obj_khoru_battle
event_inherited();   // trae barHealth, que lee Collision_obj_enemigo
barHealth = 300;
```

## I · Contratos pequeños
Un padre define solo lo que usan todos sus hijos. Lo que usa un solo tipo va en el Create de ese hijo.
```gml
// Create de obj_enemigo: solo lo común
barHealth = 100;
objetivo = noone;
```

## D · Depender de lo estable
Usar nombres de recurso, no índices numéricos. Pasar los datos como argumento, no como una global que se fija antes de la llamada.
```gml
scr_go_to_room(rm_costa_humedal);   // no scr_go_to_room(12)
scr_ataque_enemy(tipo, angulo);     // no global.proyectil_2 = 1 antes
```
