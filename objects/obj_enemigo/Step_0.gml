var id1 = id;

if (!player_cardBreaked && !player_danho)
{
    if (velocidad == 0)
        velocidad = 4;
    
    event_user(1);
}
else
{
    velocidad = 0;
    event_user(1);
}

if (!anulable && !player_cardBreaked && escoger == 0 && barHealth > 0)
{
    with (instance_create(x, y, obj_card))
    {
        randomize();
        
        if (!instance_exists(obj_control_tutorial))
        {
            sprite_index = spr_cardAtk;
            image_index = irandom_range(5, 9);
        }
        else
        {
            sprite_index = spr_cardAtk;
            
            if (obj_control_tutorial.paso <= 20)
                image_index = irandom_range(1, 4);
            
            if (obj_control_tutorial.paso == 21)
                image_index = 9;
            
            if (obj_control_tutorial.paso >= 25)
                image_index = irandom_range(1, 6);
        }
        
        card_inDeck[0] = sprite_index;
        card_inDeck[1] = image_index;
        card_inDeck[2] = image_index;
        card_inDeck[3] = "ataque";
        global.v_enemy = image_index;
        id1.cartaUsada = card_inDeck;
        id1.ataque = card_inDeck[1];
        id1.alarm[11] = 60;
        id1.danho = card_inDeck[1];
        id1.alarm[0] = 10;
        instance_destroy();
    }
    
    escoger = 1;
}

if (!player_cardBreaked && !player_danho)
{
    if (my_path != -1 && barHealth > 0)
    {
        dir = point_direction(my_target.x, my_target.y, phy_position_x, phy_position_y);
        dist = point_distance(my_target.x, my_target.y, phy_position_x, phy_position_y);
        dx = lengthdir_x(4, dir);
        dy = lengthdir_y(4, dir);
        hspd = dx;
        vspd = dy;
        phy_position_x -= dx;
        phy_position_y -= dy;
        
        if (dist > 32)
        {
            phy_position_x = my_target.x;
            phy_position_y = my_target.y;
        }
    }
}

if (hspd != 0 || vspd != 0)
{
    sprite_index = spr_enemigo_battle_run;
    image_speed = 0.3;
}

if (barHealth <= 0 && tipo == "normal")
{
    my_path = -1;
    hspd = 0;
    vspd = 0;
    barHealth = 0;
    phy_active = 0;
    sprite_index = spr_enemigo_battle_defeat;
}

if (player_cardBreaked && !alarm_card)
{
    cartaUsada = undefined;
    velocidad = 0;
    alarm_card = 1;
    hspd = 0;
    vspd = 0;
    global.v_enemy = 0;
    alarm[10] = 75;
    
    if (sprite_index == spr_enemigo_battle_run)
    {
        sprite_index = spr_enemigo_battle_CardBreaker;
        image_speed = 0.3;
    }
}

if (player_danho)
{
    cartaUsada = undefined;
    velocidad = 0;
    hspd = 0;
    vspd = 0;
    
    if (sprite_index == spr_enemigo_battle_run)
    {
        sprite_index = spr_enemigo_battle_danho;
        image_speed = 0.3;
    }
}

if (anulable && !alarm_card)
{
    global.v_enemy = 1;
    can_atk = 0;
    alarm_card = 1;
    alarm[5] = 30;
}

if (sprite_index == spr_enemigo_battle_CardBreaker)
    event_user(1);

if (sprite_index == spr_enemigo_battle_danho)
{
    alarm[10] = 10;
    event_user(1);
}

if (trigger_angulo == 1)
{
    trigger_angulo = 0;
    alarm[3] = 190;
}

randomize();
tiempo = choose(160, 190, 240);

if (trigger_velecidad == 1 && sprite_index == spr_enemigo_battle_run)
{
    trigger_velecidad = 0;
    alarm[4] = tiempo;
}
