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

// Botón redondo de menú en la esquina superior izquierda de la pantalla (capa GUI: sigue a la cámara).
// Un clic izquierdo sobre él abre el menú de pausa, igual que Enter.
#macro BOTON_MENU_X 52
#macro BOTON_MENU_Y 52
#macro BOTON_MENU_RADIO 30

// Visible cuando Amaru puede actuar en el mapa: sin pausa, batalla, diálogo, ayuda, cinemática ni transición
function scr_boton_menu_visible() {
if (global.pause || !instance_exists(obj_player) || !instance_exists(obj_pause))
    return 0;

if (room == rm_battle || room == rm_battle_tutorial)
    return 0;

if (global.texto_abierto || instance_exists(obj_popup_ayuda) || instance_exists(obj_popUp))
    return 0;

// Tutorial: no aparece hasta que Wanku pide abrir el menú (paso 9), y solo en los pasos en que
// scr_pause_control deja abrirlo (pasos 9 y 15): así nunca se ve un botón que no responde
if (instance_exists(obj_control_tutorial) && obj_control_tutorial.tutorialOn)
{
    var paso = obj_control_tutorial.paso;
    
    if (paso < 9 || (paso >= 10 && paso <= 14) || paso >= 16)
        return 0;
}

return obj_player.enable_player == 0 && obj_player.enable_battle == 0;
}

function scr_boton_menu_sobre() {
return point_distance(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), BOTON_MENU_X, BOTON_MENU_Y) <= BOTON_MENU_RADIO;
}

// Begin Step de obj_game, después de scr_texto_actualizar: el clic sobre el botón es del menú, no de Amaru
function scr_boton_menu_actualizar() {
if (global.mouse_click && scr_boton_menu_visible() && scr_boton_menu_sobre())
{
    global.mouse_click = 0;
    
    with (obj_pause)
        scr_pause_control();
}
}

// Draw GUI de obj_game. En el paso 9 del tutorial (ir al menú) late para llamar la atención.
function scr_boton_menu_dibujar() {
if (!scr_boton_menu_visible())
    exit;

var escala = scr_boton_menu_sobre() ? 1.1 : 1;

if (instance_exists(obj_control_tutorial) && obj_control_tutorial.paso == 9)
    escala += 0.12 * (1 + sin(current_time / 120));

draw_sprite_ext(spr_boton_menu, 0, BOTON_MENU_X, BOTON_MENU_Y, escala, escala, 0, c_white, 1);
}
