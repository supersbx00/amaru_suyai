function scr_cargar_posicion() {
if (file_exists("Escenario.ini"))
{
    ini_open("Escenario.ini");
    phy_position_x = ini_read_real("Escenario", "posicion_x", 0);
    phy_position_y = ini_read_real("Escenario", "posicion_y", 0);
    ini_close();
}
}
