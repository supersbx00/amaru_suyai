function scr_cargar_cartas() {
ini_open("saveCards.ini");
var aux_cantidadCartas = ini_read_real("Cantidad tipo cartas", "Cantidad", 0);

for (var j = 0; j < aux_cantidadCartas; j++)
{
    with (instance_create(x, y, obj_card))
    {
        card_morral[0] = scr_sprite_cargado("Carta " + string(j), "Sprite nombre", "Sprite");
        card_morral[1] = ini_read_real("Carta " + string(j), "Image_index", 0);
        card_morral[2] = "COPIAS";
        card_morral[3] = "No type";
        card_morral[4] = "NO CP";
        card_morral[5] = "No name";
        card_morral[6] = "No description";
        scr_asignaValores_segunCarta();
        var aux_cardMorral = card_morral[2];
        
        for (var k = 0; k < 10; k++)
        {
            aux_cardMorral[k] = ini_read_real("Carta " + string(j) + " Copia " + string(k), "Valor", 0);
            
            if (aux_cardMorral[k] != 0)
                obj_morral.cantidadCartas += aux_cardMorral[k];
        }
        
        card_morral[2] = aux_cardMorral;
        
        // Carta que no se pudo reconocer: se descarta en vez de romper el inventario
        if (is_numeric(card_morral[4]))
            ds_list_add(obj_morral.morralCards, card_morral);
        instance_destroy();
    }
}

ini_close();
}
