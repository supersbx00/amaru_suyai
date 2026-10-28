function scr_guardar_datos() {
// Modo prueba ("Momificar"): no se escribe nada en disco
if (global.modo_prueba)
    exit;

if (file_exists("datosJuego.ini"))
    file_delete("datosJuego.ini");

ini_open("datosJuego.ini");
ini_write_real("puntaje jugador crasheado", "valor", global.puntaje_total);
ini_write_real("puntaje jugador crasheado", "espiritu_luna", global.espiritu_luna);
ini_write_real("puntaje jugador crasheado", "espiritu_agua", global.espiritu_agua);
ini_write_real("puntaje jugador crasheado", "espiritu_fuego", global.espiritu_fuego);
ini_write_real("puntaje jugador crasheado", "khoru", global.khoru);
ini_close();
}
