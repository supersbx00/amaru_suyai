// Espera antes de poder avanzar una ventana de ayuda y su ícono de "clic para continuar".
// Usan variables de la instancia de la ayuda: ayuda_espera (frames que faltan), ayuda_total y ayuda_anim.
#macro AYUDA_ESPERA_SEG 3     // segundos por página
#macro AYUDA_ICONO_RADIO 34   // radio del clic sobre el ícono

// Empieza la espera de una página nueva (Create y cada cambio de página)
function scr_ayuda_espera_reiniciar() {
ayuda_total = AYUDA_ESPERA_SEG * game_get_speed(gamespeed_fps);
ayuda_espera = ayuda_total;
ayuda_anim = 0;
}

// Llamar una vez por Step: descuenta la espera y devuelve 1 si el jugador avanza la página
// (clic sobre el ícono en ix, iy o Back del gamepad), solo cuando la espera terminó.
function scr_ayuda_puede_avanzar(ix, iy) {
if (ayuda_espera > 0)
{
    ayuda_espera -= 1;
    return 0;
}

ayuda_anim += 1;

if (gamepad_button_check_pressed(0, gp_select))
    return 1;

return mouse_check_button_pressed(mb_left) && point_distance(mouse_x, mouse_y, ix, iy) <= AYUDA_ICONO_RADIO;
}

// Dibuja el ícono: apagado con un anillo que se llena durante la espera; encendido, animado y con pulso al terminar
function scr_ayuda_dibujar_icono(ix, iy) {
if (ayuda_espera > 0)
{
    draw_sprite_ext(spr_boton_clic, 0, ix, iy, 1, 1, 0, c_gray, 0.6);
    
    // Anillo de progreso (sentido horario desde arriba)
    var progreso = 1 - (ayuda_espera / ayuda_total);
    var pasos = max(1, ceil(40 * progreso));
    var r_in = 33;
    var r_out = 37;
    
    draw_set_colour(make_colour_rgb(245, 166, 35));
    draw_set_alpha(1);
    draw_primitive_begin(pr_trianglestrip);
    
    for (var i = 0; i <= pasos; i++)
    {
        var ang = 90 - (360 * progreso * i / pasos);
        draw_vertex(ix + lengthdir_x(r_in, ang), iy + lengthdir_y(r_in, ang));
        draw_vertex(ix + lengthdir_x(r_out, ang), iy + lengthdir_y(r_out, ang));
    }
    
    draw_primitive_end();
    draw_set_colour(c_white);
}
else
{
    var escala = 1 + (0.04 * (1 + sin(ayuda_anim * 0.2)));
    draw_sprite_ext(spr_boton_clic, (ayuda_anim * 0.25) mod sprite_get_number(spr_boton_clic), ix, iy, escala, escala, 0, c_white, 1);
}
}

// Posición del ícono para una ayuda que dibuja spr en (px, py): esquina inferior derecha de la tabla de texto
function scr_ayuda_icono_x(spr, px) {
if (!sprite_exists(spr))
    return px; // la ayuda aún no elige su sprite (primer frame)

return px - sprite_get_xoffset(spr) + sprite_get_width(spr) - 72;
}

function scr_ayuda_icono_y(spr, py) {
if (!sprite_exists(spr))
    return py;

return py - sprite_get_yoffset(spr) + sprite_get_height(spr) - 52;
}
