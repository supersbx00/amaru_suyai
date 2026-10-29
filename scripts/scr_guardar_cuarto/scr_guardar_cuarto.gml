function scr_guardar_cuarto() {
// Modo prueba ("Momificar"): no se escribe nada en disco
if (global.modo_prueba)
    exit;

if (menuOptions == "Guardar")
{
    // Posición más reciente; si la lista está vacía, se toma de obj_player
    var pos = undefined;
    
    if (!ds_list_empty(obj_game.escena_grabada))
        pos = ds_list_find_value(obj_game.escena_grabada, 0);
    else if (instance_exists(obj_player))
        pos = [obj_player.x, obj_player.y, room];
    
    // Sin posición no se borra: la partida no se queda sin sala
    if (pos != undefined)
    {
        if (file_exists("Escenario.ini"))
            file_delete("Escenario.ini");

        ini_open("Escenario.ini");
        // La sala se guarda por nombre: en GameMaker 2024 `room` es una referencia y su número no es confiable
        ini_write_string("Escenario", "zona_nombre", room_get_name(room));
        ini_write_real("Escenario", "zona", room);
        ini_write_real("Escenario", "posicion_x", pos[0]);
        ini_write_real("Escenario", "posicion_y", pos[1]);
        ini_close();
    }
}
}
