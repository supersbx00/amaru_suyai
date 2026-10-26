function scr_menuDeck() {
io_clear();

switch (posCursor)
{
    case 0:
        menuOptions = "Editar mazo";
        menuPrincipal = 0;
        menuCartas = 1;
        posCursor = 0;
        break;
    
    case 1:
        menuOptions = "Equipar mazo";
        posCursor = 0;
        break;
    
    case 2:
        menuOptions = "Limpiar mazo";
        posCursor = 0;
        break;
    
    case 3:
        menuOptions = "Renombrar mazo";
        posCursor = 0;
        break;
    
    case 4:
        menuOptions = "Borrar cartas";
        posCursor = 0;
        break;
    
    default:
        scr_text("ERROR", 1, 108, (room_height / (4/3)) + 30);
        break;
}
}
