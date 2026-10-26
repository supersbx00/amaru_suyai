global.puntaje_total_descrasheo += 15;
global.puntaje_total += 15;
var lootChance = irandom(6);
nombre = "premio_materiales";

with (instance_create(x, y, obj_materiales))
{
    script_execute(scr_asignaValores_segunMaterial);
    var materialExist = 0;
    
    for (var j = 0; j < ds_list_size(obj_morral.morral); j++)
    {
        var inventoryMaterial = ds_list_find_value(obj_morral.morral, j);
        
        if (material[0] == inventoryMaterial[0])
        {
            inventoryMaterial[3] += 1;
            ds_list_replace(obj_morral.morral, j, inventoryMaterial);
            materialExist = 1;
        }
    }
    
    if (!materialExist)
    {
        data_material[0] = material[0];
        data_material[1] = material[1];
        data_material[2] = material[2];
        data_material[3] = material[3];
        ds_list_add(obj_morral.morral, data_material);
    }
    
    obj_morral.cantidadMaterial += 1;
    instance_destroy();
}

if (!instance_exists(obj_dialogo_premio))
{
    with (instance_create(x, y, obj_dialogo_premio))
        npc = "premio_materiales";
}
