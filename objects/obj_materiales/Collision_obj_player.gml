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
obj_game.upText = 1;
obj_game.alpha = 1.5;
obj_game.nombreMaterial = material[1];

if (instance_exists(obj_control_tutorial))
{
    if (obj_control_tutorial.tutorialOn)
        obj_control_tutorial.cantidad_materiales--;
}

instance_destroy();
