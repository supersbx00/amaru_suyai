function scr_pause_avance() {
var auxInventory_copy;

if (menuOptions == "Editar mazo" || menuOptions == "Borrar cartas")
{
    if (addRemove_card == "add")
    {
        if (editDeck_phase == "cardDeck" && menuOptions == "Editar mazo")
        {
            var auxEmpty_space = ds_list_find_value(obj_morral.mazo_seleccionado[2], posCursor);
            
            if (auxEmpty_space[0] == 13 && saveType >= 0 && saveType < ds_list_size(obj_morral.morralCards))
            {
                // Se lee la carta desde el inventario (no desde select): con copy-on-write select puede quedar desactualizado
                var auxData_card = ds_list_find_value(obj_morral.morralCards, saveType);
                var auxData_copys = auxData_card[2];

                if (instance_exists(obj_text))
                {
                    with (obj_text)
                        instance_destroy();
                }

                if (auxData_copys[saveValue] > 0)
                {
                    with (instance_create(x, y, obj_card))
                    {
                        data_card_deck[0] = auxData_card[0];
                        data_card_deck[1] = obj_pause.saveValue;
                        data_card_deck[2] = obj_pause.saveValue;
                        data_card_deck[3] = auxData_card[3];
                        data_card_deck[4] = obj_pause.calculoCP;
                        data_card_deck[5] = auxData_card[5];
                        data_card_deck[6] = auxData_card[6];

                        if ((data_card_deck[4] + obj_morral.mazo_seleccionado[3]) <= obj_morral.cp_limit)
                        {
                            ds_list_replace(obj_morral.mazo_seleccionado[2], obj_pause.posCursor, data_card_deck);
                            obj_morral.mazo[4, obj_morral.mazo_seleccionado[0]] += 1;
                            obj_morral.cantidadCartas -= 1;
                            obj_morral.mazo[2, obj_morral.mazo_seleccionado[0]] += data_card_deck[4];
                            var auxInventory = auxData_card;
                            var auxInventory_copys = auxInventory[2];
                            auxInventory_copys[obj_pause.saveValue] -= 1;
                            auxInventory[2] = auxInventory_copys;
                            ds_list_replace(obj_morral.morralCards, obj_pause.saveType, auxInventory);
                            obj_pause.select = auxInventory;
                        }
                        else
                        {
                            scr_text("No se puede agregar, limite de CP alcanzado", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 70);
                        }

                        instance_destroy();
                    }
                }
                else
                {
                    scr_text("No quedan copias de esa carta con ese valor", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 70);
                }
            }

            editDeck_phase = "cardInventory";
            posCursor = saveType;
            io_clear();
            // Termina la pulsación aquí para no caer al bloque "cardInventory" con datos de esta misma pulsación
            exit;
        }
        
        if (editDeck_phase == "cardCopy")
        {
            var auxInventory = select;
            auxInventory_copy = auxInventory[2];
            
            if (auxInventory_copy[posCursor] > 0)
            {
                saveValue = posCursor;
                editDeck_phase = "cardDeck";
                
                if (instance_exists(obj_text))
                {
                    with (obj_text)
                        instance_destroy();
                }
                
                for (var search = 0; search <= 26; search++)
                {
                    aux_mazoSeleccionado = obj_morral.mazo_seleccionado[2];
                    verifica_posVacia = ds_list_find_value(aux_mazoSeleccionado, search);
                    
                    if (verifica_posVacia[3] == "No Type")
                    {
                        posCursor = search;
                        search = 28;
                    }
                    
                    scr_controlVisor();
                }
            }
            else
            {
                scr_text("No se tienen cartas con ese valor", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 70);
            }
        }
        
        if (editDeck_phase == "cardInventory")
        {
            var verifica_copias = select[2];
            var no_zero = 0;
            var pos_no_zero = 0;
            
            for (var q = 0; q < 10; q++)
            {
                if (verifica_copias[q] != 0)
                {
                    no_zero = 1;
                    pos_no_zero = q;
                    q = 11;
                }
            }
            
            if (no_zero)
            {
                editDeck_phase = "cardCopy";
                
                if (instance_exists(obj_text))
                {
                    with (obj_text)
                        instance_destroy();
                }
                
                saveType = posCursor;
                posCursor = pos_no_zero;
                calculoCP = scr_valorCP_total(select);
            }
            else
            {
                posCursor = 0;
            }
        }
    }
    else if (obj_morral.mazo_seleccionado[4] > 5)
    {
        var auxRemove_card = ds_list_find_value(obj_morral.mazo_seleccionado[2], posCursor);
        
        for (var i = 0; i < ds_list_size(obj_morral.morralCards); i++)
        {
            var auxCompare = ds_list_find_value(obj_morral.morralCards, i);
            
            if (auxRemove_card[0] == auxCompare[0])
            {
                var auxCompare_array = auxCompare[2];
                auxCompare_array[auxRemove_card[2]] += 1;
                auxCompare[2] = auxCompare_array;
                ds_list_replace(obj_morral.morralCards, i, auxCompare);
                obj_morral.mazo[2, obj_morral.mazo_seleccionado[0]] -= auxRemove_card[4];
                obj_morral.mazo[4, obj_morral.mazo_seleccionado[0]] -= 1;
                ds_list_replace(obj_morral.mazo_seleccionado[2], posCursor, obj_morral.noCard);
                obj_morral.cantidadCartas += 1;
                i = 1000;
            }
        }
        
        for (var search = 0; search <= 26; search++)
        {
            aux_mazoSeleccionado = obj_morral.mazo_seleccionado[2];
            verifica_posVacia = ds_list_find_value(aux_mazoSeleccionado, search);
            
            if (verifica_posVacia[3] != "No Type")
            {
                posCursor = search;
                search = 28;
            }
            
            scr_controlVisor();
        }
    }
    else
    {
        show_debug_message("No puedes seguir sacando cartas ya que tienes el minimo de cartas en el mazo (5)");
    }
}

if (menuOptions == "Borrar cartas")
{
    if (editDeck_phase == "cardDeck")
    {
        if (show_question("¿Estas seguro de querer borrar esta carta?"))
        {
            auxInventory_copy[saveValue] -= 1;
            var auxInventory;
            auxInventory[2] = auxInventory_copy;
            ds_list_replace(obj_morral.morralCards, saveType, auxInventory);
            obj_morral.cantidadCartas -= 1;
        }
        
        var verifica_copias = select[2];
        var no_zero = 0;
        var pos_no_zero = 0;
        
        for (var q = 0; q < 10; q++)
        {
            if (verifica_copias[q] != 0)
            {
                no_zero = 1;
                pos_no_zero = q;
                q = 11;
            }
        }
        
        if (no_zero)
        {
            editDeck_phase = "cardCopy";
            saveType = posCursor;
            posCursor = pos_no_zero;
            calculoCP = scr_valorCP_total(select);
        }
        else
        {
            editDeck_phase = "cardInventory";
            posCursor = 0;
        }
    }
}

if (menuOptions == "Recetas")
{
    if (select != undefined && select[10] && obj_morral.cantidadCartas < obj_morral.limite_inventario)
        readyConstruct = 1;
    
    if (readyConstruct)
    {
        var materialTrue = 0;
        var guardaMaterial = ds_list_create();
        var guardaPos = ds_list_create();
        
        for (var i = 1; i < 4; i++)
        {
            if (select[i] != "No material")
            {
                materialTrue += 1;
                
                for (var j = 0; j < ds_list_size(obj_morral.morral); j++)
                {
                    var dataOut = ds_list_find_value(obj_morral.morral, j);
                    
                    if (dataOut[1] == select[i])
                    {
                        ds_list_add(guardaMaterial, dataOut);
                        
                        if (dataOut[3] >= real(select[i + 3]))
                        {
                            ds_list_add(guardaPos, j);
                            j = ds_list_size(obj_morral.morral) + 1;
                        }
                        else
                        {
                            var faltantes = real(select[i + 3]) - dataOut[3];
                            
                            if (instance_exists(obj_text))
                            {
                                with (obj_text)
                                    instance_destroy();
                            }
                            
                            readyConstruct = 0;
                        }
                    }
                }
            }
        }
        
        if ((materialTrue != 0 && ds_list_size(guardaMaterial) != 0) && materialTrue == ds_list_size(guardaPos))
        {
            var k = 1;
            var dataOut_aux = undefined;
            var pos_aux = undefined;
            
            repeat (ds_list_size(guardaMaterial))
            {
                dataOut_aux = ds_list_find_value(guardaMaterial, k - 1);
                pos_aux = ds_list_find_value(guardaPos, k - 1);
                dataOut_aux[3] -= real(select[k + 3]);
                obj_morral.cantidadMaterial -= real(select[k + 3]);
                ds_list_replace(obj_morral.morral, pos_aux, dataOut_aux);
                k++;
            }
            
            with (instance_create(x, y, obj_card))
            {
                card_morral[0] = obj_pause.select[0];
                
                if (!instance_exists(obj_control_tutorial))
                    card_morral[1] = irandom_range(1, 9);
                else
                    card_morral[1] = 8;
                
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
            
            if (instance_exists(obj_text))
            {
                with (obj_text)
                    instance_destroy();
            }
            
            with (instance_create(__view_get(0, 0) + (__view_get(2, 0) / 2), __view_get(1, 0) + (__view_get(3, 0) / 2), obj_popUp))
                valorTexto = "material creado";
            
            readyConstruct = 0;
        }
        else if (materialTrue > ds_list_size(guardaMaterial))
        {
            if (instance_exists(obj_text))
            {
                with (obj_text)
                    instance_destroy();
            }
            
            readyConstruct = 0;
        }
        
        for (var a = 0; a < ds_list_size(obj_morral.morral); a++)
        {
            var aux_remove = ds_list_find_value(obj_morral.morral, a);
            
            if (aux_remove[3] == 0)
            {
                ds_list_delete(obj_morral.morral, a);
                a--;
            }
        }
    }
}
}
