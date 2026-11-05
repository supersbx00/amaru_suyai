// Control del minijuego de la momia con joystick: el stick izquierdo mueve el puntero de la ventana (así mouse_x/mouse_y,
// el cursor de piedra y todo el arrastre siguen igual). A toma (u empieza a untar) y B suelta (o deja de untar), sin
// tener que mantener nada apretado, para que sea fácil a cualquier edad. El mouse sigue funcionando a la vez, con clic mantenido.
#macro MOMIA_STICK_ZONA 0.2   // zona muerta del stick
#macro MOMIA_STICK_VEL 11     // px de pantalla por frame con el stick a fondo

// Pasos del minijuego (valores de global.numero; el texto de cada uno está en obj_mensaje/Create_0)
#macro MOMIA_PASO_PIEL 3              // retirar la piel
#macro MOMIA_PASO_ORGANOS 4           // quitar huesos y sacar los órganos
#macro MOMIA_PASO_MADEROS_INICIO 6    // aparecen los moldes de los maderos
#macro MOMIA_PASO_MADEROS 7           // poner los maderos desde el inventario
#macro MOMIA_PASO_RELLENO_INICIO 9    // aparecen los moldes del relleno
#macro MOMIA_PASO_RELLENO 10          // poner el relleno
#macro MOMIA_PASO_CRANEO 11           // cerrar el cráneo
#macro MOMIA_PASO_ARCILLA 12          // untar la arcilla
#macro MOMIA_PASO_FALDELLIN 14
#macro MOMIA_PASO_PELO 15
#macro MOMIA_PASO_MASCARA 16
#macro MOMIA_PASO_FELICITACION 17     // ya no aparecen más moldes

// Dónde quedan el cráneo y el esternón al cerrarlo (obj_controlador los pone ahí)
#macro MOMIA_CRANEO_X 622
#macro MOMIA_CRANEO_Y 123
#macro MOMIA_ESTERNON_X 607
#macro MOMIA_ESTERNON_Y 253

// ¿Ya se cerró el cráneo? (los dos huesos están en su lugar)
function scr_momia_craneo_cerrado() {
return instance_exists(obj_craneo) && instance_exists(obj_esternon)
    && obj_craneo.x == MOMIA_CRANEO_X && obj_craneo.y == MOMIA_CRANEO_Y
    && obj_esternon.x == MOMIA_ESTERNON_X && obj_esternon.y == MOMIA_ESTERNON_Y;
}

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

// Paso de los órganos: quitar el cráneo y el esternón, y arrastrar los órganos.
// Lo llama el Step de obj_controlador y usa sus variables (offset_x, offset_y).
function scr_momia_organos_arrastrar() {
// Paso de los órganos: primero se quitan el cráneo y el esternón con clic o A sobre ellos (antes, evento Mouse_0)
if (global.numero == MOMIA_PASO_ORGANOS && scr_momia_presiona())
{
    with (obj_huesos)
    {
        if (point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom))
        {
            instance_destroy();
            break;
        }
    }
}

if (global.prioridad > 13 && !instance_exists(obj_huesos))
{
    if (global.objeto_mouse == -4)
    {
        if (scr_momia_presiona())
        {
            for (var i = 0; i < instance_number(obj_organo); i++)
            {
                var object = instance_find(obj_organo, i);
                
                if (mouse_x > object.bbox_left && mouse_x < object.bbox_right && mouse_y > object.bbox_top && mouse_y < object.bbox_bottom)
                {
                    global.objeto_mouse = object;
                    offset_x = object.x - mouse_x;
                    offset_y = object.y - mouse_y;
                }
            }
        }
    }
    else
    {
        global.objeto_mouse.x = mouse_x + offset_x;
        global.objeto_mouse.y = mouse_y + offset_y;
        
        if (!scr_momia_mantiene())
            global.objeto_mouse = -4;
    }
}
}

// Moldes de cada paso del armado (snap, can_snap, posicionX/posicionY).
// Lo llama el Step de obj_controlador y usa sus variables.
function scr_momia_paso_avanzar() {
if (can_snap == global.numero)
{
    switch (global.numero)
    {
        case MOMIA_PASO_MADEROS_INICIO:
            // El molde snap[i] es de la pieza i + 1 (scr_momia_piezas)
            for (var i = 0; i < 6; i++)
            {
                snap[i] = instance_create(posicionX[i], posicionY[i], obj_snap);
                snap[i].sprite_index = scr_momia_piezas()[i + 1];
            }

            can_snap = MOMIA_PASO_RELLENO_INICIO;
            break;
        
        case MOMIA_PASO_RELLENO_INICIO:
            for (var i = 6; i < 8; i++)
            {
                snap[i] = instance_create(posicionX[i], posicionY[i], obj_snap);
                snap[i].sprite_index = scr_momia_piezas()[i + 1];
            }

            snap[7].depth = -101;
            can_snap = MOMIA_PASO_CRANEO;
            break;

        case MOMIA_PASO_CRANEO:
            // Fijar el cráneo: Enter (X), o un clic o A sobre el cuerpo
            if (!push_enter && (global.mouse_click || gamepad_button_check_pressed(0, gp_face1)) && scr_mouse_sobre(spr_cuerpo, 544, 103, 1, 1))
            {
                push_enter = 1;
                global.mouse_click = 0;
            }
            
            if (push_enter)
            {
                if (!instance_exists(obj_huesos))
                {
                    with (instance_create(x, y, obj_craneo))
                    {
                        x = MOMIA_CRANEO_X;
                        y = MOMIA_CRANEO_Y;
                        depth = -105;
                    }
                    
                    with (instance_create(x, y, obj_esternon))
                    {
                        x = MOMIA_ESTERNON_X;
                        y = MOMIA_ESTERNON_Y;
                        depth = -105;
                    }
                }
                
                can_snap = MOMIA_PASO_ARCILLA;
            }

            break;

        case MOMIA_PASO_ARCILLA:
            for (var i = 0; i < 8; i++)
            {
                if (instance_exists(snap[i]))
                {
                    with (snap[i])
                        instance_destroy();
                }
            }
            
            // La arcilla se unta a mano (obj_arcilla_untar), en vez de soltar la pieza sobre una silueta
            instance_create_depth(posicionX[8], posicionY[8], -106, obj_arcilla_untar);
            can_snap = MOMIA_PASO_FALDELLIN;
            break;

        case MOMIA_PASO_FALDELLIN:
            snap[9] = instance_create(posicionX[9], posicionY[9], obj_snap);
            snap[9].sprite_index = scr_momia_piezas()[10];
            snap[9].depth = -107;
            can_snap = MOMIA_PASO_PELO;
            break;

        case MOMIA_PASO_PELO:
            if (instance_exists(snap[9]))
            {
                with (snap[9])
                    instance_destroy();
            }
            
            snap[10] = instance_create(posicionX[10], posicionY[10], obj_snap);
            snap[10].sprite_index = scr_momia_piezas()[11];
            snap[10].depth = -109;
            can_snap = MOMIA_PASO_MASCARA;
            break;

        case MOMIA_PASO_MASCARA:
            if (instance_exists(snap[10]))
            {
                with (snap[10])
                    instance_destroy();
            }
            
            snap[11] = instance_create(posicionX[11], posicionY[11], obj_snap);
            snap[11].sprite_index = scr_momia_piezas()[12];
            snap[11].depth = -111;
            can_snap = MOMIA_PASO_FELICITACION;
            break;
    }
}
}
