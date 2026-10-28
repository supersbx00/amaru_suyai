segJugados = 0;
minJugados = 0;
hrsJugadas = 0;
global.gp = 0;
global.modo_prueba = 0;
global.mouse_click = 0;
global.mouse_atras = 0;
global.mouse_movido = 0;
global.mouse_enfriamiento = 0;
global.mouse_x_prev = mouse_x;
global.mouse_y_prev = mouse_y;
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

if (!file_exists("recetas.ini") || !file_exists("logros.ini"))
{
    show_message("entro");
    script_execute(scr_recetas);
    script_execute(scr_lista_logros);
}
