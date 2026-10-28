// Frames que se ignoran los clics tras aceptar uno o tras cambiar de pantalla (30 fps -> 0,2 s)
#macro MOUSE_ENFRIAMIENTO 6

function scr_mouse_actualizar() {
// Se ejecuta una vez por frame (Begin Step de obj_game), antes que cualquier Step.
// global.mouse_click / global.mouse_atras quedan en 1 solo el frame en que se acepta el clic;
// quien lo usa debe ponerlos en 0 para que nadie más lo consuma.
var izq = mouse_check_button_pressed(mb_left);
var der = mouse_check_button_pressed(mb_right);

var wx = window_mouse_get_x();
var wy = window_mouse_get_y();
global.mouse_movido = (wx != global.mouse_wx_prev || wy != global.mouse_wy_prev);
global.mouse_wx_prev = wx;
global.mouse_wy_prev = wy;

// Cursor de piedra: se oculta al usar teclado o gamepad y vuelve al usar el mouse (el mouse manda si pasan ambas cosas)
var usa_mouse = global.mouse_movido || mouse_check_button_pressed(mb_any);
var usa_otro = keyboard_check_pressed(vk_anykey);

if (!usa_otro && gamepad_is_connected(0))
{
    for (var b = gp_face1; b <= gp_padr; b++)
    {
        if (gamepad_button_check_pressed(0, b))
            usa_otro = true;
    }
    
    if (abs(gamepad_axis_value(0, gp_axislh)) > 0.5 || abs(gamepad_axis_value(0, gp_axislv)) > 0.5)
        usa_otro = true;
}

if (usa_mouse)
    cursor_sprite = spr_cursor1;
else if (usa_otro)
    cursor_sprite = -1;
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
