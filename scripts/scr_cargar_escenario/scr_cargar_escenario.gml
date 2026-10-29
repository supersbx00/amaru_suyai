// Va a la sala guardada. Devuelve false si no hay guardado o la sala no existe (avisa en el menú inicial).
function scr_cargar_escenario() {
var habitacion = -1;

if (file_exists("Escenario.ini"))
{
    ini_open("Escenario.ini");
    var nombre = ini_read_string("Escenario", "zona_nombre", "");
    var numero = ini_read_real("Escenario", "zona", -1);
    ini_close();
    
    if (nombre != "")
        habitacion = asset_get_index(nombre);
    
    // Guardados anteriores solo tienen el número de la sala
    if (habitacion == -1 || !room_exists(habitacion))
        habitacion = numero;
}

if (habitacion == -1 || !room_exists(habitacion))
{
    with (obj_menuController)
    {
        aviso_texto = "No se pudo cargar la partida guardada";
        aviso_tiempo = 120;
    }
    
    return false;
}

scr_go_to_room(habitacion);
return true;
}
