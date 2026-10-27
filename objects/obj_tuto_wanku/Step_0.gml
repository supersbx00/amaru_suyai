image_alpha = upAlpha;
push = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);

if (obj_control_tutorial.paso == 2)
{
    if (upAlpha < 1)
        upAlpha += 0.03;
}

if (obj_control_tutorial.paso == 3)
{
    if (upAlpha > 0)
        upAlpha -= 0.07;
}

if (obj_control_tutorial.paso == 4)
{
    if (upAlpha < 1)
        upAlpha += 0.03;
    
    x = 736;
    y = 532;
    
    if (push && dist <= 100)
        obj_control_tutorial.alarm[0] = 1;
}

if (obj_control_tutorial.cantidad_materiales == 1 && obj_control_tutorial.paso == 7)
{
    if (upAlpha > 0)
        upAlpha -= 0.07;
}

if (obj_control_tutorial.paso == 8)
{
    if (upAlpha < 1)
        upAlpha += 0.03;
    
    x = (room_width / 2) + 100;
    y = room_height / 2;
}

if (obj_control_tutorial.paso == 14)
{
    if (!cartas_entregadas)
    {
        repeat (4)
        {
            with (instance_create(x, y, obj_card))
            {
                card_morral[0] = 5;
                card_morral[1] = irandom_range(5, 7);
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

        cartas_entregadas = 1;
    }
}

if (obj_control_tutorial.paso >= 25 && room == rm_tutorial_test)
{
    x = obj_player.x - 100;
    y = obj_player.y;
    image_alpha = 1;
}

with (other.id)
    dist = point_distance(x, y, obj_player.x, obj_player.y);
