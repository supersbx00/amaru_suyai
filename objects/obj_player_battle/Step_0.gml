boton_ancestral = keyboard_check_pressed(ord("C")) || gamepad_button_check_pressed(0, gp_face2);

if (global.enable_battle == 0 && global.enable_player == 0)
    exit;

if (escudo_whanku == 1 && create == 0)
{
    escudo_id = instance_create(x + 50, y + 20, obj_escudo_tuto);
    alarm[6] = 240;
    create = 1;
}

if (global.transicion == 0 && add == 0 && trigger_teclado == 1)
{
    alarm_set(4, 10);
    trigger_teclado = 0;
}

if (add == 1)
{
    addCard = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);
    addComboCard = keyboard_check_pressed(ord("X")) || gamepad_button_check_pressed(0, gp_face3);
}

var id1 = id;

if (other.barHealth > 0 && barHealth > 0)
{
    if (!instance_exists(obj_control_tutorial))
    {
        if (addCard && can_atk && add == 1)
        {
            if (carta_mid[3] != "recarga")
            {
                cartaUsada = ds_list_find_value(playerDeck, apuntador);
                global.v_player = cartaUsada[1];
                curar = cartaUsada[1];
                
                if (cartaUsada[3] == "azul" && cura_usada == 0)
                {
                    pos = ds_list_find_index(aux_playerDeck, cartaUsada);
                    cura_usada = 1;
                }
                
                script_execute(scr_batalla_ia, cartaUsada);
                alarm[11] = 60;
                ds_list_delete(playerDeck, apuntador);
            }
        }
        
        if (addComboCard && can_atk && add == 1)
        {
            if (ds_list_size(comboCard_array) < 3 && ds_list_size(playerDeck) > 0)
            {
                if (carta_mid[3] != "recarga" && carta_mid[3] != "anulacion")
                {
                    var cartaPalCombo = ds_list_find_value(playerDeck, apuntador);
                    comboCard_value += cartaPalCombo[2];
                    
                    if (cartaPalCombo[3] != "azul")
                    {
                        ds_list_add(comboCard_array, cartaPalCombo);
                        ds_list_delete(playerDeck, apuntador);
                    }
                    else if (apuntador < (ds_list_size(playerDeck) - 1))
                    {
                        apuntador += 1;
                    }
                    else
                    {
                        apuntador = 0;
                    }
                }
            }
            
            comparaCarta1 = ds_list_find_value(comboCard_array, 0);
            comparaCarta2 = ds_list_find_value(comboCard_array, 1);
            comparaCarta3 = ds_list_find_value(comboCard_array, 2);
            
            if (ds_list_size(comboCard_array) == 3)
            {
                typeCombo = undefined;
                
                if (comparaCarta1 != undefined && comparaCarta2 != undefined && comparaCarta3 != undefined)
                {
                    can_atk = 0;
                    
                    if (comparaCarta1[0] == comparaCarta2[0] && comparaCarta1[0] == comparaCarta3[0])
                    {
                        combo = 1;
                        typeCombo = "unicombo";
                    }
                    else
                    {
                        typeCombo = "multicombo";
                    }
                }
                
                with (instance_create(x, y, obj_card))
                {
                    comboCarta_aux[0] = 14;
                    comboCarta_aux[1] = id1.comboCard_value;
                    comboCarta_aux[2] = id1.comboCard_value;
                    comboCarta_aux[3] = id1.typeCombo;
                    comboCarta_aux[4] = id1.comboCard_array;
                    id1.cartaUsada = comboCarta_aux;
                    global.v_player = id1.comboCard_value;
                    
                    with (id1)
                        script_execute(scr_batalla_ia, cartaUsada);
                    
                    instance_destroy();
                }
            }
        }
    }
    else if (obj_control_tutorial.paso >= 18)
    {
        if (addCard && can_atk)
        {
            if (carta_mid[3] != "recarga")
            {
                cartaUsada = ds_list_find_value(playerDeck, apuntador);
                script_execute(scr_batalla_ia, cartaUsada);
                alarm[11] = 60;
                ds_list_delete(playerDeck, apuntador);
            }
        }
    }
}

recuperar = keyboard_check(ord("Z")) || gamepad_button_check(0, gp_face1);

if (recuperar && can_atk && obj_enemigo.barHealth > 0 && barHealth > 0)
{
    ds_list_clear(comboCard_array);
    scr_recuperarCartas();
}

if (barHealth > 0 && other.barHealth > 0 && !player_cardBreaked)
{
    if (sprite_index == spr_amaru_battle_danho || sprite_index == spr_amaru_battle_cura || sprite_index == spr_amaru_battle_carga || sprite_index == spr_amaru_battle_CardBreaker || addCard)
    {
        hspd = 0;
        vspd = 0;
    }
    else
    {
        script_execute(scr_movimiento);
    }
    
    phy_position_x += hspd;
    phy_position_y += vspd;
}

if (player_cardBreaked && ancestral == 0 && barHealth > 0)
{
    global.enable_player = 0;
    global.enable_battle = 0;
    cartaUsada = undefined;
    alarm[10] = 60;
    can_atk = 0;
    sprite_index = spr_amaru_battle_CardBreaker;
    image_speed = 0.3;
}

if (anulable && !alarmTrigger && barHealth > 0)
{
    global.v_player = 1;
    can_atk = 0;
    alarmTrigger = 1;
    alarm[5] = 30;
}

rotaIzq = keyboard_check_pressed(ord("A")) || gamepad_button_check_pressed(0, gp_shoulderl);
rotaDer = keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(0, gp_shoulderr);

if (!instance_exists(obj_control_tutorial))
    scr_rotarCartas(rotaIzq, rotaDer);
else if (obj_control_tutorial.paso >= 23)
    scr_rotarCartas(rotaIzq, rotaDer);

if (boton_ancestral && can_atk)
{
    if (go_agua >= 2 && go_fuego >= 2 && go_luna >= 2 && create_ancestral == 0)
    {
        sprite_index = spr_amaru_stand_ancestral;
        ancestral = 1;
        alarm[7] = 240;
        create_ancestral = 1;
    }
    else if (create_ancestral == 1 && barHealth > 0)
    {
        distancia = 42.5;
        id_pr = instance_create(x + distancia, y, obj_flecha_espiritual);
        
        with (id_pr)
        {
            if (x < (room_width / 2))
            {
                hspd = 15;
                image_xscale = -1;
            }
            else
            {
                hspd = -15;
                image_xscale = 1;
            }
            
            creador = "player1";
            image_speed = 0.3;
        }
        
        id_pr.danho = 10;
        alarm[11] = 30;
        can_atk = 0;
    }
}

if (barHealth <= 0)
    phy_active = 0;
