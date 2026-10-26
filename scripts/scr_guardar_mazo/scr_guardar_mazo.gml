function scr_guardar_mazo() {
if (file_exists("saveDeck.ini"))
    file_delete("saveDeck.ini");

ini_open("saveDeck.ini");

with (obj_morral)
{
    for (i = 0; i < 3; i++)
    {
        var aux_nombre = mazo[0, i];
        var aux_cartas = mazo[1, i];
        var aux_sumaCP = mazo[2, i];
        var aux_copyInv = mazo[3, i];
        var aux_cantCards = mazo[4, i];
        ini_write_string("Nombre", "mazo " + string(i), aux_nombre);
        var aux_mazo = aux_cartas;
        
        for (j = 0; j < 27; j++)
        {
            var aux_noUndefined = ds_list_find_value(aux_mazo, j);
            
            if (aux_noUndefined[1] != undefined)
            {
                ini_write_real("Cartas del Mazo " + string(i), "Sprite carta " + string(j), aux_noUndefined[0]);
                ini_write_real("Cartas del Mazo " + string(i), "Image index carta " + string(j), aux_noUndefined[1]);
            }
            else
            {
                j = 30;
            }
        }
        
        ini_write_real("Suma CP", "mazo " + string(i), aux_sumaCP);
        ini_write_real("Copy Inv", "mazo " + string(i), aux_copyInv);
        ini_write_real("Cant Cards", "mazo " + string(i), aux_cantCards);
    }
}

ini_close();
}
