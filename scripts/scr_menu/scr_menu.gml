function scr_menu() {
switch (posCursor)
{
    case 0:
        if (ds_list_size(obj_morral.morral) > 0)
        {
            posCursor = 0;
            menuOptions = "Inventario";
            io_clear();
        }
        else
        {
            if (instance_exists(obj_text))
            {
                with (obj_text)
                    instance_destroy();
            }
            
            warningMessage = 1;
            scr_text("No tienes ningun material, porque no buscas algunos?", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
        }
        
        break;
    
    case 1:
        if (ds_list_size(obj_morral.morralCards) > 0)
        {
            posCursor = 0;
            menuOptions = "Editar mazo";
            menuPrincipal = 0;
            menuCartas = 1;
            io_clear();
        }
        else
        {
            if (instance_exists(obj_text))
            {
                with (obj_text)
                    instance_destroy();
            }
            
            warningMessage = 1;
            
            if (instance_exists(obj_control_tutorial))
                scr_text("Ups, se me olvido de que no tienes ninguna carta, porque no fabricamos una#con los materiales recogidos, ve a la opcion 'Recetas'", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
            else
                scr_text("No tienes ninguna carta, porque no consigues o fabricas algunas?", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
        }
        
        break;
    
    case 2:
        if (ds_list_size(obj_morral.morral) != 0)
        {
            posCursor = 0;
            menuOptions = "Recetas";
            io_clear();
        }
        else
        {
            if (instance_exists(obj_text))
            {
                with (obj_text)
                    instance_destroy();
            }
            
            warningMessage = 1;
            scr_text("No tienes ningun material, como piensas fabricar cartas??", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
        }
        
        break;
    
    case 3:
        posCursor = 0;
        menuOptions = "Guardar";
        io_clear();
        break;
    
    case 4:
        posCursor = 0;
        menuOptions = "Memorin";
        script_execute(scr_actualiza_listaLogros);
        io_clear();
        break;
    
    default:
        if (instance_exists(obj_text))
        {
            with (obj_text)
                instance_destroy();
        }
        
        warningMessage = 1;
        scr_text("ERROR", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
        break;
}
}
