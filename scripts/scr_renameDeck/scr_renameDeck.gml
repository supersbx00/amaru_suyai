function scr_renameDeck() {
if (show_question("Deseas cambiar el nombre " + string(obj_morral.mazo[0, posCursor]) + "?"))
    obj_morral.mazo[0, posCursor] = get_string("Cambia el nombre: ", "");
}
