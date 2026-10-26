function scr_desbloquearRecetas() {
for (var i = 0; i < ds_list_size(obj_morral.recipeBook); i++)
{
    var dataOut = ds_list_find_value(obj_morral.recipeBook, i);
    
    if (dataOut[7] == argument0)
    {
        dataOut[10] = 1;
        ds_list_replace(obj_morral.recipeBook, i, dataOut);
        i = ds_list_size(obj_morral.recipeBook) + 100;
    }
}
}
