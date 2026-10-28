function scr_cargar_datos() {
ini_open("datosJuego.ini");
global.puntaje_total = ini_read_real("puntaje jugador crasheado", "valor", 0);
global.puntaje_total_descrasheo = ini_read_real("puntaje jugador", "valor", 0);
global.espiritu_luna = ini_read_real("puntaje jugador crasheado", "espiritu_luna", 0);
global.espiritu_agua = ini_read_real("puntaje jugador crasheado", "espiritu_agua", 0);
global.espiritu_fuego = ini_read_real("puntaje jugador crasheado", "espiritu_fuego", 0);
global.suyai_unida = ini_read_real("acompanante", "suyai_unida", 0);
global.personaje = ini_read_string("acompanante", "personaje", "amaru");
ini_close();
}
