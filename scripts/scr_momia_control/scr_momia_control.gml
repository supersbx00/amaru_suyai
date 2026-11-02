// Control del minijuego de la momia con joystick: el stick izquierdo mueve el puntero de la ventana (así mouse_x/mouse_y,
// el cursor de piedra y todo el arrastre siguen igual). A toma (u empieza a untar) y B suelta (o deja de untar), sin
// tener que mantener nada apretado, para que sea fácil a cualquier edad. El mouse sigue funcionando a la vez, con clic mantenido.
#macro MOMIA_STICK_ZONA 0.2   // zona muerta del stick
#macro MOMIA_STICK_VEL 11     // px de pantalla por frame con el stick a fondo

// Lo llama obj_mouse cada frame en rm_Momia
function scr_momia_cursor() {
if (!gamepad_is_connected(0))
    exit;

var ex = gamepad_axis_value(0, gp_axislh);
var ey = gamepad_axis_value(0, gp_axislv);

if (abs(ex) < MOMIA_STICK_ZONA)
    ex = 0;

if (abs(ey) < MOMIA_STICK_ZONA)
    ey = 0;

if (ex == 0 && ey == 0)
    exit;

// Aceleración suave: más rápido mientras más se inclina; en px de la ventana, que puede estar escalada
var esc = window_get_width() / __view_get(2, 0);
var wx = window_mouse_get_x() + (sign(ex) * sqr(ex) * MOMIA_STICK_VEL * esc);
var wy = window_mouse_get_y() + (sign(ey) * sqr(ey) * MOMIA_STICK_VEL * esc);
window_mouse_set(clamp(wx, 0, window_get_width() - 1), clamp(wy, 0, window_get_height() - 1));
}

// Anota quién tomó lo último: A = joystick (queda tomado hasta B), clic = mouse (mientras esté apretado).
// La llaman scr_momia_presiona y scr_momia_mantiene: el frame en que se toma algo puede llamar solo a una de ellas
// (obj_controlador, al agarrar un órgano, solo llama a presiona). Solo lee pulsaciones de este frame: repetirla no cambia nada.
function scr_momia_estado() {
if (gamepad_button_check_pressed(0, gp_face1))
{
    global.momia_con_pad = 1;
    global.momia_soltado = 0;
}

if (mouse_check_button_pressed(mb_left))
    global.momia_con_pad = 0;

if (global.momia_con_pad && gamepad_button_check_pressed(0, gp_face2))
    global.momia_soltado = 1;
}

// Clic izquierdo o A recién apretado: tomar algo
function scr_momia_presiona() {
scr_momia_estado();
return mouse_check_button_pressed(mb_left) || gamepad_button_check_pressed(0, gp_face1);
}

// ¿Sigue tomado lo que se agarró? Con mouse, mientras el clic esté apretado. Con joystick, desde A hasta B
// (global.momia_con_pad: el último en tomar fue el joystick; global.momia_soltado: ya se apretó B).
function scr_momia_mantiene() {
scr_momia_estado();

if (global.momia_con_pad && gamepad_is_connected(0))
    return !global.momia_soltado;

return mouse_check_button(mb_left);
}

// Ícono que marca dónde actuar: botón A con joystick, clic animado sin él
function scr_momia_icono(px, py, escala = 1) {
if (gamepad_is_connected(0))
    draw_sprite_ext(spr_boton_a, 0, px, py, escala, escala, 0, c_white, 1);
else
    draw_sprite_ext(spr_boton_clic, floor(current_time / 133) mod sprite_get_number(spr_boton_clic), px, py, escala, escala, 0, c_white, 1);
}
