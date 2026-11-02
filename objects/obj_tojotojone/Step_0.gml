var id1 = id;
tipo = "tojon";

if (!player_cardBreaked && !player_danho)
{
    if (velocidad == 0)
    {
        velocidad = 4;
        event_user(1);
    }
}
else
{
    velocidad = 0;
    event_user(1);
}

// Con varios enemigos, solo elige carta el que tiene el turno (scr_batalla_enemigos)
if (escoger == 0 && barHealth > 0 && !player_cardBreaked && !anulable && scr_batalla_mi_turno())
{
    randomize();
    
    if (count >= 10)
    {
        tipo_ataque = "paralizar";
        count = random_range(1, 5);
        show_debug_message("count =" + string(count));
    }
    else
    {
        tipo_ataque = "normal";
    }
    
    with (instance_create(x, y, obj_card))
    {
        if (id1.tipo_ataque == "paralizar")
        {
            image_index = 0;
            sprite_index = spr_cardsNull;
            card_inDeck[0] = sprite_index;
            card_inDeck[1] = image_index;
            card_inDeck[2] = image_index;
            card_inDeck[3] = "ataque";
            id1.danho = card_inDeck[1];
            id1.cartaUsada = card_inDeck;
            id1.ataque = card_inDeck[1];
            id1.danho = card_inDeck[1];
            id1.alarm[3] = 10;
            id1.count = id1.count + 1;
        }
        else if (id1.tipo_ataque == "normal")
        {
            randomize();
            image_index = irandom_range(5, 9);
            sprite_index = spr_cardAtk;
            card_inDeck[0] = sprite_index;
            card_inDeck[1] = image_index;
            card_inDeck[2] = image_index;
            card_inDeck[3] = "ataque";
            global.v_enemy = image_index;
            id1.danho = card_inDeck[1];
            id1.cartaUsada = card_inDeck;
            id1.ataque = card_inDeck[1];
            id1.danho = card_inDeck[1];
            id1.alarm[0] = 10;
            id1.count = id1.count + 1;
        }
        else if (id1.tipo_ataque == "combo")
        {
            typeCombo = "luna";
            
            for (var i = 0; i < 3; i++)
            {
                randomize();
                image_index = irandom_range(5, 9);
                sprite_index = spr_cardAtk;
                card_inDeck[0] = sprite_index;
                card_inDeck[1] = image_index;
                card_inDeck[2] = image_index;
                card_inDeck[3] = "ataque";
                id1.cartaUsada = card_inDeck;
                id1.ataque = card_inDeck[1];
                id1.comboCard_value += card_inDeck[1];
                ds_list_add(id1.ComboArray, id1.cartaUsada);
            }
            
            if (ds_list_size(id1.ComboArray) == 3)
            {
                comboCarta_aux[0] = 0;
                comboCarta_aux[1] = 0;
                comboCarta_aux[2] = id1.comboCard_value;
                comboCarta_aux[3] = typeCombo;
                global.v_enemy = id1.comboCard_value;
                id1.cartaUsada = comboCarta_aux;
                
                with (id1)
                {
                    if (!player_cardBreaked && !player_danho)
                        script_execute(scr_combo_enemy, cartaUsada);
                }
            }
        }
        
        instance_destroy();
    }
    
    alarm[11] = 60;
    escoger = 1;
}

if (!player_cardBreaked && !player_danho)
{
    // Destinos al azar en su mitad de la arena, como los demás enemigos (antes seguía un recorrido fijo)
    if (barHealth > 0)
    {
        scr_enemigo_mover();
        global.count = 0;
    }
}

if (hspd != 0 || vspd != 0)
{
    sprite_index = spr_tojone;
    image_speed = 0.3;
}

if (barHealth <= 0 && tipo == "tojon")
{
    my_path = -1;
    hspd = 0;
    vspd = 0;
    player_cardBreaked = 0;
    sprite_index = spr_tojone_muerte;
    image_speed = 0.5;
}

if (player_cardBreaked && !alarmTrigger)
{
    cartaUsada = undefined;
    velocidad = 0;
    alarmTrigger = 1;
    hspd = 0;
    vspd = 0;
    alarm[10] = 75;
    global.v_enemy = 0;
    
    if (sprite_index == spr_tojone)
    {
        sprite_index = spr_tojone_cardBreacker;
        image_speed = 0.3;
    }
}

if (anulable && !alarmTrigger)
{
    global.v_enemy = 1;
    can_atk = 0;
    alarmTrigger = 1;
    alarm[5] = 30;
}

if (player_danho)
{
    cartaUsada = undefined;
    velocidad = 0;
    hspd = 0;
    vspd = 0;
    
    if (sprite_index == spr_tojone)
    {
        sprite_index = spr_tojone_danho;
        image_speed = 0.3;
    }
}

if (sprite_index == spr_tojone_cardBreacker)
    event_user(1);

if (sprite_index == spr_tojone_danho)
{
    alarm[10] = 10;
    event_user(1);
}

// Apuntar, avisar y disparar el patrón elegido (scr_batalla_enemigos)
scr_enemigo_ataque_fases();
