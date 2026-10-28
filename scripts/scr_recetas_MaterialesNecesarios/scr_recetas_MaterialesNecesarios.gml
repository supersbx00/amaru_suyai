function scr_recetas_MaterialesNecesarios(_material, _x, _y, _cantidad) {
if (_material != "No material")
{
    var sprite_item = scr_asignaSprite_segunNombre(_material);
    var dataOut = undefined;
    
    for (var i = 0; i < ds_list_size(obj_morral.morral); i++)
    {
        dataOut = ds_list_find_value(obj_morral.morral, i);
        
        if (dataOut[1] == _material)
        {
            if (dataOut[3] >= real(_cantidad))
            {
                draw_set_color(c_black);
                draw_sprite(sprite_item, 0, _x, _y);
                draw_sprite(spr_nros, _cantidad, _x + 60, _y - 20);
            }
            else if (dataOut[3] < real(_cantidad))
            {
                draw_set_color(c_black);
                draw_sprite(sprite_item, 0, _x, _y);
                draw_sprite(spr_nros, _cantidad, _x + 60, _y - 20);
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
        draw_sprite(sprite_item, 0, _x, _y);
        draw_sprite(spr_nros, _cantidad, _x + 60, _y - 20);
    }
}
}
