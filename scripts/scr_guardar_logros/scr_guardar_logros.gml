function scr_guardar_logros() {
if (file_exists("logros.ini"))
    file_delete("logros.ini");

ini_open("logros.ini");
ini_write_real("Mision", "zona", global.zona);
ini_write_real("Mision", "anciana", global.anciana);
ini_write_real("Mision", "luna", global.espiritu_luna);
ini_write_real("Mision", "agua", global.espiritu_agua);
ini_write_real("Mision", "fuego", global.espiritu_fuego);
ini_write_real("Mision", "khoru", global.khoru);
ini_close();
}
