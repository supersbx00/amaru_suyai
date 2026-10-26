if (!global.pause)
    exit;

draw_set_alpha(1);
draw_sprite(spr_bck_menu, 0, __view_get(0, 0), __view_get(1, 0));
draw_set_halign(fa_center);
draw_set_halign(fa_left);

if (menuOptions == "Principal")
{
    draw_set_color(c_white);
    
    if (instance_exists(obj_control_tutorial))
    {
        if (obj_control_tutorial.paso < 12)
        {
            for (var i = 0; i < (obj_control_tutorial.paso - 8); i++)
            {
                draw_sprite_ext(spr_maderuchaMenu, 1, __view_get(0, 0) + 136, __view_get(1, 0) + 32 + ((i + 1) * 60), 0.5, 0.5, 1, c_white, 1);
                draw_text(__view_get(0, 0) + 96, __view_get(1, 0) + 16 + ((i + 1) * 60), string_hash_to_newline(string(menu[i])));
            }
        }
        else
        {
            for (var i = 0; i < (array_length_1d(menu) - 2); i++)
            {
                draw_sprite_ext(spr_maderuchaMenu, 1, __view_get(0, 0) + 136, __view_get(1, 0) + 32 + ((i + 1) * 60), 0.5, 0.5, 1, c_white, 1);
                draw_text(__view_get(0, 0) + 96, __view_get(1, 0) + 16 + ((i + 1) * 60), string_hash_to_newline(string(menu[i])));
            }
        }
    }
    else
    {
        for (var i = 0; i < array_length_1d(menu); i++)
        {
            draw_sprite_ext(spr_maderuchaMenu, 1, __view_get(0, 0) + 136, __view_get(1, 0) + 32 + ((i + 1) * 60), 0.5, 0.5, 1, c_white, 1);
            draw_text(__view_get(0, 0) + 96, __view_get(1, 0) + 16 + ((i + 1) * 60), string_hash_to_newline(string(menu[i])));
        }
    }
}

if (menuOptions == "Principal")
    draw_sprite_ext(spr_titulo, 0, (__view_get(0, 0) + (__view_get(2, 0) / (4/3))) - 20, __view_get(1, 0) + 110, 1, 1, 0, c_white, 1);

if (menuOptions == "Inventario")
{
    draw_sprite(spr_inventarioTitulo, 1, __view_get(0, 0) + 100, __view_get(1, 0) + 120);
    draw_sprite(spr_inventarioBase, 1, __view_get(0, 0) + 100, __view_get(1, 0) + 126);
    draw_sprite(spr_inventarioCuadros, 1, __view_get(0, 0) + 144, __view_get(1, 0) + 220);
    draw_sprite(spr_inventarioDescripcion, 1, __view_get(0, 0) + 740, __view_get(1, 0) + 410);
}

if (menuOptions == "Inventario")
{
    draw_set_halign(fa_left);
    draw_set_font(description);
    draw_set_color(c_white);
    draw_text(__view_get(0, 0) + (__view_get(2, 0) / 2) + 130, __view_get(1, 0) + (__view_get(3, 0) / 2) + 40, string_hash_to_newline("Material: " + string(select[1])));
    draw_text(__view_get(0, 0) + (__view_get(2, 0) / 2) + 130, __view_get(1, 0) + (__view_get(3, 0) / 2) + 70, string_hash_to_newline("Descripcion: " + string(select[2])));
    draw_text(__view_get(0, 0) + (__view_get(2, 0) / 2) + 440, __view_get(1, 0) + (__view_get(3, 0) / 2) + 40, string_hash_to_newline("Cantidad: " + string(select[3])));
}

if (menuOptions == "Inventario")
{
    var posCarta = 0;
    
    for (var i = 0; i < round(obj_morral.limite_inventario / 4); i++)
    {
        for (var j = 0; j < 4; j++)
        {
            if (ds_list_size(obj_morral.morral) > 0)
            {
                var drawMaterial = ds_list_find_value(obj_morral.morral, posCarta);
                
                if (drawMaterial != undefined)
                {
                    draw_sprite(drawMaterial[0], 0, __view_get(0, 0) + 148 + (124 * j), __view_get(1, 0) + 250 + (130 * i));
                    posCarta += 1;
                }
                else
                {
                    i = round(obj_morral.limite_inventario / 4) + 100;
                }
            }
        }
    }
}

if (menuOptions == "Ver cartas")
{
    draw_set_alpha(1);
    draw_text(__view_get(2, 0) / 2, 30, string_hash_to_newline("Ver cartas"));
    draw_set_colour(c_white);
    draw_set_halign(fa_left);
    
    if (instance_exists(obj_control_tutorial))
    {
        for (var i = 0; i < 1; i++)
        {
            draw_sprite_ext(spr_maderuchaMenu, 1, __view_get(0, 0) + 136, __view_get(1, 0) + 32 + ((i + 1) * 60), 0.5, 0.5, 1, c_white, 1);
            draw_text(__view_get(0, 0) + 96, __view_get(1, 0) + 16 + ((i + 1) * 60), string_hash_to_newline(string(menuDeck[i])));
        }
    }
    else
    {
        draw_sprite_ext(spr_maderuchaMenu, 1, __view_get(0, 0) + 136, __view_get(1, 0) + 32 + 60, 0.5, 0.5, 1, c_white, 1);
        draw_text(__view_get(0, 0) + 96, __view_get(1, 0) + 16 + 60, string_hash_to_newline(string(menuDeck[0])));
        
        for (var i = 1; i < array_length_1d(menuDeck); i++)
            draw_sprite_ext(spr_proximamente, 1, __view_get(0, 0) + 136, __view_get(1, 0) + 32 + ((i + 1) * 60), 0.5, 0.5, 1, c_white, 1);
    }
}

if (menuOptions == "Editar mazo" || menuOptions == "Borrar cartas")
{
    var posCarta = 0;
    
    for (var i = 0; i < 3; i++)
    {
        for (var j = 0; j < 3; j++)
            draw_sprite_ext(spr_baseCarta, 0, __view_get(0, 0) + 98 + (106 * j), __view_get(1, 0) + 224 + (140 * i), 0.49, 0.49, 1, c_white, 1);
    }
    
    for (var i = 0; i < round(obj_morral.limite_inventario / 3); i++)
    {
        for (var j = 0; j < 3; j++)
        {
            if (ds_list_size(obj_morral.morralCards) > 0)
            {
                var drawCard = ds_list_find_value(obj_morral.morralCards, posCarta);
                
                if (drawCard != undefined)
                {
                    draw_sprite_ext(drawCard[0], 0, __view_get(0, 0) + 96 + (106 * j), __view_get(1, 0) + 224 + (140 * i), 1.5, 1.5, 1, c_white, 1);
                    posCarta += 1;
                }
                else
                {
                    i = round(obj_morral.limite_inventario / 3) + 100;
                }
            }
        }
    }
}

depth = -1;

if (menuOptions == "Editar mazo")
{
    var puntero = visorRange_min;
    clamp(puntero, visorRange_min, visorRange_max);
    
    for (var i = 0; i < 3; i++)
    {
        for (var j = 0; j < 3; j++)
        {
            var auxCardDeck = ds_list_find_value(obj_morral.mazo_seleccionado[2], puntero);
            
            if (auxCardDeck != undefined)
            {
                draw_sprite_ext(spr_baseCarta, 0, ((__view_get(0, 0) + __view_get(2, 0)) - 400) + (106 * j), __view_get(1, 0) + 224 + (140 * i), 0.5, 0.5, 1, c_white, 1);
                draw_sprite_ext(auxCardDeck[0], auxCardDeck[2], ((__view_get(0, 0) + __view_get(2, 0)) - 400) + (106 * j), __view_get(1, 0) + 224 + (140 * i), 1.5, 1.5, 1, c_white, 1);
                puntero++;
            }
            else
            {
                j = 4;
                i = 30;
            }
        }
    }
}

if (menuOptions == "Editar mazo" || menuOptions == "Borrar cartas")
{
    draw_set_font(general);
    draw_set_alpha(1);
    draw_text(__view_get(0, 0) + 128, __view_get(1, 0) + 32, string_hash_to_newline(string(menuOptions)));
    draw_text(__view_get(0, 0) + 96, __view_get(1, 0) + 138, string_hash_to_newline("Cartas en Inv: "));
    draw_text(__view_get(0, 0) + 96, __view_get(1, 0) + 160, string_hash_to_newline(string(obj_morral.cantidadCartas) + "/" + string(obj_morral.limite_inventario)));
    
    if (menuOptions == "Editar mazo")
    {
        draw_text(__view_get(0, 0) + 96, __view_get(1, 0) + 64, string_hash_to_newline("Mazo equipado: " + string(obj_morral.mazo_seleccionado[1])));
        draw_text(__view_get(0, 0) + (__view_get(2, 0) / 2) + 480, __view_get(1, 0) + 138, string_hash_to_newline("Cartas Deck: "));
        draw_text(__view_get(0, 0) + (__view_get(2, 0) / 2) + 480, __view_get(1, 0) + 160, string_hash_to_newline(string(obj_morral.mazo_seleccionado[4]) + "/" + string(obj_morral.deck_limit)));
        draw_text(__view_get(0, 0) + (__view_get(2, 0) / 2) + 300, __view_get(1, 0) + 138, string_hash_to_newline("CP Deck: "));
        draw_text(__view_get(0, 0) + (__view_get(2, 0) / 2) + 300, __view_get(1, 0) + 160, string_hash_to_newline(string(obj_morral.mazo_seleccionado[3]) + "/" + string(obj_morral.cp_limit)));
    }
}

if (menuOptions == "Editar mazo" || menuOptions == "Borrar cartas")
{
    draw_set_halign(fa_left);
    
    if (select != undefined)
    {
        draw_text((__view_get(0, 0) + (__view_get(2, 0) / 2)) - 10, __view_get(1, 0) + 192, string_hash_to_newline(string(select[5])));
        
        if (editDeck_phase == "cardInventory")
            draw_text((__view_get(0, 0) + (__view_get(2, 0) / 2)) - 10, __view_get(1, 0) + 256, string_hash_to_newline("CP - -"));
        else if (addRemove_card == "add")
            draw_text((__view_get(0, 0) + (__view_get(2, 0) / 2)) - 10, __view_get(1, 0) + 256, string_hash_to_newline("CP " + string(calculoCP)));
        else
            draw_text((__view_get(0, 0) + (__view_get(2, 0) / 2)) - 10, __view_get(1, 0) + 256, string_hash_to_newline("CP " + string(calculoCP)));
        
        if (!object_exists(obj_control_tutorial))
            draw_text(__view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 60, string_hash_to_newline(string(select[6])));
    }
}

if (!instance_exists(obj_control_tutorial))
{
    if (menuOptions == "Editar mazo")
    {
        if (addRemove_card == "add")
        {
            draw_set_alpha(1);
            draw_sprite(spr_botonAdd, 0, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 60, __view_get(1, 0) + 128);
            draw_set_alpha(0.5);
            draw_sprite(spr_botonOut, 0, __view_get(0, 0) + (__view_get(2, 0) / 2) + 60, __view_get(1, 0) + 128);
        }
        else
        {
            draw_set_alpha(0.5);
            draw_sprite(spr_botonAdd, 0, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 60, __view_get(1, 0) + 128);
            draw_set_alpha(1);
            draw_sprite(spr_botonOut, 0, __view_get(0, 0) + (__view_get(2, 0) / 2) + 60, __view_get(1, 0) + 128);
        }
    }
}

if (menuOptions == "Editar mazo" || menuOptions == "Borrar cartas")
{
    draw_set_alpha(1);
    
    if (select != undefined)
    {
        var drawCard = select;
        var auxCopys = drawCard[2];
        draw_sprite_ext(scr_return_hdCard(drawCard[0]), 0, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 160, __view_get(1, 0) + 192, 0.4, 0.4, 0, c_white, 1);
        
        if (addRemove_card == "add")
        {
            for (var col = 0; col < 2; col++)
            {
                for (var fil = 0; fil < 5; fil++)
                {
                    draw_set_color(c_white);
                    draw_set_font(little);
                    
                    if (auxCopys[fil + (5 * col)] == 0)
                    {
                        draw_set_alpha(0.4);
                        draw_sprite(spr_cardValue_ori, fil + (5 * col), ((__view_get(0, 0) + (__view_get(2, 0) / 2)) - 160) + (110 * col), ((__view_get(1, 0) + (__view_get(3, 0) / 2)) - 10) + (42 * fil));
                        draw_text(((__view_get(0, 0) + (__view_get(2, 0) / 2)) - 160) + (110 * col) + 70, __view_get(1, 0) + (__view_get(3, 0) / 2) + (42 * fil), string_hash_to_newline(string(auxCopys[fil + (5 * col)])));
                    }
                    else
                    {
                        draw_set_alpha(1);
                        draw_sprite(spr_cardValue_ori, fil + (5 * col), ((__view_get(0, 0) + (__view_get(2, 0) / 2)) - 160) + (110 * col), ((__view_get(1, 0) + (__view_get(3, 0) / 2)) - 10) + (42 * fil));
                        draw_text(((__view_get(0, 0) + (__view_get(2, 0) / 2)) - 160) + (110 * col) + 70, __view_get(1, 0) + (__view_get(3, 0) / 2) + (42 * fil), string_hash_to_newline(string(auxCopys[fil + (5 * col)])));
                    }
                }
            }
        }
    }
}

if (menuOptions == "")
{
}

if (menuOptions == "Editar mazo")
{
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_color(c_black);
    draw_set_font(little);
    draw_sprite_ext(spr_cuadro_dialogo, 0, __view_get(0, 0) + (__view_get(2, 0) / 2), __view_get(1, 0) + (__view_get(3, 0) / 2) + 300, 0.5, 0.5, 0, c_white, 1);
    draw_text((__view_get(0, 0) + (__view_get(2, 0) / 2)) - 198, __view_get(1, 0) + (__view_get(3, 0) / 2) + 270, string_hash_to_newline("Presiona 'Z' para añadir carta al mazo#Presiona 'X' para retroceder#Presiona 'A' para añadir cartas#Presiona 'S' para retirar cartas"));
}

if (menuOptions == "Equipar mazo" || menuOptions == "Limpiar mazo" || menuOptions == "Renombrar mazo")
{
    draw_set_alpha(0.5);
    draw_rectangle(__view_get(0, 0), __view_get(1, 0), __view_get(0, 0) + __view_get(2, 0), __view_get(1, 0) + __view_get(3, 0), false);
    draw_set_halign(fa_center);
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_text(__view_get(0, 0) + 32, __view_get(1, 0) + 32, string_hash_to_newline(string(menuOptions)));
    
    for (var i = 0; i < 3; i++)
    {
        draw_sprite_ext(spr_decks, i, __view_get(0, 0) + (__view_get(2, 0) / 4) + (380 * i), __view_get(1, 0) + (__view_get(3, 0) / 2) + 150, 1.5, 1.5, 1, c_white, 1);
        draw_text((__view_get(0, 0) + (__view_get(2, 0) / 4) + (380 * i)) - 60, __view_get(1, 0) + (__view_get(3, 0) / 2) + 200, string_hash_to_newline(string(obj_morral.mazo[0, i])));
    }
    
    if (menuOptions == "Equipar mazo")
    {
        draw_text(__view_get(0, 0) + 32, __view_get(1, 0) + 64, string_hash_to_newline("Mazo equipado actual: " + string(obj_morral.mazo_seleccionado[1])));
        draw_text(__view_get(0, 0) + 32, __view_get(1, 0) + 96, string_hash_to_newline("Cantidad cartas: " + string(obj_morral.mazo_seleccionado[4])));
    }
}

depth = -1;

if (menuOptions == "Recetas")
{
    draw_sprite(spr_receta_tituloReceta, 1, __view_get(0, 0) + 40, __view_get(1, 0) + 40);
    draw_sprite(spr_receta_baseRecetaMaterial, 1, __view_get(0, 0) + 40, __view_get(1, 0) + 130);
    draw_sprite_ext(spr_receta_baseCarta, 1, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 200, __view_get(1, 0) + 130, 0.97, 1, 0, c_white, 1);
    draw_sprite_ext(spr_receta_cuadroItems, 1, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 170, __view_get(1, 0) + (__view_get(3, 0) / 2) + 150, 0.85, 1, 0, c_white, 1);
    draw_sprite(spr_receta_necesitas, 1, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 160, __view_get(1, 0) + (__view_get(3, 0) / 2) + 150);
    draw_sprite_ext(spr_receta_descripcion, 1, __view_get(0, 0) + (__view_get(2, 0) / 2) + 138, __view_get(1, 0) + (__view_get(3, 0) / 2) + 100, 1, 0.68, 0, c_white, 1);
    
    if (!instance_exists(obj_control_tutorial))
    {
        for (var i = 0; i < ds_list_size(obj_morral.recipeBook); i++)
        {
            draw_set_halign(fa_left);
            draw_set_font(general);
            var checkEnable = ds_list_find_value(obj_morral.recipeBook, i);
            
            if (checkEnable[10])
            {
                var dataOut = ds_list_find_value(obj_morral.recipeBook, i);
                draw_text(__view_get(0, 0) + 100, __view_get(1, 0) + 170 + (30 * i), string_hash_to_newline(string(dataOut[7])));
            }
            else
            {
                draw_text(__view_get(0, 0) + 100, __view_get(1, 0) + 170 + (30 * i), string_hash_to_newline("---------"));
            }
        }
    }
    else
    {
        draw_set_halign(fa_left);
        var checkEnable = ds_list_find_value(obj_morral.recipeBook, 0);
        
        if (checkEnable[10])
        {
            var dataOut = ds_list_find_value(obj_morral.recipeBook, 0);
            draw_text(__view_get(0, 0) + 100, __view_get(1, 0) + 170, string_hash_to_newline(string(dataOut[7])));
        }
    }
    
    select = ds_list_find_value(obj_morral.recipeBook, posCursor);
    
    for (var i = 0; i < 4; i++)
    {
        for (var j = 0; j < 3; j++)
            draw_sprite(spr_cuadro_item, 0, __view_get(0, 0) + (__view_get(2, 0) / 2) + 200 + (120 * i), __view_get(1, 0) + 210 + (120 * j));
    }
    
    if (select != undefined && select[10])
    {
        draw_sprite_ext(scr_return_hdCard(select[0]), 0, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 160, __view_get(1, 0) + 175, 0.75, 0.75, 0, c_white, 1);
        script_execute(scr_recetas_MaterialesNecesarios, select[1], (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 130, __view_get(1, 0) + (__view_get(3, 0) / 2) + 210, select[4]);
        script_execute(scr_recetas_MaterialesNecesarios, select[2], __view_get(0, 0) + (__view_get(2, 0) / 2) + 30, __view_get(1, 0) + (__view_get(3, 0) / 2) + 210, select[5]);
        script_execute(scr_recetas_MaterialesNecesarios, select[3], (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 60, __view_get(1, 0) + (__view_get(3, 0) / 2) + 270, select[6]);
        var cantMaterial_encontrado = 0;
        
        for (var k = 0; k < ds_list_size(obj_morral.morral); k++)
        {
            var searchItem = ds_list_find_value(obj_morral.morral, k);
            
            for (var l = 0; l < 4; l++)
            {
                if (searchItem[1] == select[l])
                {
                    if (searchItem[3] > 0 && searchItem[3] <= 9)
                    {
                        draw_sprite(searchItem[0], 0, __view_get(0, 0) + (__view_get(2, 0) / 2) + 160 + (120 * cantMaterial_encontrado), __view_get(1, 0) + 190);
                        draw_sprite(spr_nros, searchItem[3], __view_get(0, 0) + (__view_get(2, 0) / 2) + 220 + (120 * cantMaterial_encontrado), __view_get(1, 0) + 170);
                    }
                    else if (searchItem[3] > 9)
                    {
                        draw_sprite(searchItem[0], 0, __view_get(0, 0) + (__view_get(2, 0) / 2) + 160 + (120 * cantMaterial_encontrado), __view_get(1, 0) + 190);
                        draw_sprite(spr_nros, string_char_at(string(searchItem[3]), 1), __view_get(0, 0) + (__view_get(2, 0) / 2) + 200 + (120 * cantMaterial_encontrado), __view_get(1, 0) + 170);
                        draw_sprite(spr_nros, string_char_at(string(searchItem[3]), 2), __view_get(0, 0) + (__view_get(2, 0) / 2) + 225 + (120 * cantMaterial_encontrado), __view_get(1, 0) + 170);
                    }
                    
                    cantMaterial_encontrado++;
                }
            }
        }
        
        draw_set_font(description);
        draw_text(__view_get(0, 0) + (__view_get(2, 0) / 2) + 170, __view_get(1, 0) + (__view_get(3, 0) / 2) + 120, string_hash_to_newline("Descripcion : "));
        draw_text(__view_get(0, 0) + (__view_get(2, 0) / 2) + 170, __view_get(1, 0) + (__view_get(3, 0) / 2) + 140, string_hash_to_newline(string(select[8])));
    }
    else
    {
        draw_set_font(description);
        draw_text(__view_get(0, 0) + (__view_get(2, 0) / 2) + 170, __view_get(1, 0) + (__view_get(3, 0) / 2) + 140, string_hash_to_newline("Aun no has desbloqueado esta receta"));
    }
}

if (menuOptions == "Memorin")
{
    draw_sprite(spr_diario_base, 1, __view_get(0, 0) + 100, __view_get(1, 0) + 4);
    
    if (subMenu == "personas")
    {
        draw_sprite(spr_diario_florafauna, 0, __view_get(0, 0) + 390, __view_get(1, 0) + 30);
        draw_sprite(spr_diario_objetos, 0, __view_get(0, 0) + 250, __view_get(1, 0) + 30);
        draw_sprite(spr_diario_personas, 1, __view_get(0, 0) + 110, __view_get(1, 0) + 30);
    }
    
    if (subMenu == "objetos")
    {
        draw_sprite(spr_diario_florafauna, 0, __view_get(0, 0) + 390, __view_get(1, 0) + 30);
        draw_sprite(spr_diario_personas, 0, __view_get(0, 0) + 110, __view_get(1, 0) + 30);
        draw_sprite(spr_diario_objetos, 1, __view_get(0, 0) + 250, __view_get(1, 0) + 30);
    }
    
    if (subMenu == "florafauna")
    {
        draw_sprite(spr_diario_personas, 0, __view_get(0, 0) + 110, __view_get(1, 0) + 30);
        draw_sprite(spr_diario_objetos, 0, __view_get(0, 0) + 250, __view_get(1, 0) + 30);
        draw_sprite(spr_diario_florafauna, 1, __view_get(0, 0) + 390, __view_get(1, 0) + 30);
    }
    
    script_execute(scr_lista_logros_memorin());
}

draw_set_alpha(1);

if (menuOptions == "Principal")
    draw_sprite(spr_cursor, 0, __view_get(0, 0) + 270, __view_get(1, 0) + 30 + ((posCursor + 1) * 64));

if (menuOptions == "Ver cartas")
    draw_sprite(spr_cursor, 0, __view_get(0, 0) + 290, __view_get(1, 0) + 30 + ((posCursor + 1) * 64));

if (menuOptions == "Inventario")
    draw_sprite(spr_cursor, 0, __view_get(0, 0) + 270 + ((posCursor - (4 * floor(posCursor / 4))) * 125), __view_get(1, 0) + 270 + (130 * floor(posCursor / 4)));

if (menuOptions == "Recetas")
    draw_sprite(spr_cursor, 0, __view_get(0, 0) + 350, __view_get(1, 0) + 180 + (30 * posCursor));

if (menuOptions == "Memorin")
{
    if (posCursor >= visorRange_max_diario)
        draw_sprite(spr_cursor, 0, __view_get(0, 0) + 500, __view_get(1, 0) + 150 + 450);
    else
        draw_sprite(spr_cursor, 0, __view_get(0, 0) + 500, __view_get(1, 0) + 150 + (90 * (posCursor - visorRange_min_diario)));
}

if (menuOptions == "Equipar mazo" || menuOptions == "Limpiar mazo" || menuOptions == "Renombrar mazo")
    draw_sprite(spr_cursor, 0, __view_get(0, 0) + (__view_get(2, 0) / 4) + (posCursor * 380) + 60, __view_get(1, 0) + (__view_get(3, 0) / 2) + 160);

draw_set_alpha(1);

if (menuOptions == "Editar mazo" || menuOptions == "Borrar cartas")
{
    depth = -100;
    
    if (addRemove_card == "add")
    {
        if (editDeck_phase == "cardInventory")
        {
            if (posCursor < 3)
                draw_sprite(spr_cursor, 0, __view_get(0, 0) + 200 + (posCursor * 106), __view_get(1, 0) + 300);
            else
                draw_sprite(spr_cursor, 0, __view_get(0, 0) + 200 + ((posCursor - (3 * floor(posCursor / 3))) * 106), __view_get(1, 0) + 300 + (140 * floor(posCursor / 3)));
        }
        
        if (editDeck_phase == "cardCopy")
        {
            if (posCursor < 5)
                draw_sprite(spr_cursor, 0, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 20, __view_get(1, 0) + (__view_get(3, 0) / 2) + 10 + (posCursor * 42));
            else
                draw_sprite(spr_cursor, 0, ((__view_get(0, 0) + (__view_get(2, 0) / 2)) - 20) + 96, __view_get(1, 0) + (__view_get(3, 0) / 2) + 10 + ((posCursor - 5) * 42));
        }
        
        if (editDeck_phase == "cardDeck")
        {
            if (posCursor >= visorRange_min && posCursor < (visorRange_min + 3))
                draw_sprite(spr_cursor, 0, ((__view_get(0, 0) + __view_get(2, 0)) - 300) + ((posCursor - (3 * floor(posCursor / 3))) * 106), __view_get(1, 0) + 294);
            else if (posCursor >= (visorRange_min + 3) && posCursor <= (visorRange_max - 3))
                draw_sprite(spr_cursor, 0, ((__view_get(0, 0) + __view_get(2, 0)) - 300) + ((posCursor - (3 * floor(posCursor / 3))) * 106), __view_get(1, 0) + 434);
            else if (posCursor > (visorRange_max - 3) && posCursor <= visorRange_max)
                draw_sprite(spr_cursor, 0, ((__view_get(0, 0) + __view_get(2, 0)) - 300) + ((posCursor - (3 * floor(posCursor / 3))) * 106), __view_get(1, 0) + 574);
        }
    }
    else if (posCursor >= visorRange_min && posCursor < (visorRange_min + 3))
    {
        draw_sprite(spr_cursor, 0, ((__view_get(0, 0) + __view_get(2, 0)) - 300) + ((posCursor - (3 * floor(posCursor / 3))) * 106), __view_get(1, 0) + 294);
    }
    else if (posCursor >= (visorRange_min + 3) && posCursor <= (visorRange_max - 3))
    {
        draw_sprite(spr_cursor, 0, ((__view_get(0, 0) + __view_get(2, 0)) - 300) + ((posCursor - (3 * floor(posCursor / 3))) * 106), __view_get(1, 0) + 434);
    }
    else if (posCursor > (visorRange_max - 3) && posCursor <= visorRange_max)
    {
        draw_sprite(spr_cursor, 0, ((__view_get(0, 0) + __view_get(2, 0)) - 300) + ((posCursor - (3 * floor(posCursor / 3))) * 106), __view_get(1, 0) + 574);
    }
}

draw_set_alpha(1);

if (menuOptions == "Principal" || menuOptions == "Ver cartas")
{
    draw_sprite(spr_spiritu_ori, -1, (__view_get(0, 0) + __view_get(2, 0)) - 120, (__view_get(1, 0) + __view_get(3, 0)) - 10);
    
    if (!warningMessage)
        draw_sprite(spr_principalGlobo, 1, __view_get(0, 0) + 60, __view_get(1, 0) + (__view_get(3, 0) / (4/3)));
    else
        draw_sprite(spr_principalGlobo_fallo, 1, __view_get(0, 0) + 60, __view_get(1, 0) + (__view_get(3, 0) / (4/3)));
}

if (instance_exists(obj_control_tutorial))
{
    if (obj_control_tutorial.tutorialOn)
    {
        if (menuOptions == "Principal" && obj_control_tutorial.paso == 10 && posCursor == 0)
            scr_text("Ya podemos ver nuestras cartas!! ", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 30);
        
        if (menuOptions == "Inventario")
        {
            draw_sprite(spr_spiritu_ori, -1, (__view_get(0, 0) + __view_get(2, 0)) - 20, (__view_get(1, 0) + __view_get(3, 0)) - 30);
            draw_sprite(spr_principalGlobo, 1, __view_get(0, 0) + 60, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 60);
            scr_text("Aqui podemos ver los materiales recogidos y una breve descripcion de ellos#Para retroceder al menu anterior, presionar 'X'", 1, __view_get(0, 0) + 108, __view_get(1, 0) + (__view_get(3, 0) / (4/3)) + 90);
        }
        
        if (menuOptions == "Recetas")
        {
            draw_sprite(spr_principalGlobo, 1, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 250, __view_get(1, 0) + 20);
            
            if (ds_list_size(obj_morral.morralCards) == 0)
                scr_text("Aqui podremos crear cartas que te ayudaran durante tu aventura#Como ves, para crear cartas necesitaremos cierta cantidad de#materiales", 1, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 180, __view_get(1, 0) + 20);
            else
                scr_text("Has creado tu primera carta, para verla, retrocede con X y ve al#menu Ver Cartas", 1, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 180, __view_get(1, 0) + 20);
        }
        
        if (menuOptions == "Editar mazo")
        {
            draw_sprite(spr_spiritu_ori, -1, (__view_get(0, 0) + __view_get(2, 0)) - 20, (__view_get(1, 0) + __view_get(3, 0)) - 10);
            draw_sprite(spr_principalGlobo, 1, __view_get(0, 0) + 400, __view_get(1, 0) + 10);
            
            if (obj_control_tutorial.paso >= 12 && obj_control_tutorial.paso <= 14)
            {
                if (obj_morral.mazo_seleccionado[4] == 0)
                {
                    if (editDeck_phase == "cardInventory")
                        scr_text("Puedes elegir entre los distintos tipos de cartas que hayas creado o# conseguido, seleccionemos nuestra carta presionando la tecla 'Z'", 1, __view_get(0, 0) + 430, __view_get(1, 0) + 20);
                    
                    if (editDeck_phase == "cardCopy")
                        scr_text("Debemos elegir el valor de nuestra carta, mientras mayor valor, mas fuerte es# pero a la vez, tiene mayor Card Point (CP),#zagreguemos la carta a nuestro mazo", 1, __view_get(0, 0) + 430, __view_get(1, 0) + 20);
                    
                    if (editDeck_phase == "cardDeck")
                        scr_text("Podemos ubicar la carta en cualquier espacio vacio.# Los mazos tienen un limite, tanto de cartas como de CP", 1, __view_get(0, 0) + 430, __view_get(1, 0) + 20);
                }
                else
                {
                    scr_text("Genial! ahora salgamos del menú, solo debes apretar 'Espacio'", 1, __view_get(0, 0) + 430, __view_get(1, 0) + 20);
                }
            }
            
            if (obj_control_tutorial.paso >= 15)
            {
                if (obj_morral.mazo_seleccionado[4] < 5)
                    scr_text("Tenemos que agregar las cartas al mazo hasta que sean 5#Llevas " + string(obj_morral.mazo_seleccionado[4]) + " carta(s)", 1, __view_get(0, 0) + 430, __view_get(1, 0) + 20);
                else
                    scr_text("Genial! ahora salgamos del menú apretando 'Espacio' ", 1, __view_get(0, 0) + 430, __view_get(1, 0) + 20);
            }
        }
    }
}

if (!instance_exists(obj_control_tutorial) && menuOptions == "Principal")
{
    draw_set_color(c_black);
    draw_text(__view_get(0, 0) + 32, __view_get(1, 0) + 32, "Puntaje : " + string(global.puntaje_total_descrasheo));
    
    switch (room_get_name(room))
    {
        case "rm_humedal":
            draw_sprite(spr_titulo_humedal, 0, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 20, __view_get(1, 0) + 300);
            break;
        
        case "rm_costa_humedal":
            draw_sprite(spr_titulo_humedal, 0, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 20, __view_get(1, 0) + 300);
            break;
        
        case "rm_anzota_2":
            draw_sprite(spr_titulo_cuevasAnzota, 0, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 20, __view_get(1, 0) + 300);
            break;
        
        case "rm_anzota_3":
            draw_sprite(spr_titulo_cuevasAnzota, 0, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 20, __view_get(1, 0) + 300);
            break;
        
        case "rm_cuevas_anzota":
            draw_sprite(spr_titulo_cuevasAnzota, 0, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 20, __view_get(1, 0) + 300);
            break;
        
        case "rm_camarones":
            draw_sprite(spr_titulo_camarones, 0, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 20, __view_get(1, 0) + 300);
            break;
        
        case "rm_final_morro":
            draw_sprite(spr_titulo_costadoMorro, 0, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 20, __view_get(1, 0) + 300);
            break;
    }
    
    draw_sprite(spr_ayuda, 0, (__view_get(0, 0) + (__view_get(2, 0) / 2)) - 600, __view_get(1, 0) + 500);
}
