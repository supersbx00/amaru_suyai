function scr_ordenaMazo() {
for (var i = 0; i < obj_morral.mazo_seleccionado[4]; i++)
{
    if (ds_list_find_value(obj_morral.mazo_seleccionado[2], i) == obj_morral.noCard)
    {
        var noCard_here = i;
        var flag = i + 1;
        
        while (ds_list_find_value(obj_morral.mazo_seleccionado[2], flag) == obj_morral.noCard)
            flag++;
        
        yesCard_here = ds_list_find_value(obj_morral.mazo_seleccionado[2], flag);
        ds_list_replace(obj_morral.mazo_seleccionado[2], noCard_here, yesCard_here);
        ds_list_replace(obj_morral.mazo_seleccionado[2], flag, obj_morral.noCard);
    }
}
}
