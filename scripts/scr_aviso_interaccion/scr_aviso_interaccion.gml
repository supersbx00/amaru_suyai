// Aviso encima del objeto con el que se puede interactuar (lo llama el Draw de cada interactuable).
// Sin gamepad es el ícono animado de clic; con gamepad, el botón A. Clic sobre el aviso = Z (ver scr_amaru_clic).
#macro AVISO_ALTO 104   // px sobre el jugador, si el objeto no tiene sprite
#macro AVISO_MARGEN 36  // px entre el borde de arriba del objeto y el centro del aviso
#macro AVISO_RADIO 32   // radio del clic sobre el aviso (y medio alto del ícono)

// alto: px entre `y` y el centro del aviso, para objetos que se dibujan a otra escala que su máscara; -1 = usar bbox_top
function scr_aviso_interaccion(alto = -1) {
if (!instance_exists(obj_player))
    exit;

var ax = x;
var ay;

if (alto >= 0)
    ay = y - alto;
else if (sprite_index != -1)
    ay = bbox_top - AVISO_MARGEN;
else
{
    ax = obj_player.x;
    ay = obj_player.y - AVISO_ALTO;
}

// Entero dentro de la vista
ay = max(ay, __view_get(1, 0) + AVISO_RADIO + 4);

if (gamepad_is_connected(0))
    draw_sprite(spr_boton_a, 0, ax, ay);
else
    draw_sprite(spr_boton_clic, (global.frame_actual * 0.25) mod sprite_get_number(spr_boton_clic), ax, ay);

global.aviso_x = ax;
global.aviso_y = ay;
global.aviso_frame = global.frame_actual;
}

// ¿Se vio el aviso en el último frame dibujado?
function scr_aviso_visible() {
return global.aviso_frame >= global.frame_actual - 1;
}

// ¿El aviso está visible y el mouse está sobre él?
function scr_aviso_bajo_mouse() {
return scr_aviso_visible()
    && point_distance(mouse_x, mouse_y, global.aviso_x, global.aviso_y) <= AVISO_RADIO;
}
