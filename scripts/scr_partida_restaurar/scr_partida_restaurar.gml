// Copia la partida guardada ("partida/") sobre los archivos en curso, antes de cargarlos.
function scr_partida_restaurar() {
var archivos = ["Escenario.ini", "datosJuego.ini", "saveCards.ini", "saveItems.ini", "saveDeck.ini", "logros.ini", "recetas.ini"];

for (var i = 0; i < array_length(archivos); i++)
{
    var origen = "partida/" + archivos[i];
    var destino = archivos[i];
    
    // Si al guardado le falta un archivo (guardados viejos), se conserva el en curso
    if (!file_exists(origen))
        continue;
    
    if (file_exists(destino))
        file_delete(destino);
    
    file_copy(origen, destino);
}
}
