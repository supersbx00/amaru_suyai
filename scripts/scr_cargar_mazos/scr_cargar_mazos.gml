function scr_cargar_mazos() {
ini_open("saveDeck.ini");

with (obj_morral)
{
    for (var i = 0; i < 3; i++)
    {
        mazo[0, i] = ini_read_string("Nombre", "mazo " + string(i), "Mazo default");
        mazo[2, i] = ini_read_real("Suma CP", "mazo " + string(i), 0);
        mazo[3, i] = ini_read_real("Copy Inv", "mazo " + string(i), 0);
        mazo[4, i] = ini_read_real("Cant Cards", "mazo " + string(i), 0);
        
        for (var j = 0; j < 27; j++)
        {
            var aux_noUndefined = ini_read_real("Cartas del Mazo " + string(i), "Image index carta " + string(j), 0);
            global.aux1 = aux_noUndefined;
            
            if (aux_noUndefined != undefined && aux_noUndefined != 0)
            {
                global.mensaje = "entro";
                
                with (instance_create(x, y, obj_card))
                {
                    card_morral[0] = ini_read_real("Cartas del Mazo " + string(i), "Sprite carta " + string(j), 32);
                    card_morral[1] = ini_read_real("Cartas del Mazo " + string(i), "Image index carta " + string(j), 0);
                    card_morral[2] = card_morral[1];
                    card_morral[3] = "No type";
                    card_morral[4] = "NO CP";
                    card_morral[5] = "No name";
                    card_morral[6] = "No description";
                    scr_asignaValores_segunCarta();
                    card_morral[4] = round(card_morral[4] + (card_morral[1] * 0.8));
                    var aux_listaMazo = obj_morral.mazo[1, i];
                    ds_list_replace(aux_listaMazo, j, card_morral);
                    instance_destroy();
                }
            }
            else
            {
                j = 30;
            }
        }
    }
}

ini_close();
}
