function scr_cargar_escenario() {
var habitacion;

if (file_exists("Escenario.ini"))
{
    ini_open("Escenario.ini");
    habitacion = ini_read_real("Escenario", "zona", 0);
    ini_close();
}

scr_go_to_room(habitacion);
}
