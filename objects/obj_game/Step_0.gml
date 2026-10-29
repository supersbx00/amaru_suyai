var menuOptions_save = undefined;

if (gamepad_is_connected(0))
{
    gamepad_set_axis_deadzone(0, 0.7);
    global.gp = 1;
}

if (instance_exists(obj_text))
{
    if (((keyboard_check_pressed(ord("X")) || gamepad_button_check(0, gp_face4) || keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right)) && obj_pause.menuOptions != "Principal") || keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down) || keyboard_check_pressed(vk_space))
    {
        with (obj_text)
            instance_destroy();
    }
}

if (room_get_name(room) != "rm_menu")
{
    global.tiempo_juego += 1;
    segJugados += 1;
    
    if (segJugados > 1800)
    {
        segJugados = 0;
        minJugados += 1;
    }
    
    if (minJugados > 60)
    {
        minJugados = 0;
        hrsJugadas += 1;
    }
    
    totalJugado[0] = hrsJugadas;
    totalJugado[1] = minJugados;
}

// Materiales que aparecen con el tiempo en las salas del mapa (atajo T)
if (instance_exists(obj_player))
    scr_materiales_aparecer();

var array_layers = layer_get_all();

if (instance_exists(obj_tutorial_popup_2))
{
    for (var p = 0; p < array_length(layer_get_all()); p++)
        layer_set_visible(array_layers[p], 0);
}
else
{
    for (var p = 0; p < array_length(layer_get_all()); p++)
        layer_set_visible(array_layers[p], 1);
}

if (instance_exists(obj_pause))
{
    array_layers = layer_get_all();
    
    if (global.pause == 1)
    {
        for (var p = 0; p < array_length(layer_get_all()); p++)
            layer_set_visible(array_layers[p], 0);
    }
    else if (instance_exists(obj_sabias))
    {
        for (var p = 0; p < array_length(layer_get_all()); p++)
            layer_set_visible(array_layers[p], 0);
    }
    else
    {
        for (var p = 0; p < array_length(layer_get_all()); p++)
            layer_set_visible(array_layers[p], 1);
    }
}

if (keyboard_check(ord("1")) && keyboard_check(ord("U")) && keyboard_check(ord("P")))
    show_message("PUNTAJE DEL JUGADOR : " + string(global.puntaje_total_descrasheo) + "#" + "JEFES DERROTADOS : #" + "Espiritu de la Luna : " + string(global.espiritu_luna) + "#" + "Espiritu del Agua : " + string(global.espiritu_agua) + "#" + "Espiritu del Fuego : " + string(global.espiritu_fuego) + "#" + "Khoru : " + string(global.khoru) + "#" + "ROOM ACTUAL : " + string(room_get_name(room)) + "#" + "Puntaje en caso de crasheo : " + string(global.puntaje_total));

if (keyboard_check(ord("R")) && keyboard_check(ord("E")) && keyboard_check(ord("P")))
    action_restart_game();

if (room == rm_menu)
{
    if (keyboard_check(ord("W")) && keyboard_check(ord("H")) && keyboard_check_pressed(ord("A")))
    {
        global.puntaje_total_descrasheo += 15;
        global.materiales_recogidos = {}; // partida nueva: todos los materiales disponibles
        script_execute(scr_recetas);
        script_execute(scr_lista_logros);
        global.escena = 0;
        temp[0] = 1184;
        temp[1] = 413;
        
        if (instance_exists(obj_player))
        {
            with (obj_player)
            {
                sprite_index = spr_amaru_stand_rightTop;
                image_index = -1;
            }
        }
        
        temp[2] = 11;
        ds_list_insert(obj_game.cambio_escena, 0, temp);
        scr_go_to_room(temp[2]);
        
        for (i = 0; i < 5; i++)
        {
            with (instance_create(x, y, obj_card))
            {
                randomize();
                card_morral[0] = 5;
                card_morral[1] = irandom_range(5, 8);
                card_morral[2] = card_morral[1];
                card_morral[3] = "No type";
                card_morral[4] = "No CP";
                card_morral[5] = "No name";
                card_morral[6] = "No description";
                scr_asignaValores_segunCarta();
                var cardExist = 0;
                
                for (var j = 0; j < ds_list_size(obj_morral.morralCards); j++)
                {
                    var inventoryCard = ds_list_find_value(obj_morral.morralCards, j);
                    
                    if (card_morral[5] == inventoryCard[5])
                    {
                        var copys_inventoryCard = inventoryCard[2];
                        copys_inventoryCard[card_morral[2]] += 1;
                        inventoryCard[2] = copys_inventoryCard;
                        ds_list_replace(obj_morral.morralCards, j, inventoryCard);
                        cardExist = 1;
                    }
                }
                
                if (!cardExist)
                {
                    data_card_inventory[0] = card_morral[0];
                    data_card_inventory[1] = card_morral[1];
                    var aux = 0;
                    
                    repeat (10)
                    {
                        copys[aux] = 0;
                        aux += 1;
                    }
                    
                    copys[card_morral[2]] += 1;
                    data_card_inventory[2] = copys;
                    data_card_inventory[3] = card_morral[3];
                    data_card_inventory[4] = card_morral[4];
                    data_card_inventory[5] = card_morral[5];
                    data_card_inventory[6] = card_morral[6];
                    ds_list_add(obj_morral.morralCards, data_card_inventory);
                }
                
                obj_morral.cantidadCartas += 1;
                instance_destroy();
            }
        }
    }
}

// Textos de ayuda del menú de pausa. Van en Step y no en Draw: durante la pausa se ocultan
// todas las capas (ver arriba), incluida la de obj_game, y su Draw deja de ejecutarse.
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
                    var textoPaso = undefined;
                    
                    // Paso 10 con "Inventario": el mismo texto que pone obj_pause/Draw_0, para que no compitan
                    if (obj_control_tutorial.paso == 10 && posCursor == 0)
                        textoPaso = "Ya podemos ver nuestras cartas!! ";
                    else if (obj_control_tutorial.paso == 12)
                        textoPaso = "¡Muy bien! Ahora entra a 'Ver cartas' para agregar#tu nueva carta al mazo";
                    else if (obj_control_tutorial.paso == 13 || obj_control_tutorial.paso == 14)
                        textoPaso = "¡Genial! Haz clic derecho para salir del menú";
                    
                    if (textoPaso != undefined)
                    {
                        // Si quedó un texto de otro paso u opción, se rehace con el del paso actual
                        if (instance_exists(obj_text) && obj_text.text != textoPaso)
                        {
                            with (obj_text)
                                instance_destroy();
                        }
                        
                        scr_text(textoPaso, 1, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                    }
                    else switch (posCursor)
                    {
                        case 0:
                            scr_text("En el inventario se guardan todos los materiales que has recogido durante tu aventura#Haz clic izquierdo para entrar", 1, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                            break;
                        
                        case 1:
                            scr_text("Aqui puedes ver las cartas que hayas conseguido o fabricado", 1, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                            break;
                        
                        case 2:
                            scr_text("En recetas puedes crear cartas con los materiales que hayas recogido", 1, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                            break;
                        
                        default:
                            scr_text("ERROR 404", 1, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                            break;
                    }
                }
            }
            else
            {
                switch (posCursor)
                {
                    case 0:
                        scr_text("En el inventario se guardan todos los materiales que has recogido durante tu aventura", 1, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                        break;
                    
                    case 1:
                        scr_text("Aqui puedes ver las cartas que hayas conseguido o fabricado", 1, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                        break;
                    
                    case 2:
                        scr_text("En recetas puedes crear cartas con los materiales que hayas recogido", 1, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                        break;
                    
                    case 3:
                        scr_text("Guarda tu partida para descansar un rato", 1, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                        break;
                    
                    case 4:
                        scr_text("Muestra informacion de cosas importantes con las que has interactuado", 1, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                        break;
                    
                    default:
                        scr_text("ERROR 404", 1, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
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
                        scr_text("Aqui puedes agregar y/o quitar cartas al mazo actual", 0.7, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                    else
                        scr_text("Agregaremos la carta construida al mazo actual, tenemos 3 mazos para crear estrategias,# pero eso lo hablaremos mas adelante", 0.7, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                    
                    break;
                
                case 1:
                    scr_text("Selecciona uno de los tres mazos que tienes a disposición", 0.7, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                    break;
                
                case 2:
                    scr_text("Retira todas las cartas del mazo seleccionado", 0.7, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                    break;
                
                case 3:
                    scr_text("Cambia el nombre de tus mazos para reconocerlos mas fácil", 0.7, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                    break;
                
                case 4:
                    scr_text("Borra las cartas que tengas de más o no necesites", 0.7, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                    break;
                
                default:
                    scr_text("ERROR 404", 0.7, __view_get(0, 0) + 594, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 56, 720, true);
                    break;
            }
        }
    }
}
