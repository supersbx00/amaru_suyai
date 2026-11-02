// Escudo de Amaru (o de Suyai, si es la controlada): reemplaza a la carta de anulación y nunca se gasta.
// Y en el joystick, Espacio o clic medio: protege ESCUDO_ACTIVO cuadros y después recarga ESCUDO_RECARGA cuadros.
// Un ataque que toca al personaje con el escudo activo desaparece sin daño y aturde 1 s a quien lo lanzó.
#macro ESCUDO_ACTIVO 22      // 0,75 s
#macro ESCUDO_RECARGA 120    // 4 s
#macro ESCUDO_ATURDE 30      // 1 s

// Step de obj_player_battle
function scr_batalla_escudo() {
if (escudo_activo > 0)
    escudo_activo -= 1;
else if (escudo_recarga > 0)
    escudo_recarga -= 1;

// En el tutorial, recién después de las ayudas de batalla
if (instance_exists(obj_control_tutorial) && obj_control_tutorial.paso < 25)
    exit;

if (barHealth <= 0 || escudo_activo > 0 || escudo_recarga > 0)
    exit;

if (gamepad_button_check_pressed(0, gp_face4) || keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_middle))
{
    escudo_activo = ESCUDO_ACTIVO;
    escudo_recarga = ESCUDO_RECARGA;
}
}

// ¿El escudo detiene este ataque? Se llama desde la colisión del proyectil (other = a quien tocó).
// Si lo detiene, aturde al enemigo que lo lanzó; el proyectil lo destruye quien llama.
function scr_batalla_escudo_bloquea(proy) {
var quien = other;

if (!instance_exists(quien) || quien.object_index != obj_player_battle || quien.escudo_activo <= 0)
    return 0;

if (instance_exists(proy.dueno))
{
    with (proy.dueno)
    {
        if (barHealth > 0)
        {
            player_cardBreaked = 1;
            escudo_aturdido = 1; // scr_enemigo_ataque_fases acorta el aturdimiento a ESCUDO_ATURDE
        }
    }
}

return 1;
}

// ¿El personaje controlado tiene el escudo arriba? (para no mostrar la animación de daño)
function scr_batalla_escudo_activo() {
return instance_exists(obj_player_battle) && obj_player_battle.escudo_activo > 0;
}

// Draw de obj_player_battle: Wanku aparece delante y se transforma rápido en escudo de piedra
// (spr_wanku_escudo: cuadros 14-24 en los primeros 6 cuadros, después 24-39) y se desvanece al final
#macro ESCUDO_TRANSFORMA 6

function scr_batalla_escudo_dibujar() {
if (escudo_activo <= 0)
    exit;

var t = ESCUDO_ACTIVO - escudo_activo;
var cuadro;

if (t < ESCUDO_TRANSFORMA)
    cuadro = 14 + floor(t * (10 / ESCUDO_TRANSFORMA));
else
    cuadro = min(39, 24 + floor((t - ESCUDO_TRANSFORMA) * (15 / max(1, ESCUDO_ACTIVO - ESCUDO_TRANSFORMA))));

var a = min(1, escudo_activo / 5);
draw_sprite_ext(spr_wanku_escudo, cuadro, x + 50, y + 20, 1, 1, 0, c_white, a);
}

// Draw de obj_battleController: barra de recarga bajo la vida del personaje controlado
function scr_batalla_escudo_barra(bx, by) {
if (!instance_exists(obj_player_battle))
    exit;

if (instance_exists(obj_control_tutorial) && obj_control_tutorial.paso < 25)
    exit;

var carga = 1;

with (obj_player_battle)
{
    if (escudo_activo > 0)
        carga = 0;
    else if (escudo_recarga > 0)
        carga = 1 - (escudo_recarga / ESCUDO_RECARGA);
}

var ancho = 150;
draw_set_color(c_black);
draw_rectangle(bx - 1, by - 1, bx + ancho + 1, by + 7, false);
draw_set_color((carga >= 1) ? make_color_rgb(150, 220, 255) : make_color_rgb(70, 110, 140));
draw_rectangle(bx, by, bx + (ancho * carga), by + 6, false);
draw_set_color(c_white);
}
