function scr_menu() {
// Se elige por el nombre de la opción (menu[] de obj_pause), no por su número
switch (menu[posCursor])
{
    case "Inventario":
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
    
    case "Ver cartas":
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
                scr_text("Ups, se me olvido de que no tienes ninguna carta, porque no fabricamos una#con los materiales recogidos, ve a la opcion 'Creación'", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
            else
                scr_text("No tienes ninguna carta, porque no consigues o fabricas algunas?", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
        }
        
        break;
    
    case "Creación":
        if (ds_list_size(obj_morral.morral) != 0)
        {
            posCursor = 0;
            menuOptions = "Creación";
            subCreacion = "cartas";
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
    
    case "Guardar":
        posCursor = 0;
        menuOptions = "Guardar";
        io_clear();
        break;
    
    case "Salir al menú":
        // Cuadro de confirmación (obj_confirmar, estado "salir"): con Sí vuelve al menú de título
        if (!instance_exists(obj_confirmar))
        {
            with (instance_create_depth(camera_get_view_x(view_camera[0]) + 660, camera_get_view_y(view_camera[0]) + 368, -10000, obj_confirmar))
                estado = "salir";
        }
        
        io_clear();
        break;
    
    case "Memorin":
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
