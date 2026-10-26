function scr_cargar_logros() {
if (file_exists("logros.ini"))
{
    ini_open("logros.ini");
    global.zona = ini_read_real("Mision", "zona", 0);
    global.espiritu_agua = ini_read_real("Mision", "agua", 0);
    global.espiritu_fuego = ini_read_real("Mision", "fuego", 0);
    global.espiritu_luna = ini_read_real("Mision", "luna", 0);
    global.anciana = ini_read_real("Mision", "anciana", 0);
    ini_close();
}
}
