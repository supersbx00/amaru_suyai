menuInicial[0] = "Nuevo juego";
menuInicial[1] = "Momificar";
menuInicial[2] = "Cargar partida";
menuInicial[3] = "Multijugador";

// Separación vertical entre tablas y sprite de cada opción (para el ancho de los cursores)
menuInicial_paso = 80;
menuInicial_spr = [spr_newGame, spr_momificar, spr_loadGame, spr_credito];

if (file_exists("saveDeck.ini"))
    menuInicial_cursor = 2;
else
    menuInicial_cursor = 0;

image_speed = 0.7;
image_index = 1;
