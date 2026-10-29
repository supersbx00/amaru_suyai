confirmar = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);
abortar = keyboard_check_pressed(ord("X")) || gamepad_button_check_pressed(0, gp_face4);

// Mouse: clic en "Sí" = Z, clic en "No" o clic derecho = X
var cx = camera_get_view_x(view_camera[0]) + 660;
var cy = camera_get_view_y(view_camera[0]) + 368;

if (global.mouse_click)
{
    if (point_distance(mouse_x, mouse_y, cx - 150, cy + 163) <= 55)
        confirmar = 1;
    else if (point_distance(mouse_x, mouse_y, cx + 150, cy + 163) <= 55)
        abortar = 1;
    
    global.mouse_click = 0;
}

if (global.mouse_atras)
{
    abortar = 1;
    global.mouse_atras = 0;
}

// La confirmación se ejecuta una sola vez aunque lleguen varias pulsaciones antes de cambiar de room
if (resuelto)
    exit;

if (confirmar)
{
    resuelto = 1;
    
    if (estado == "nuevo")
    {
        global.modo_prueba = 0;
        global.suyai_unida = 0;
        global.combo_recordado = 0;
        global.materiales_recogidos = {};
        global.personaje = "amaru";
        scr_go_to_room(1);
        script_execute(scr_recetas);
        script_execute(scr_lista_logros);
    }
    else if (estado == "cargar")
    {
        global.modo_prueba = 0;

        // La partida guardada vuelve a los archivos en curso; las recetas se leen de nuevo porque obj_morral las leyó al crearse
        scr_partida_restaurar();

        with (obj_morral)
        {
            ds_list_clear(recipeBook);
            scr_cargar_receta();
        }

        // Si la sala guardada no existe, se vuelve al menú con el aviso (scr_cargar_escenario)
        if (!scr_cargar_escenario())
        {
            instance_destroy();
            exit;
        }
        
        script_execute(scr_cargar_item);
        script_execute(scr_cargar_cartas);
        script_execute(scr_cargar_mazos);
        script_execute(scr_cargar_logros);
        global.escena_load = 1;
        script_execute(scr_cargar_datos);
        obj_game.load = 1;
    }
    else if (estado == "salir")
    {
        // Desde la pausa: vuelve al menú de título; lo no guardado se pierde (lo avisa el cuadro)
        game_restart();
    }
}
else if (abortar)
{
    instance_destroy();
}

// Desde la pausa ("salir") queda encima del menú de pausa (depth -1 / -100)
if (estado != "salir")
    depth = -1;
