if (global.numero >= 7)
{
    if (mouse_check_button_pressed(mb_left) && click == 1 && mouse_x < 80 && mouse_y > 0 && mouse_y < ((array_length_1d(inventario) * 64) + 67))
    {
        var posicion_h = (mouse_y - 16) div 67;
        click = 0;
        mouse_arrastrar = inventario[posicion_h];
        show_debug_message("el mouse es");
        show_debug_message("la posición es" + string(posicion_h));
        alarm[0] = 30;
        guardar_h = posicion_h;
        inventario[posicion_h] = 0;
    }
    
    if (mouse_arrastrar > 0)
    {
        if (!mouse_check_button(mb_left))
        {
            if ((objetofuera == -4 || objetofuera.snap == 0) && (objetofuerados == -4 || objetofuerados.snap == 0) && (objetofueratres == -4 || objetofueratres.snap == 0))
            {
                var posicion_h;
                
                if (mouse_x < 80 && mouse_y < ((array_length_1d(inventario) * 16) + 67) && mouse_y > 0)
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
                    for (var i = 0; i < array_length_1d(inventario); i++)
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
                show_debug_message("objetofuera=" + string(objetofuera));
            }
        }
        
        if (mouse_x > 80 && objetofuera == -4)
        {
            objetofuera = instance_create(mouse_x, mouse_y, obj_pieza);
            
            switch (mouse_arrastrar)
            {
                case 1:
                    objetofuera.sprite_index = spr_maderabrazoderecho;
                    break;
                
                case 2:
                    objetofuera.sprite_index = spr_maderohombro;
                    break;
                
                case 3:
                    objetofuera.sprite_index = spr_maderabrazoizquierdo;
                    break;
                
                case 4:
                    objetofuera.sprite_index = spr_maderacadera;
                    break;
                
                case 5:
                    objetofuera.sprite_index = spr_maderapiernaderecha;
                    break;
                
                case 6:
                    objetofuera.sprite_index = spr_maderapiernaizquierda;
                    break;
                
                case 7:
                    objetofuera.sprite_index = spr_paja;
                    break;
                
                case 8:
                    objetofuera.sprite_index = spr_pajacabeza;
                    objetofuera.depth = -103;
                    break;
                
                case 9:
                    objetofuera.sprite_index = spr_barro;
                    objetofuera.depth = -106;
                    break;
                
                case 10:
                    objetofuera.sprite_index = spr_faldellin;
                    objetofuera.depth = -108;
                    break;
                
                case 11:
                    objetofuera.sprite_index = spr_pelo;
                    objetofuera.depth = -110;
                    break;
                
                case 12:
                    objetofuera.sprite_index = spr_cara;
                    objetofuera.depth = -112;
                    break;
            }
            
            show_debug_message("objetofuera=" + string(objetofuera));
        }
        
        if (mouse_x < 80 && mouse_y < ((array_length_1d(inventario) * 67) + 16) && mouse_y > 0 && objetofuera != -4)
        {
            with (objetofuera)
                instance_destroy();
            
            objetofuera = -4;
        }
        
        if (mouse_arrastrar > 0 && !mouse_check_button(mb_left))
        {
            mouse_arrastrar = 0;
            objetofuera = -4;
            global.controlsnap += 1;
        }
    }
}
