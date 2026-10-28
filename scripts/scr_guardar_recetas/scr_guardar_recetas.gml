function scr_guardar_recetas() {
// Modo prueba ("Momificar"): no se escribe nada en disco
if (global.modo_prueba)
    exit;

ini_open("recetas.ini");

for (var i = 0; i < ds_list_size(obj_morral.recipeBook); i++)
{
    var aux_search = ds_list_find_value(obj_morral.recipeBook, i);
    
    switch (aux_search[7])
    {
        case "Anzuelo hueso de ave":
            ini_write_real("anzuelo_huesoAve", "enable", aux_search[10]);
            break;
        
        case "Arpon de hueso":
            ini_write_real("anzuelo_huesoAve", "enable", aux_search[10]);
            break;
        
        case "Estolica de Madera":
            ini_write_real("estolica_madera", "enable", aux_search[10]);
            break;
        
        case "Anzuelo de concha":
            ini_write_real("anzuelo_choro", "enable", aux_search[10]);
            break;
        
        case "Chope Lobo de mar":
            ini_write_real("chope_lobo", "enable", aux_search[10]);
            break;
    }
}

ini_close();
}
