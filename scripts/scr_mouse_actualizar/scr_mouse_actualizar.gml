// Frames que se ignoran los clics tras aceptar uno o tras cambiar de pantalla (30 fps -> 0,2 s)
#macro MOUSE_ENFRIAMIENTO 6

function scr_mouse_actualizar() {
// Se ejecuta una vez por frame (Begin Step de obj_game), antes que cualquier Step.
// global.mouse_click / global.mouse_atras quedan en 1 solo el frame en que se acepta el clic;
// quien lo usa debe ponerlos en 0 para que nadie más lo consuma.
var izq = mouse_check_button_pressed(mb_left);
var der = mouse_check_button_pressed(mb_right);

global.mouse_movido = (mouse_x != global.mouse_x_prev || mouse_y != global.mouse_y_prev);
global.mouse_x_prev = mouse_x;
global.mouse_y_prev = mouse_y;
global.mouse_click = 0;
global.mouse_atras = 0;

if (global.mouse_enfriamiento > 0)
{
    global.mouse_enfriamiento -= 1;
    exit;
}

// Ambos botones a la vez: se ignoran
if (izq && der)
    exit;

if (izq || der)
{
    global.mouse_click = izq;
    global.mouse_atras = der;
    global.mouse_enfriamiento = MOUSE_ENFRIAMIENTO;
}
}
