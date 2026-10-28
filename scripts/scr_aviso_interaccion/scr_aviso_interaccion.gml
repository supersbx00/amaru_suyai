// Aviso sobre la cabeza del jugador cuando puede interactuar con algo cercano (lo llama el Draw de cada interactuable).
// Sin gamepad es el ícono animado de clic; con gamepad, el botón A. Clic sobre el aviso = Z (ver scr_amaru_clic).
#macro AVISO_ALTO 104  // px sobre el jugador
#macro AVISO_RADIO 32  // radio del clic sobre el aviso

function scr_aviso_interaccion() {
if (!instance_exists(obj_player))
    exit;

if (gamepad_is_connected(0))
    draw_sprite(spr_boton_a, 0, obj_player.x, obj_player.y - AVISO_ALTO);
else
    draw_sprite(spr_boton_clic, (global.frame_actual * 0.25) mod sprite_get_number(spr_boton_clic), obj_player.x, obj_player.y - AVISO_ALTO);

global.aviso_frame = global.frame_actual;
}

// ¿Se vio el aviso en el último frame dibujado?
function scr_aviso_visible() {
return global.aviso_frame >= global.frame_actual - 1;
}

// ¿El aviso está visible y el mouse está sobre él?
function scr_aviso_bajo_mouse() {
return scr_aviso_visible()
    && point_distance(mouse_x, mouse_y, obj_player.x, obj_player.y - AVISO_ALTO) <= AVISO_RADIO;
}
