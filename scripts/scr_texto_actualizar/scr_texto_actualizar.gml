// Frames mínimos entre dos avances de texto (30 fps -> 0,4 s)
#macro TEXTO_ENFRIAMIENTO 12

function scr_texto_actualizar() {
// Se ejecuta una vez por frame (Begin Step de obj_game), después de scr_mouse_actualizar.
// global.texto_confirmar: confirmación para avanzar o cerrar textos (Z, gamepad o clic), con anti-spam.
// global.z_virtual: Z que genera Amaru al llegar a un NPC clicado; la ven todos los objetos este frame.
global.z_virtual = global.z_virtual_pendiente;
global.z_virtual_pendiente = 0;
global.frame_actual += 1;

if (global.texto_enfriamiento > 0)
    global.texto_enfriamiento -= 1;

global.texto_abierto = instance_exists(obj_dialogo) || instance_exists(obj_dialogo_premio) || instance_exists(obj_mensaje)
    || instance_exists(obj_texto_anzota) || instance_exists(obj_texto_camarones) || instance_exists(obj_texto_capilla)
    || instance_exists(obj_texto_choza) || instance_exists(obj_texto_junquillo) || instance_exists(obj_texto_morro)
    || instance_exists(obj_texto_oasis) || instance_exists(obj_texto_pictogramas) || instance_exists(obj_texto_rocas);

var clic = 0;

if (global.mouse_click && global.texto_abierto)
{
    // En la momia el mouse arrastra órganos: solo cuenta el clic sobre el cuadro del mensaje
    if (room == rm_Momia)
    {
        if (instance_exists(obj_mensaje) && scr_mouse_sobre(obj_mensaje.sprite_index, 586, 555, 1, 1))
            clic = 1;
    }
    else
    {
        clic = 1;
    }
    
    // El clic es del texto: Amaru no lo recibe
    if (clic)
        global.mouse_click = 0;
}

var tecla = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);
global.texto_confirmar = global.texto_abierto && (tecla || clic) && global.texto_enfriamiento == 0;

if (global.texto_confirmar)
    global.texto_enfriamiento = TEXTO_ENFRIAMIENTO;
}

// Ícono animado de clic izquierdo sobre spr_cuadro_dialogo, donde el texto dice "PRESIONA [ícono] PARA CONTINUAR".
// spr: sprite del cuadro (con gamepad es la versión xbox y no lleva ícono); px, py, escala: como se dibujó el cuadro.
function scr_texto_icono_clic(spr, px, py, escala) {
if (spr != spr_cuadro_dialogo)
    return;

var frame = floor(current_time / 133) mod sprite_get_number(spr_boton_clic);
var tam = 0.66 * escala;
draw_sprite_ext(spr_boton_clic, frame, px + (193 * escala), py + (92 * escala), tam, tam, 0, c_white, 1);
}

// Texto con el estilo de las letras del menú ("letras de barro"): relleno rojo barro oscuro con borde crema.
// Centrado en px, py. escala 1 = unos 22 px de alto; alpha se limita a 1.
// Usa la fuente SDF global.fnt_barro (nítida a cualquier escala); si no cargó, la fuente general.
// El borde se dibuja repitiendo el texto en crema alrededor (los efectos SDF no aplican a fuentes de font_add).
function scr_texto_barro(px, py, texto, escala, alpha) {
var a = clamp(alpha, 0, 1);
var relleno = make_colour_rgb(84, 10, 6);
var borde = make_colour_rgb(255, 248, 212);
var sdf = (global.fnt_barro != -1);
var s = sdf ? (escala * 0.5) : escala;
var g = 2.5 * escala;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(sdf ? global.fnt_barro : general);

for (var ang = 0; ang < 360; ang += 30)
    draw_text_transformed_colour(px + lengthdir_x(g, ang), py + lengthdir_y(g, ang), texto, s, s, 0, borde, borde, borde, borde, a);

draw_text_transformed_colour(px, py, texto, s, s, 0, relleno, relleno, relleno, relleno, a);

draw_set_font(general);
draw_set_valign(fa_top);
}

// Igual que scr_texto_barro pero alineado a la izquierda y arriba en px, py: reemplaza draw_text(px, py, texto)
// sin mover posiciones (menú de pausa). Deja fa_left / fa_top y la fuente que estaba antes.
function scr_texto_barro_izq(px, py, texto, escala, alpha) {
var fuente_antes = draw_get_font();
var a = clamp(alpha, 0, 1);
var relleno = make_colour_rgb(84, 10, 6);
var borde = make_colour_rgb(255, 248, 212);
var sdf = (global.fnt_barro != -1);
var s = sdf ? (escala * 0.5) : escala;
var g = 2.5 * escala;
var t = string_hash_to_newline(texto);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(sdf ? global.fnt_barro : general);

for (var ang = 0; ang < 360; ang += 30)
    draw_text_transformed_colour(px + lengthdir_x(g, ang), py + lengthdir_y(g, ang), t, s, s, 0, borde, borde, borde, borde, a);

draw_text_transformed_colour(px, py, t, s, s, 0, relleno, relleno, relleno, relleno, a);

draw_set_font(fuente_antes);
}
