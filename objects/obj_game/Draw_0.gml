if (instance_exists(obj_pause))
{
    with (obj_pause)
    {
        if (menuOptions == "Principal")
        {
            if (instance_exists(obj_control_tutorial))
            {
                if (obj_control_tutorial.tutorialOn)
                {
                    switch (posCursor)
                    {
                        case 0:
                            scr_text("En el inventario se guardan todos los materiales que has recogido durante tu aventura#Para acceder a el solo debes presionar 'Z'", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                            break;
                        
                        case 1:
                            scr_text("Aqui puedes ver las cartas que hayas conseguido o fabricado", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                            break;
                        
                        case 2:
                            scr_text("En recetas puedes crear cartas con los materiales que hayas recogido", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                            break;
                        
                        default:
                            scr_text("ERROR 404", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                            break;
                    }
                }
            }
            else
            {
                switch (posCursor)
                {
                    case 0:
                        scr_text("En el inventario se guardan todos los materiales que has recogido durante tu aventura", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                        break;
                    
                    case 1:
                        scr_text("Aqui puedes ver las cartas que hayas conseguido o fabricado", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                        break;
                    
                    case 2:
                        scr_text("En recetas puedes crear cartas con los materiales que hayas recogido", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                        break;
                    
                    case 3:
                        scr_text("Guarda tu partida para descansar un rato", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                        break;
                    
                    case 4:
                        scr_text("Muestra informacion de cosas importantes con las que has interactuado", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                        break;
                    
                    default:
                        scr_text("ERROR 404", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                        break;
                }
            }
        }
    }
}

if (instance_exists(obj_pause))
{
    with (obj_pause)
    {
        if (menuOptions == "Ver cartas")
        {
            switch (posCursor)
            {
                case 0:
                    if (!instance_exists(obj_control_tutorial))
                        scr_text("Aqui puedes agregar y/o quitar cartas al mazo actual", 0.7, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                    else
                        scr_text("Agregaremos la carta construida al mazo actual, tenemos 3 mazos para crear estrategias,# pero eso lo hablaremos mas adelante", 0.7, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                    
                    break;
                
                case 1:
                    scr_text("Selecciona uno de los tres mazos que tienes a disposición", 0.7, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                    break;
                
                case 2:
                    scr_text("Retira todas las cartas del mazo seleccionado", 0.7, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                    break;
                
                case 3:
                    scr_text("Cambia el nombre de tus mazos para reconocerlos mas fácil", 0.7, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                    break;
                
                case 4:
                    scr_text("Borra las cartas que tengas de más o no necesites", 0.7, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                    break;
                
                default:
                    scr_text("ERROR 404", 0.7, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
                    break;
            }
        }
    }
}

if (instance_exists(obj_player))
{
    if (alpha != undefined)
    {
        if (alpha > 0)
        {
            if (alpha <= 1)
                upText += 1;
            
            upText = clamp(upText, 1, 32);
            alpha -= 0.05;
            draw_text_colour(obj_player.x, obj_player.y - 76 - upText, string_hash_to_newline(" + 1 " + string(nombreMaterial)), c_white, c_white, c_white, c_white, alpha);
        }
    }
}

draw_set_colour(c_black);
