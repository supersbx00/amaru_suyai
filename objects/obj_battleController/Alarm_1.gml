var lootChance = 9;
var sprite = "";

if (global.espiritu_luna == 1 && global.espiritu_agua == 0 && global.espiritu_fuego == 0)
{
    global.puntaje_total_descrasheo += 50;
    global.puntaje_total += 50;
    sprite = 20;
}
else if (global.espiritu_agua == 1 && global.espiritu_luna == 1 && global.espiritu_fuego == 0)
{
    global.puntaje_total_descrasheo += 70;
    global.puntaje_total += 70;
    sprite = 16;
}
else if (global.espiritu_fuego == 1 && global.espiritu_luna == 1 && global.espiritu_fuego == 1 && global.khoru == 0)
{
    global.puntaje_total_descrasheo += 90;
    global.puntaje_total += 90;
    sprite = 18;
}
else if (global.khoru == 1)
{
    global.puntaje_total_descrasheo += 120;
    global.puntaje_total += 120;
    sprite = choose(18, 16, 20);
}

if (lootChance >= 7)
{
    nombre = "premio_carta";
    
    for (var i = 0; i < 3; i++)
    {
        with (instance_create(x, y, obj_card))
        {
            card_morral[0] = sprite;
            card_morral[1] = irandom_range(3, 9);
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
    
    if (!instance_exists(obj_dialogo_premio))
    {
        with (instance_create(x, y, obj_dialogo_premio))
            npc = "premio_carta";
    }
}
