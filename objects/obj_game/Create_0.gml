segJugados = 0;
minJugados = 0;
hrsJugadas = 0;
global.gp = 0;
global.modo_prueba = 0;
global.suyai_unida = 0;     // Suyai acompaña a Amaru en el mapa
global.tiempo_juego = 0;    // cuadros jugados fuera del menú inicial (reaparición de materiales)
global.materiales_recogidos = {}; // "sala:x:y" de materiales colocados ya recogidos (ver obj_materiales)
global.combo_recordado = 0; // la ayuda del combo ya apareció con la vida baja (una vez por partida)
global.ver_colisiones = 0;  // F3 en batalla: dibuja las formas físicas
global.personaje = "amaru"; // personaje controlado: "amaru" o "suyai"
global.cambio_destello = 0; // frames de destello tras cambiar de personaje
global.mouse_click = 0;
global.mouse_atras = 0;
global.mouse_movido = 0;
global.mouse_enfriamiento = 0;
// Posición del mouse en la ventana (no en la sala: la cámara moviéndose no cuenta como mover el mouse)
global.mouse_wx_prev = window_mouse_get_x();
global.mouse_wy_prev = window_mouse_get_y();
// Cursor de piedra (el de la momia) en todo el juego, en vez del de Windows
window_set_cursor(cr_none);
cursor_sprite = spr_cursor1;
global.texto_abierto = 0;
// Letras de barro (estilo de las letras del menú): Liberation Sans Narrow Bold incluida en datafiles,
// en SDF para que se vea nítida a cualquier escala (el borde crema lo dibuja scr_texto_barro)
global.fnt_barro = font_add("LiberationSansNarrow-Bold.ttf", 44, true, false, 32, 255);

if (global.fnt_barro != -1)
    font_enable_sdf(global.fnt_barro, true);
global.texto_confirmar = 0;
global.texto_enfriamiento = 0;
global.z_virtual = 0;
global.z_virtual_pendiente = 0;
global.frame_actual = 0; // contador de frames (scr_texto_actualizar)
global.aviso_frame = -10; // último frame en que se dibujó el aviso de interacción (scr_aviso_interaccion)
global.pause = 0; // antes solo lo creaba obj_pause; scr_amaru_clic lo lee en salas donde aún no existe
totalJugado[0] = 0;
totalJugado[1] = 0;
global.dist = 1320;
upText = undefined;
alpha = undefined;
nombreMaterial = undefined;

with (other.id)
{
    global.last_room = undefined;
    global.last_paso = undefined;
}

materia_recolectada = ds_list_create();
escena_grabada = ds_list_create();
cambio_escena = ds_list_create();
load = 0;
global.ide = undefined;
instance_create(x, y, obj_sound_control);
global.puntaje_total = 0;
global.puntaje_total_descrasheo = 0;
global.cinematica = 0;
global.enable_player = 0;
global.enable_battle = 0;
global.anciana = 0;
global.zona = 0;

// Guardado anterior a la carpeta "partida/": se copia antes de que el reinicio de abajo limpie los archivos en curso
if (!file_exists("partida/Escenario.ini") && file_exists("Escenario.ini"))
    scr_partida_respaldar();

if (!file_exists("recetas.ini") || !file_exists("logros.ini"))
{
    show_message("entro");
    script_execute(scr_recetas);
    script_execute(scr_lista_logros);
}

// Materiales que aparecen con el tiempo en el mapa (scr_materiales_aparecer): estado de la visita a la sala
mat_sala = noone;
mat_reloj = 0;
mat_aparecidos = 0;
mat_actual = noone;
mat_rastro = ds_list_create();
