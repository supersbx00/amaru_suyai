function scr_guardar_cuarto() {
// Modo prueba ("Momificar"): no se escribe nada en disco
if (global.modo_prueba)
    exit;

if (menuOptions == "Guardar")
{
    if (file_exists("Escenario.ini"))
        file_delete("Escenario.ini");
    
    if (!ds_list_empty(obj_game.escena_grabada))
    {
        ini_open("Escenario.ini");
        temp = ds_list_find_value(obj_game.escena_grabada, 0);
        ini_write_real("Escenario", "zona", room);
        ini_write_real("Escenario", "posicion_x", temp[0]);
        ini_write_real("Escenario", "posicion_y", temp[1]);
        ini_close();
    }
}
}
