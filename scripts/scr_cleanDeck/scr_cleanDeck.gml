function scr_cleanDeck() {
if (show_question("Estas seguro que quieres limpiar el mazo " + string(obj_morral.mazo[0, posCursor]) + "?"))
{
    for (var buscador = 0; buscador < 100; buscador++)
    {
        var auxRemove_card = ds_list_find_value(obj_morral.mazo[1, posCursor], buscador);
        
        if (auxRemove_card[1] != 13)
        {
            for (var i = 0; i < ds_list_size(obj_morral.morralCards); i++)
            {
                var auxCompare = ds_list_find_value(obj_morral.morralCards, i);
                
                if (auxRemove_card[0] == auxCompare[0])
                {
                    var auxCompare_array = auxCompare[2];
                    auxCompare_array[auxRemove_card[2]] += 1;
                    auxCompare[2] = auxCompare_array;
                    ds_list_replace(obj_morral.morralCards, i, auxCompare);
                    obj_morral.cantidadCartas += 1;
                    obj_morral.mazo[4, posCursor] -= 1;
                    ds_list_replace(obj_morral.mazo[1, posCursor], buscador, obj_morral.noCard);
                    i = 1000;
                }
            }
        }
        
        if (obj_morral.mazo[4, posCursor] == 0)
            buscador = 110;
    }
    
    obj_morral.mazo[2, posCursor] = 0;
    ds_list_copy(obj_morral.mazo[3, posCursor], obj_morral.morralCards);
    obj_morral.mazo[4, posCursor] = 0;
}
}
