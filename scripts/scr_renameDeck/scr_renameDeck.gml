function scr_renameDeck() {
// Se ejecuta en obj_pause. La respuesta llega a su evento Asíncrono de diálogo (Other_63).
if (renombrar_peticion == -1)
{
    renombrar_mazo = posCursor;
    renombrar_peticion = get_string_async("Cambia el nombre del mazo:", string(obj_morral.mazo[0, posCursor]));
}
}
