function scr_lista_logros_memorin() {
var i;

if (subMenu == "personas")
{
    var aux_visorRange_min_diario = visorRange_min_diario;
    
    for (i = 0; i < 6; i++)
    {
        var aux_persona = ds_list_find_value(listaLogros_personas, aux_visorRange_min_diario);
        
        if (aux_persona[0])
        {
            draw_sprite_ext(aux_persona[4], 0, __view_get(0, 0) + 230, __view_get(1, 0) + 150 + (90 * i), 1, 1, 0, c_blue, 1);
            draw_text(__view_get(0, 0) + 290, __view_get(1, 0) + 130 + (90 * i), aux_persona[2]);
        }
        else
        {
            draw_sprite(spr_cuadro_item, 0, __view_get(0, 0) + 230, __view_get(1, 0) + 150 + (90 * i));
            draw_text(__view_get(0, 0) + 290, __view_get(1, 0) + 130 + (90 * i), string_hash_to_newline("---------------"));
        }
        
        if (aux_visorRange_min_diario < (ds_list_size(listaLogros_personas) - 1))
            aux_visorRange_min_diario += 1;
    }
    
    var posCursor_listaLogros_personas = ds_list_find_value(listaLogros_personas, posCursor);
    
    if (posCursor_listaLogros_personas[0])
    {
        switch (posCursor)
        {
            case 0:
                draw_sprite(posCursor_listaLogros_personas[5], 0, __view_get(0, 0) + (__view_get(2, 0) / 2) + 250, (__view_get(1, 0) + (__view_get(3, 0) / 2)) - 150);
                draw_text(__view_get(0, 0) + (__view_get(2, 0) / 2) + 30, __view_get(1, 0) + (__view_get(3, 0) / 2) + 90, posCursor_listaLogros_personas[3]);
                break;
            
            case 4:
                draw_sprite(posCursor_listaLogros_personas[5], 0, __view_get(0, 0) + (__view_get(2, 0) / 2) + 250, (__view_get(1, 0) + (__view_get(3, 0) / 2)) - 150);
                draw_text(__view_get(0, 0) + (__view_get(2, 0) / 2) + 30, __view_get(1, 0) + (__view_get(3, 0) / 2) + 90, posCursor_listaLogros_personas[3]);
                break;
            
            default:
                draw_sprite(spr_info, 0, __view_get(0, 0) + (__view_get(2, 0) / 2) + 250, (__view_get(1, 0) + (__view_get(3, 0) / 2)) - 150);
                draw_text(__view_get(0, 0) + (__view_get(2, 0) / 2) + 30, __view_get(1, 0) + (__view_get(3, 0) / 2) + 90, "Hace falta el caso nro " + string(posCursor) + " en\nscr_lista_logros_memorin");
        }
    }
}

if (subMenu == "objetos")
{
    for (i = 0; i < 1; i++)
    {
        var aux_objetos = ds_list_find_value(listaLogros_objetos, i);
        
        if (aux_objetos[0])
        {
            draw_sprite_ext(aux_objetos[4], 0, __view_get(0, 0) + 230, __view_get(1, 0) + 150 + (90 * i), 1, 1, 0, c_blue, 1);
            draw_text(__view_get(0, 0) + 290, __view_get(1, 0) + 130 + (90 * i), aux_objetos[2]);
        }
        else
        {
            draw_sprite(spr_cuadro_item, 0, __view_get(0, 0) + 230, __view_get(1, 0) + 150 + (90 * i));
            draw_text(__view_get(0, 0) + 290, __view_get(1, 0) + 130 + (90 * i), string_hash_to_newline("---------------"));
        }
    }
}

if (subMenu == "florafauna")
{
    for (var k = 0; k < ds_list_size(listaLogros_florafauna); k++)
    {
        var posLista_logros = ds_list_find_value(listaLogros_florafauna, i);
        
        if (!posLista_logros)
        {
            draw_text(__view_get(0, 0) + 290, __view_get(1, 0) + 130 + (90 * k), string_hash_to_newline("---------------"));
            draw_sprite(spr_cuadro_item, 0, __view_get(0, 0) + 230, __view_get(1, 0) + 150 + (90 * k));
        }
    }
}
}
