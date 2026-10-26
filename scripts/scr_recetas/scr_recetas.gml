function scr_recetas() {
if (file_exists("recetas.ini"))
{
    file_delete("Escenario.ini");
    file_delete("datosJuego.ini");
    file_delete("saveCards.ini");
    file_delete("saveItems.ini");
    file_delete("logros.ini");
    file_delete("saveDeck.ini");
}

ini_open("recetas.ini");
ini_write_string("anzuelo_huesoAve", "nombre", "Anzuelo hueso de ave");
ini_write_string("anzuelo_huesoAve", "materialA", "Fibra vegetal");
ini_write_real("anzuelo_huesoAve", "cantidadA", 2);
ini_write_real("anzuelo_huesoAve", "enable", 0);
ini_write_string("anzuelo_huesoAve", "materialB", "Huesos de ave");
ini_write_real("anzuelo_huesoAve", "cantidadB", 3);
ini_write_real("anzuelo_huesoAve", "enable", 0);
ini_write_string("arpon_hueso", "nombre", "Arpon hueso");
ini_write_string("arpon_hueso", "materialA", "Huesos de ave");
ini_write_real("arpon_hueso", "cantidadA", 2);
ini_write_string("arpon_hueso", "materialB", "Fibra vegetal");
ini_write_real("arpon_hueso", "cantidadB", 3);
ini_write_real("arpon_hueso", "enable", 1);
ini_write_string("estolica_madera", "nombre", "Estolica de Madera");
ini_write_string("estolica_madera", "materialA", "Madera");
ini_write_real("estolica_madera", "cantidadA", 3);
ini_write_string("estolica_madera", "materialB", "Fibra vegetal");
ini_write_real("estolica_madera", "cantidadB", 2);
ini_write_real("estolica_madera", "enable", 0);
ini_write_string("anzuelo_choro", "nombre", "Anzuelo de concha de choro");
ini_write_string("anzuelo_choro", "materialA", "Fibra vegetal");
ini_write_real("anzuelo_choro", "cantidadA", 1);
ini_write_string("anzuelo_choro", "materialB", "Choros");
ini_write_real("anzuelo_choro", "cantidadB", 2);
ini_write_real("anzuelo_choro", "enable", 0);
ini_write_string("chope_lobo", "nombre", "Chope de costilla de lobo");
ini_write_string("chope_lobo", "materialA", "Fibra vegetal");
ini_write_real("chope_lobo", "cantidadA", 3);
ini_write_string("chope_lobo", "materialB", "C. lobo de mar");
ini_write_real("chope_lobo", "cantidadB", 1);
ini_write_real("chope_lobo", "enable", 0);
ini_close();
}
