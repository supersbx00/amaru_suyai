function scr_guardar_cartas() {
// Modo prueba ("Momificar"): no se escribe nada en disco
if (global.modo_prueba)
    exit;

if (file_exists("saveCards.ini"))
{
    file_delete("saveCards.ini");
    obj_morral.cant_tipoCartas = 0;
}

ini_open("saveCards.ini");

with (obj_morral)
{
    if (!ds_list_empty(morralCards))
    {
        for (var j = 0; j < ds_list_size(morralCards); j++)
        {
            aux_morralCards = ds_list_find_value(morralCards, j);
            ini_write_real("Carta " + string(j), "Sprite", aux_morralCards[0]);
            ini_write_real("Carta " + string(j), "Image_index", aux_morralCards[1]);
            cant_tipoCartas++;
            
            for (k = 0; k < 10; k++)
            {
                listaAux_morralCards = aux_morralCards[2];
                ini_write_real("Carta " + string(j) + " Copia " + string(k), "Valor", listaAux_morralCards[k]);
            }
        }
        
        ini_write_real("Cantidad tipo cartas", "Cantidad", cant_tipoCartas);
    }
}

ini_close();
ds_list_clear(obj_morral.morralCards);
script_execute(scr_cargar_cartas);
}
