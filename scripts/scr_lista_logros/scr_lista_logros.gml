function scr_lista_logros() {
ini_open("logros.ini");
ini_write_real("Mision", "zona", 0);
ini_write_real("Mision", "anciana", 0);
ini_write_real("Mision", "luna", 0);
ini_write_real("Mision", "agua", 0);
ini_write_real("Mision", "fuego", 0);
ini_write_real("Mision", "khoru", 0);
ini_close();
}
