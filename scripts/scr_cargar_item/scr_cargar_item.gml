function scr_cargar_item() {
ini_open("saveItems.ini");
var auxCantidad = ini_read_real("Cantidad tipo material", "cant_tipoMaterial", 0);

for (var i = 0; i < auxCantidad; i++)
{
    with (instance_create(x, y, obj_materiales))
    {
        material[0] = ini_read_real("Material " + string(i), "Sprite", 0);
        material[1] = ini_read_string("Material " + string(i), "Nombre", "");
        material[2] = ini_read_string("Material " + string(i), "Descr.", "");
        material[3] = ini_read_real("Material " + string(i), "Cantidad", 0);
        ds_list_add(obj_morral.morral, material);
        instance_destroy();
    }
}

ini_close();
}
