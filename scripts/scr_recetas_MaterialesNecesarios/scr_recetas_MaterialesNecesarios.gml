function scr_recetas_MaterialesNecesarios() {
if (argument0 != "No material")
{
    var sprite_item = scr_asignaSprite_segunNombre(argument0);
    var dataOut = undefined;
    
    for (var i = 0; i < ds_list_size(obj_morral.morral); i++)
    {
        dataOut = ds_list_find_value(obj_morral.morral, i);
        
        if (dataOut[1] == argument0)
        {
            if (dataOut[3] >= real(argument3))
            {
                draw_set_color(c_black);
                draw_sprite(sprite_item, 0, argument1, argument2);
                draw_sprite(spr_nros, argument3, argument1 + 60, argument2 - 20);
            }
            else if (dataOut[3] < real(argument3))
            {
                draw_set_color(c_black);
                draw_sprite(sprite_item, 0, argument1, argument2);
                draw_sprite(spr_nros, argument3, argument1 + 60, argument2 - 20);
            }
            
            i = ds_list_size(obj_morral.morral) + 10;
        }
        else
        {
            dataOut = undefined;
        }
    }
    
    if (dataOut == undefined)
    {
        draw_sprite(sprite_item, 0, argument1, argument2);
        draw_sprite(spr_nros, argument3, argument1 + 60, argument2 - 20);
    }
}
}
