menuInicial[0] = "Nuevo juego";
menuInicial[1] = "Cargar partida";
menuInicial[2] = "Multijugador";

if (file_exists("saveDeck.ini"))
    menuInicial_cursor = 1;
else
    menuInicial_cursor = 0;

image_speed = 0.7;
image_index = 1;
