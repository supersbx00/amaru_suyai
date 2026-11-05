# SOLID en GameMaker: guía de estudio

SOLID son cinco principios para escribir código que se pueda cambiar sin romper otras partes. Nacieron en lenguajes con clases e interfaces, y GML no tiene interfaces. Por eso aquí se aplican con lo que GameMaker ya trae: objetos padre, `event_inherited()`, variables de instancia, funciones y structs.

**La regla de oro:** la sección 4 de `.claude/rules/gamemaker.md` manda. Si aplicar un principio obliga a crear un mapper, un DTO o una capa nueva, no se aplica. La versión corta que uso al escribir código está en `.claude/rules/solid.md`.

Los casos de abajo son código real del proyecto al 2026-11-05. Los bloques "Después" son **ilustrativos**: no están aplicados, y corregirlos es trabajo de la auditoría por feature.

---

## S · Principio de responsabilidad única

**Qué dice:** cada pieza de código tiene un solo motivo para cambiar.

**En GML:** cada script, función o evento hace una sola cosa. La cascada de la regla 4 ya es esto: entrada, movimiento, físicas secundarias y dibujo, cada uno en su paso.

**Caso del proyecto (bien hecho):** `scripts/scr_batalla_escudo/scr_batalla_escudo.gml` solo se ocupa del escudo, separado en funciones con un trabajo cada una:

- `scr_batalla_escudo()` (línea 9): lo activa y lo recarga, en el Step.
- `scr_batalla_escudo_bloquea(proy)` (línea 31): decide si detiene un proyectil.
- `scr_batalla_escudo_activo()` (línea 53): responde si está arriba.

El Step de `obj_player_battle` solo lo llama en una línea (`objects/obj_player_battle/Step_0.gml:32`). Si el escudo cambia, se toca un solo archivo.

**Señal de alarma:** un evento Step de cientos de líneas que lee el input, mueve, calcula daño y elige sprite a la vez.

---

## O · Principio abierto/cerrado

**Qué dice:** se puede agregar comportamiento nuevo sin modificar el código que ya funciona.

**En GML:** un enemigo, patrón o batalla nueva se agrega con un objeto hijo, una variable o una fila, sin editar condiciones que ya existen.

**Caso bien hecho:** `scr_batalla_enemigo_principal()` (`scripts/scr_batalla_enemigos/scr_batalla_enemigos.gml:7`) es una tabla con un `case` por batalla. El comentario de la línea 2 lo dice: "Una batalla nueva solo agrega su fila".

**Caso a mejorar:** `scr_enemigo_elegir_patron()` (misma ruta, línea 171) decide quién usa patrones comparando contra objetos concretos.

```gml
// Antes (línea 171)
if (object_index != obj_enemigo && object_index != obj_tojotojone)
    return "simple";
```

Un enemigo nuevo con ráfaga y abanico obliga a editar esta línea, que no es suya.

```gml
// Después (ilustrativo)
// Create de obj_enemigo:            usa_patrones = true;
// Create de cada espíritu y Khoru:  usa_patrones = false;  (después de event_inherited)
if (!usa_patrones)
    return "simple";
```

Cada enemigo declara lo suyo en su Create, y la función no vuelve a cambiar.

---

## L · Principio de sustitución de Liskov

**Qué dice:** un hijo debe poder usarse en cualquier lugar donde se usa su padre, sin sorpresas.

**En GML:** en GameMaker esto importa más de lo que parece, porque **una colisión contra un padre también alcanza a todos sus hijos**. Por eso cada hijo debe tener las variables que esos eventos leen.

**Caso del proyecto (bien hecho):**

- `obj_proyectil_ice` tiene una colisión contra `obj_enemigo` que hace `other.barHealth -= scr_danho(danho);` (`objects/obj_proyectil_ice/Collision_obj_enemigo.gml:3`).
- Esa colisión también le pega a `obj_tojotojone`, `obj_khoru_battle` y los tres espíritus, que heredan de `obj_enemigo`.
- Funciona porque el Create de cada uno llama a `event_inherited();`, que trae `barHealth = 100;` del padre (`objects/obj_enemigo/Create_0.gml:15`). Después, cada hijo puede ajustar el valor, como Khoru con `barHealth = 300;` (`objects/obj_khoru_battle/Create_0.gml:2`).

**Señal de alarma:** un hijo con Create propio que no llama a `event_inherited()`. Se pierden las variables del padre, y la primera colisión contra él tira el error "variable no definida".

---

## I · Principio de segregación de interfaces

**Qué dice:** nadie debe depender de cosas que no usa.

**En GML:** no hay interfaces, así que el "contrato" es lo que el padre define en su Create. Un padre debe definir solo lo que usan todos sus hijos. Lo de un solo tipo va en el Create de ese hijo.

**Caso a revisar:** `objects/obj_enemigo/Create_0.gml` define 55 líneas de variables para todos los enemigos. Las líneas 11 y 12 crean dos `ds_list` (`colaCartas` y `comboCard_array`), y la línea 1 crea una instancia de `obj_seguir`, para cada enemigo que nace. Si algún hijo no los usa, igual los carga y ocupa memoria. Cuáles los usan de verdad lo confirma la auditoría de `04_Enemigos`.

```gml
// Después (ilustrativo), si solo un tipo usa las cartas:
// Create de ese hijo, después de event_inherited()
colaCartas = ds_list_create();
comboCard_array = ds_list_create();
```

**Ojo:** mover variables de un padre a un hijo rompe el principio L si otro código las lee en cualquier enemigo. Antes de moverlas, hay que buscar todas sus referencias.

---

## D · Principio de inversión de dependencias

**Qué dice:** el código debe depender de cosas estables, no de detalles que cambian.

**En GML:** usar nombres de recurso en vez de números, y pasar los datos como argumento en vez de dejarlos en una global antes de llamar.

**Caso 1, índice numérico de sala:** `objects/obj_player/Other_0.gml:8` guarda `temp[2] = 12;` y en la línea 10 llama a `scr_go_to_room(temp[2]);`. Hoy el 12 es `rm_costa_humedal` en `RoomOrderNodes`. Si alguien reordena las salas, el jugador aparece en otra sin ningún error. Esta es la clase de bug que ya arreglamos varias veces en la decompilación.

```gml
// Después (ilustrativo)
temp[2] = rm_costa_humedal;
```

**Caso 2, global como argumento escondido:** antes de cada `scr_ataque_enemy(...)` se fija `global.proyectil_2 = 1;` (`scripts/scr_batalla_enemigos/scr_batalla_enemigos.gml:190`, `203`, `209` y `303`). La función la lee (`scripts/scr_ataque_enemy/scr_ataque_enemy.gml:6`) y la vuelve a 0 (línea 82). Quien lee una llamada no ve que depende de esa global, y si alguien olvida fijarla, el ataque se comporta distinto sin aviso.

```gml
// Después (ilustrativo)
scr_ataque_enemy(tipo, angulos[i], true);
```

---

## Cómo se usa en la auditoría

La auditoría revisa una feature a la vez, cada una en su propio cambio OpenSpec. Empieza por `06_Momia` junto a `momia-feature-cascade` y sigue de `00_Core` a `09_UI`. Primero se entrega un informe con una tabla de archivo, principio (S, O, L, I o D), problema, propuesta y riesgo. Solo los puntos que apruebes se corrigen, como refactor que no cambia el comportamiento del juego. Yo verifico con el linter y el diff, y tú pruebas en el IDE con los pasos que te deje. Cuando un caso de este documento se corrige, se actualiza aquí.
