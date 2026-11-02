// Botones del joystick con el arte de madera (spr_boton_a/b/x/y/view, tools/gen_botones_joystick.py).
// Los cuadros _xbox traen pintado un botón plano: con scr_boton_joy_sobre se dibuja el nuevo encima, tapándolo.
#macro BOTON_JOY_DISCO 58  // diámetro del disco de los botones nuevos (px, a escala 1)

// Botones pintados en cada sprite _xbox: [sprite del botón nuevo, dx, dy, diámetro del viejo], relativo al origen
function scr_boton_joy_tabla(spr) {
switch (spr)
{
    case spr_cuadro_dialogo_xbox: return [[spr_boton_a, 194.5, 92.5, 39]];
    case spr_confirmar_xbox: return [[spr_boton_a, -151, 169, 96], [spr_boton_y, 148.5, 167.5, 93]];
    case spr_siguiente_xbox: return [[spr_boton_a, 80, 2.5, 28]];
    case spr_popUp_atacar_xbox: return [[spr_boton_a, -45.5, -31.5, 73]];
    case spr_botton_x_xbox: return [[spr_boton_x, -0.5, -0.5, 45]];
}

return [];
}

// Dibuja los botones nuevos sobre el sprite _xbox `spr` dibujado en (px, py) a `escala`; si no está en la tabla, nada
function scr_boton_joy_sobre(spr, px, py, escala = 1) {
var tabla = scr_boton_joy_tabla(spr);

for (var i = 0; i < array_length(tabla); i++)
{
    var b = tabla[i];
    var e = escala * (b[3] + 4) / BOTON_JOY_DISCO;
    draw_sprite_ext(b[0], 0, px + (b[1] * escala), py + (b[2] * escala), e, e, 0, c_white, 1);
}
}

// Ícono de continuar: el clic animado, o la A con joystick
function scr_boton_continuar(px, py, escala = 1) {
if (gamepad_is_connected(0))
    draw_sprite_ext(spr_boton_a, 0, px, py, escala, escala, 0, c_white, 1);
else
    draw_sprite_ext(spr_boton_clic, floor(current_time / 133) mod sprite_get_number(spr_boton_clic), px, py, escala, escala, 0, c_white, 1);
}
