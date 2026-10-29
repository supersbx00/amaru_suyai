// Copia los archivos de guardado a "partida/": esa copia es la partida guardada.
// Empezar de nuevo (Nuevo juego, W+H+A, arranque) limpia los archivos en curso pero nunca esta carpeta.
function scr_partida_respaldar() {
var archivos = ["Escenario.ini", "datosJuego.ini", "saveCards.ini", "saveItems.ini", "saveDeck.ini", "logros.ini", "recetas.ini"];

if (!directory_exists("partida"))
    directory_create("partida");

for (var i = 0; i < array_length(archivos); i++)
{
    var origen = archivos[i];
    var destino = "partida/" + archivos[i];
    
    if (!file_exists(origen))
        continue;
    
    // file_copy no sobrescribe en todas las plataformas
    if (file_exists(destino))
        file_delete(destino);
    
    file_copy(origen, destino);
}
}
