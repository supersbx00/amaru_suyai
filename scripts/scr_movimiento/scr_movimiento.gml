// Movimiento en batalla: W/A/S/D, flechas o stick izquierdo, con diagonales a la misma rapidez.
// Acelera hasta la rapidez pedida en ~5 cuadros y frena en ~4 (no arranca ni para en seco).
// El stick es analógico: con zona muerta, inclinarlo poco mueve más lento.
// factor: 0,5 mientras se lanza una carta (Amaru sigue moviéndose, más lento).
#macro BATALLA_RAPIDEZ 6
#macro BATALLA_ACEL 1.2
#macro BATALLA_FRENO 1.5
#macro BATALLA_STICK_ZONA 0.25

function scr_movimiento(factor = 1) {
lkey = keyboard_check(ord("A")) || keyboard_check(vk_left);
rkey = keyboard_check(ord("D")) || keyboard_check(vk_right);
ukey = keyboard_check(ord("W")) || keyboard_check(vk_up);
dkey = keyboard_check(ord("S")) || keyboard_check(vk_down);

var eje_x = rkey - lkey;
var eje_y = dkey - ukey;

if (eje_x != 0 || eje_y != 0)
{
    // Teclado: siempre a fondo, diagonal normalizada
    var largo = point_distance(0, 0, eje_x, eje_y);
    eje_x /= largo;
    eje_y /= largo;
}
else
{
    // Stick: el largo fuera de la zona muerta se reescala de 0 a 1
    var sx = gamepad_axis_value(0, gp_axislh);
    var sy = gamepad_axis_value(0, gp_axislv);
    var m = point_distance(0, 0, sx, sy);
    
    if (m > BATALLA_STICK_ZONA)
    {
        var k = min(1, (m - BATALLA_STICK_ZONA) / (1 - BATALLA_STICK_ZONA)) / m;
        eje_x = sx * k;
        eje_y = sy * k;
    }
}

var meta_x = eje_x * BATALLA_RAPIDEZ * factor;
var meta_y = eje_y * BATALLA_RAPIDEZ * factor;

// Acercar la velocidad a la meta: acelera más suave de lo que frena
var paso = (point_distance(0, 0, meta_x, meta_y) >= point_distance(0, 0, hspd, vspd)) ? BATALLA_ACEL : BATALLA_FRENO;
var dx = meta_x - hspd;
var dy = meta_y - vspd;
var d = point_distance(0, 0, dx, dy);

if (d <= paso)
{
    hspd = meta_x;
    vspd = meta_y;
}
else
{
    hspd += (dx / d) * paso;
    vspd += (dy / d) * paso;
}

// Animación de correr mientras se mueve (sin cortar la de lanzar)
if ((eje_x != 0 || eje_y != 0) && sprite_index != spr_b_atk)
{
    if (ancestral == 1)
        sprite_index = spr_amaru_ancestral_run;
    else
        sprite_index = spr_b_run;

    image_xscale = 1;
    image_speed = 0.4;
}
}
