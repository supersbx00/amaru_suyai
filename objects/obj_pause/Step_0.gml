depth = -1;
clamp(posCursor, 0, 26);
push_sabias = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_select);
k_up = keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(0, gp_padu);
k_down = keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(0, gp_padd);
push_pause = keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_start);
push_int = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);
push_out = keyboard_check_pressed(ord("X")) || gamepad_button_check_pressed(0, gp_face4);
push_left = keyboard_check_pressed(vk_left) || gamepad_button_check_pressed(0, gp_padl);
push_right = keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(0, gp_padr);
push_lb = keyboard_check_pressed(ord("A")) || gamepad_button_check_pressed(0, gp_shoulderl);
push_rb = keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(0, gp_shoulderr);
scr_pause_mouse();

if (push_sabias && global.enable_battle == 0 && global.pause == 0 && !instance_exists(obj_dialogo) && !instance_exists(obj_control_tutorial))
{
    if (!instance_exists(obj_popup_ayuda))
        instance_create(__view_get(0, 0), __view_get(1, 0), obj_sabias);
}

if (push_pause)
    script_execute(scr_pause_control);

if (push_int)
    script_execute(scr_pause_avance);

if (push_out)
    script_execute(scr_pause_back);

if (push_rb)
    script_execute(scr_pause_rb);

if (push_lb)
    script_execute(scr_pause_lb);

if (!global.pause)
    exit;

var move = 0;

if (menuOptions == "Principal" && !instance_exists(obj_popUp))
{
    move = 0;
    move -= max(k_up, 0);
    move += max(k_down, 0);
    
    if (move != 0)
    {
        posCursor += move;
        
        if (instance_exists(obj_control_tutorial))
        {
            if (obj_control_tutorial.paso == 9)
                posCursor = 0;
            
            if (obj_control_tutorial.paso == 10)
            {
                if (posCursor < 0)
                    posCursor = 1;
                
                if (posCursor > 1)
                    posCursor = 0;
            }
            
            if (obj_control_tutorial.paso == 11)
            {
                if (posCursor < 0)
                    posCursor = 2;
                
                if (posCursor > 2)
                    posCursor = 0;
            }
            
            if (obj_control_tutorial.paso >= 12)
            {
                if (posCursor < 0)
                    posCursor = 1;
                
                if (posCursor > 1)
                    posCursor = 0;
            }
        }
        else
        {
            if (posCursor < 0)
                posCursor = array_length(menu) - 1;
            
            if (posCursor > (array_length(menu) - 1))
                posCursor = 0;
        }
    }
    
    var push = 0;
    push = max(push_int, 0);
    
    if (push && !instance_exists(obj_popUp))
        scr_menu();
}

move = 0;

if (menuOptions == "Ver cartas")
{
    move -= max(k_up, 0);
    move += max(k_down, 0);
    
    if (move != 0)
        posCursor = 0;
    
    var push = undefined;
    push = max(push_int, 0);
    
    if (push)
        scr_menuDeck();
}

if (menuOptions == "Editar mazo" || menuOptions == "Borrar cartas")
{
    if (addRemove_card == "add")
    {
        if (editDeck_phase == "cardInventory")
        {
            move -= max(push_left, 0);
            move += max(push_right, 0);
            move -= max(k_up * 3, 0);
            move += max(k_down * 3, 0);
            
            if (move != 0)
            {
                posCursor += move;
                
                if (posCursor < 0)
                    posCursor = ds_list_size(obj_morral.morralCards) - 1;
                
                if (posCursor > (ds_list_size(obj_morral.morralCards) - 1))
                    posCursor = 0;
            }
            
            select = ds_list_find_value(obj_morral.morralCards, posCursor);
        }
        
        if (editDeck_phase == "cardCopy")
        {
            move -= max(k_up, 0);
            move += max(k_down, 0);
            move -= max(push_left * 5, 0);
            move += max(push_right * 5, 0);
            
            if (move != 0)
            {
                posCursor += move;
                
                if (posCursor < 0)
                    posCursor = 9;
                
                if (posCursor > 9)
                    posCursor = 0;
                
                calculoCP = scr_valorCP_total(select);
            }
        }
        
        if (editDeck_phase == "cardDeck")
        {
            if (menuOptions == "Editar mazo")
            {
                move -= max(push_left, 0);
                move += max(push_right, 0);
                move -= max(k_up * 3, 0);
                move += max(k_down * 3, 0);
                
                if (move != 0)
                {
                    posCursor += move;
                    script_execute(scr_controlVisor);
                }
            }
            else
            {
                auxInventory = ds_list_find_value(obj_morral.morralCards, posCursor);
                auxInventory_copy = auxInventory[2];
            }
        }
    }
    else
    {
        move -= max(push_left, 0);
        move += max(push_right, 0);
        move -= max(k_up * 3, 0);
        move += max(k_down * 3, 0);
        
        if (move != 0)
        {
            posCursor += move;
            script_execute(scr_controlVisor);
            var listaCartas = obj_morral.mazo_seleccionado[2];
            
            if (move < 0 || posCursor < 0)
            {
                posCursor = 0;
                move = 0;
            }
            
            var cpCartaMazo = ds_list_find_value(listaCartas, posCursor);
            calculoCP = cpCartaMazo[4];
        }
        
        select = ds_list_find_value(obj_morral.mazo_seleccionado[2], posCursor);
    }
}

if ((menuOptions == "Editar mazo" && editDeck_phase == "cardCopy") || menuOptions == "Borrar cartas")
{
    if (k_up || k_down || push_left || push_right)
        calculoCP = scr_valorCP_total(select);
}

if (menuOptions == "Equipar mazo" || menuOptions == "Limpiar mazo" || menuOptions == "Renombrar mazo")
{
    move = 0;
    move -= max(push_left, 0);
    move += max(push_right, 0);
    
    if (move != 0)
    {
        posCursor += move;
        
        if (posCursor < 0)
            posCursor = 2;
        
        if (posCursor > 2)
            posCursor = 0;
    }
    
    var push = 0;
    push = max(push_int, 0);
    
    if (push)
    {
        io_clear();
        
        switch (menuOptions)
        {
            case "Equipar mazo":
                scr_equipDeck();
                break;
            
            case "Limpiar mazo":
                scr_cleanDeck();
                break;
            
            case "Renombrar mazo":
                scr_renameDeck();
                break;
            
            default:
                show_debug_message("ERROR, como llegaste aqui??");
        }
    }
}

if (menuOptions == "Inventario")
{
    move -= max(push_left, 0);
    move += max(push_right, 0);
    move -= max(k_up * 4, 0);
    move += max(k_down * 4, 0);
    
    if (move != 0)
    {
        posCursor += move;
        
        if (posCursor < 0)
            posCursor = ds_list_size(obj_morral.morral) - 1;
        
        if (posCursor > (ds_list_size(obj_morral.morral) - 1))
            posCursor = 0;
    }
    
    select = ds_list_find_value(obj_morral.morral, posCursor);
}

if (menuOptions == "Recetas")
{
    move -= max(k_up, 0);
    move += max(k_down, 0);
    
    if (!readyConstruct)
    {
        if (move != 0)
        {
            posCursor += move;
            
            if (!instance_exists(obj_control_tutorial))
            {
                if (posCursor < 0)
                    posCursor = ds_list_size(obj_morral.recipeBook) - 1;
                
                if (posCursor > (ds_list_size(obj_morral.recipeBook) - 1))
                    posCursor = 0;
            }
            else
            {
                posCursor = 0;
            }
        }
    }
    
    select = ds_list_find_value(obj_morral.recipeBook, posCursor);
}

if (menuOptions == "Memorin")
{
    move -= max(k_up, 0);
    move += max(k_down, 0);
    
    if (push_right)
    {
        posCursor = 0;
        visorRange_min_diario = 0;
        visorRange_max_diario = 5;
        
        if (subMenu == "personas")
            subMenu = "objetos";
        else if (subMenu == "objetos")
            subMenu = "florafauna";
        else if (subMenu == "florafauna")
            subMenu = "personas";
    }
    
    if (push_left)
    {
        posCursor = 0;
        visorRange_min_diario = 0;
        visorRange_max_diario = 5;
        
        if (subMenu == "personas")
            subMenu = "florafauna";
        else if (subMenu == "florafauna")
            subMenu = "objetos";
        else if (subMenu == "objetos")
            subMenu = "personas";
    }
    
    if (move != 0)
    {
        posCursor += move;
        script_execute(scr_controlVisor_diario);
        
        if (subMenu == "personas")
        {
            if (posCursor < 0)
                posCursor = ds_list_size(listaLogros_personas) - 1;
            
            if (posCursor > (ds_list_size(listaLogros_personas) - 1))
                posCursor = 0;
        }
        
        if (subMenu == "objetos")
        {
            if (posCursor < 0)
                posCursor = ds_list_size(listaLogros_objetos) - 1;
            
            if (posCursor > (ds_list_size(listaLogros_objetos) - 1))
                posCursor = 0;
        }
        
        if (subMenu == "florafauna")
        {
            if (posCursor < 0)
                posCursor = ds_list_size(listaLogros_florafauna) - 1;
            
            if (posCursor > (ds_list_size(listaLogros_florafauna) - 1))
                posCursor = 0;
        }
    }
    
    if (subMenu == "personas")
        select = ds_list_find_value(listaLogros_personas, posCursor);
    
    if (subMenu == "objetos")
        select = ds_list_find_value(listaLogros_objetos, posCursor);
    
    if (subMenu == "florafauna")
        select = ds_list_find_value(listaLogros_florafauna, posCursor);
}

if ((menuOptions == "Principal" || menuOptions == "Ver Cartas") && (k_up || k_down))
    warningMessage = 0;

if (push_int && (menuOptions == "Principal" || menuOptions == "Ver Cartas"))
    warningMessage = 1;

if (real(image_index) >= 5)
{
    image_speed = 0;
    image_index = 6;
}

if (menuOptions == "Guardar")
{
    // Modo prueba ("Momificar"): no se escribe nada en disco
    if (!global.modo_prueba)
    {
        script_execute(scr_guardar_item);
        script_execute(scr_guardar_cartas);
        script_execute(scr_guardar_mazo);
        script_execute(scr_guardar_cuarto);
        script_execute(scr_guardar_logros);
        script_execute(scr_guardar_recetas);
        script_execute(scr_guardar_datos);
        ini_open("datosJuego.ini");
        ini_write_real("puntaje jugador", "valor", global.puntaje_total_descrasheo);
        ini_close();

        // La copia en "partida/" es la partida guardada (empezar de nuevo no la toca)
        scr_partida_respaldar();

        with (instance_create(__view_get(0, 0) + (__view_get(2, 0) / 2), __view_get(1, 0) + (__view_get(3, 0) / 2), obj_popUp))
            valorTexto = "guardar";
    }
    
    menuOptions = "Principal";
}
