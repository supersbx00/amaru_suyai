confirmar = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);
abortar = keyboard_check_pressed(ord("X")) || gamepad_button_check_pressed(0, gp_face4);

if (confirmar)
{
    if (estado == "nuevo")
    {
        scr_go_to_room(1);
        script_execute(scr_recetas);
        script_execute(scr_lista_logros);
    }
    else if (estado == "cargar")
    {
        script_execute(scr_cargar_item);
        script_execute(scr_cargar_cartas);
        script_execute(scr_cargar_mazos);
        script_execute(scr_cargar_logros);
        global.escena_load = 1;
        script_execute(scr_cargar_escenario);
        script_execute(scr_cargar_datos);
        obj_game.load = 1;
    }
}
else if (abortar)
{
    instance_destroy();
}

depth = -1;
