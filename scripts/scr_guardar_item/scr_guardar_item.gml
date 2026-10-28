function scr_guardar_item() {
// Modo prueba ("Momificar"): no se escribe nada en disco
if (global.modo_prueba)
    exit;

if (file_exists("saveItems.ini"))
{
    file_delete("saveItems.ini");
    obj_morral.cant_tipoMaterial = 0;
}

ini_open("saveItems.ini");

with (obj_morral)
{
    if (!ds_list_empty(morral))
    {
        for (var i = 0; i < ds_list_size(morral); i++)
        {
            insideMorral = ds_list_find_value(morral, i);
            ini_write_real("Material " + string(i), "Sprite", insideMorral[0]);
            ini_write_string("Material " + string(i), "Nombre", insideMorral[1]);
            ini_write_string("Material " + string(i), "Descr.", insideMorral[2]);
            ini_write_real("Material " + string(i), "Cantidad", insideMorral[3]);
            cant_tipoMaterial++;
        }
        
        ini_write_real("Cantidad tipo material", "cant_tipoMaterial", cant_tipoMaterial);
    }
}

ini_close();
}
