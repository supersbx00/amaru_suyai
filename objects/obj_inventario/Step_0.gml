if (global.numero >= MOMIA_PASO_MADEROS)
{
    if (scr_momia_presiona() && click == 1 && mouse_x < 80 && mouse_y > 0 && mouse_y < ((array_length(inventario) * 64) + 67))
    {
        var posicion_h = (mouse_y - 16) div 67;
        click = 0;
        alarm[0] = 30;
        
        // Paso de la arcilla: el terrón queda en la mano para untarlo (obj_arcilla_untar), no se arrastra como pieza
        if (global.numero == MOMIA_PASO_ARCILLA && inventario[posicion_h] == 9 && instance_exists(obj_arcilla_untar))
        {
            inventario[posicion_h] = 0;
            obj_arcilla_untar.en_mano = 1;
        }
        else
        {
            mouse_arrastrar = inventario[posicion_h];
            guardar_h = posicion_h;
            inventario[posicion_h] = 0;
        }
    }
    
    if (mouse_arrastrar > 0)
    {
        if (!scr_momia_mantiene())
        {
            if ((objetofuera == -4 || objetofuera.snap == 0) && (objetofuerados == -4 || objetofuerados.snap == 0) && (objetofueratres == -4 || objetofueratres.snap == 0))
            {
                var posicion_h;
                
                if (mouse_x < 80 && mouse_y < ((array_length(inventario) * 16) + 67) && mouse_y > 0)
                    posicion_h = (mouse_y - 16) div 67;
                else
                    posicion_h = guardar_h;
                
                if (inventario[posicion_h] == 0)
                {
                    inventario[posicion_h] = mouse_arrastrar;
                    mouse_arrastrar = 0;
                }
                else
                {
                    for (var i = 0; i < array_length(inventario); i++)
                    {
                        if (inventario[i] == 0)
                        {
                            inventario[i] = mouse_arrastrar;
                            mouse_arrastrar = 0;
                            break;
                        }
                    }
                }
            }
            
            if (objetofuera != -4 && objetofuera.snap == 0)
            {
                with (objetofuera)
                    instance_destroy();
                
                objetofuera = -4;
            }
        }
        
        if (mouse_x > 80 && objetofuera == -4)
        {
            objetofuera = instance_create(mouse_x, mouse_y, obj_pieza);
            
            // El objeto 13 no es pieza: queda con el sprite de obj_pieza, como antes
            var piezas = scr_momia_piezas();

            if (mouse_arrastrar < array_length(piezas))
                objetofuera.sprite_index = piezas[mouse_arrastrar];

            // Profundidad de la pieza en la mano; las demás usan la de obj_pieza
            switch (mouse_arrastrar)
            {
                case 8: objetofuera.depth = -103; break;
                case 9: objetofuera.depth = -106; break;
                case 10: objetofuera.depth = -108; break;
                case 11: objetofuera.depth = -110; break;
                case 12: objetofuera.depth = -112; break;
            }
        }
        
        if (mouse_x < 80 && mouse_y < ((array_length(inventario) * 67) + 16) && mouse_y > 0 && objetofuera != -4)
        {
            with (objetofuera)
                instance_destroy();
            
            objetofuera = -4;
        }
        
        if (mouse_arrastrar > 0 && !scr_momia_mantiene())
        {
            // Pieza puesta en su lugar: gasta su pieza fabricada del morral (scr_momia_materiales)
            scr_momia_cobrar(mouse_arrastrar);
            mouse_arrastrar = 0;
            objetofuera = -4;
            global.controlsnap += 1;
        }
    }
}
