push = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);

if (paso == 7)
{
    while (instance_number(obj_materiales) < 5 && cantidad_materiales == 5)
    {
        with (instance_create(random_range(704, 992), random_range(608, 832), obj_materiales))
            sprite_index = spr_fibraVegetal;
        
        while (instance_number(obj_materiales) < 3 && cantidad_materiales == 5)
        {
            with (instance_create(random_range(704, 992), random_range(608, 832), obj_materiales))
                sprite_index = spr_huesoAve;
        }
    }
}

if (paso == 16)
{
    if (!instance_exists(obj_enemigo_normal) && instance_exists(obj_player))
        instance_create(obj_tuto_wanku.x + 250, obj_tuto_wanku.y, obj_enemigo_normal);
}

if (paso == 18)
{
    if (!instance_exists(obj_tutorial_popUp))
    {
        alarm[0] = 1;
        id_popup = instance_create(x, y, obj_tutorial_popUp);
        
        with (id_popup)
            valor_popUp = "atacar";
    }
}

if (paso == 19)
{
    if (!instance_exists(obj_tutorial_popUp))
    {
        alarm[0] = 1;
        id_popup = instance_create(x, y, obj_tutorial_popUp);
        
        with (id_popup)
            valor_popUp = "recargar";
    }
}

if (paso == 22)
{
    if (!instance_exists(obj_tutorial_popUp))
    {
        alarm[0] = 1;
        id_popup = instance_create(x, y, obj_tutorial_popUp);
        
        with (id_popup)
            valor_popUp = "cardbreak";
    }
}

if (paso == 23)
{
    if (!instance_exists(obj_tutorial_popUp))
    {
        alarm[0] = 1;
        id_popup = instance_create(x, y, obj_tutorial_popUp);
        
        with (id_popup)
            valor_popUp = "null card";
    }
}

if (paso == 24)
{
    if (!instance_exists(obj_tutorial_popUp))
    {
        alarm[0] = 1;
        id_popup = instance_create(x, y, obj_tutorial_popUp);
        
        with (id_popup)
            valor_popUp = "rotar mazo";
    }
}

with (obj_tuto_wanku)
{
    if (image_alpha < 1 && obj_control_tutorial.paso == 2 && !obj_control_tutorial.trigger)
    {
        obj_control_tutorial.trigger = 1;
        
        if (!instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
                npc = other.nombre;
        }
        else
        {
            obj_control_tutorial.trigger = 0;
        }
    }
    
    if (!obj_control_tutorial.trigger && obj_control_tutorial.paso == 3)
    {
        obj_control_tutorial.alarm[0] = 75;
        obj_control_tutorial.trigger = 1;
    }
    
    if (!obj_control_tutorial.trigger && obj_control_tutorial.paso == 4)
    {
        obj_control_tutorial.trigger = 1;
        
        if (!instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
                npc = other.nombre;
        }
        else
        {
            obj_control_tutorial.trigger = 0;
        }
    }
    
    if (!obj_control_tutorial.trigger && obj_control_tutorial.paso == 5)
    {
        obj_control_tutorial.trigger = 1;
        
        if (!instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
                npc = other.nombre;
        }
        else
        {
            obj_control_tutorial.trigger = 0;
        }
    }
    
    if (!obj_control_tutorial.trigger && obj_control_tutorial.paso == 8)
    {
        obj_control_tutorial.trigger = 1;
        
        if (!instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
            {
                npc = other.nombre;
                obj_control_tutorial.trigger = 1;
            }
        }
        else
        {
            obj_control_tutorial.trigger = 0;
        }
    }
    
    if (!obj_control_tutorial.trigger && obj_control_tutorial.paso == 13)
    {
        obj_control_tutorial.trigger = 1;
        
        if (!instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
            {
                npc = other.nombre;
                obj_control_tutorial.trigger = 1;
            }
        }
        else
        {
            obj_control_tutorial.trigger = 0;
        }
    }
    
    if (!obj_control_tutorial.trigger && obj_control_tutorial.paso == 14)
    {
        obj_control_tutorial.trigger = 1;
        
        if (!instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
            {
                npc = other.nombre;
                obj_control_tutorial.trigger = 1;
            }
        }
        else
        {
            obj_control_tutorial.trigger = 0;
        }
    }
    
    if (!obj_control_tutorial.trigger && obj_control_tutorial.paso == 25)
    {
        obj_control_tutorial.trigger = 1;
        
        if (!instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
            {
                npc = other.nombre;
                obj_control_tutorial.trigger = 1;
            }
            
            instance_create_layer(x, y, "Compatibility_Instances_Depth_0", obj_khoru_tutorial);
            obj_player.image_xscale = -1;
        }
        else
        {
            obj_control_tutorial.trigger = 0;
        }
    }
    
    if (!obj_control_tutorial.trigger && obj_control_tutorial.paso == 26)
    {
        obj_control_tutorial.trigger = 1;
        
        if (!instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
            {
                npc = other.nombre;
                obj_control_tutorial.trigger = 1;
            }
        }
        else
        {
            obj_control_tutorial.trigger = 0;
        }
    }
    
    if (!obj_control_tutorial.trigger && obj_control_tutorial.paso == 28)
    {
        obj_control_tutorial.trigger = 1;
        
        if (!instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
            {
                npc = other.nombre;
                obj_control_tutorial.trigger = 1;
            }
        }
        else
        {
            obj_control_tutorial.trigger = 0;
        }
    }
    
    if (!obj_control_tutorial.trigger && obj_control_tutorial.paso == 30)
    {
        obj_control_tutorial.trigger = 1;
        
        if (!instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
            {
                npc = other.nombre;
                obj_control_tutorial.trigger = 1;
            }
        }
        else
        {
            obj_control_tutorial.trigger = 0;
        }
    }
    
    if (!obj_control_tutorial.trigger && obj_control_tutorial.paso == 32)
    {
        obj_control_tutorial.trigger = 1;
        
        if (!instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
            {
                npc = other.nombre;
                obj_control_tutorial.trigger = 1;
            }
        }
        else
        {
            obj_control_tutorial.trigger = 0;
        }
    }
}

with (obj_dialogo)
{
    if (numero == (final - 1) && (obj_control_tutorial.paso == 2 || obj_control_tutorial.paso == 5 || obj_control_tutorial.paso == 8 || obj_control_tutorial.paso == 13 || obj_control_tutorial.paso == 14 || obj_control_tutorial.paso == 16 || obj_control_tutorial.paso == 17 || obj_control_tutorial.paso == 25 || obj_control_tutorial.paso == 26 || obj_control_tutorial.paso == 28 || obj_control_tutorial.paso == 30 || obj_control_tutorial.paso == 32))
        obj_control_tutorial.alarm[0] = 10;
}

with (obj_player)
{
    if (enable_player == 0 && !obj_control_tutorial.trigger && obj_control_tutorial.paso == 3)
    {
        obj_control_tutorial.alarm[0] = 90;
        obj_control_tutorial.trigger = 1;
    }
}

if (paso == 6 && !trigger)
{
    trigger = 1;
    alarm[0] = 5;
}

if (paso == 7 && !trigger)
{
    if (cantidad_materiales == 0)
    {
        trigger = 1;
        alarm[0] = 10;
    }
}

if (instance_exists(obj_pause))
{
    if (paso == 9 && !trigger)
    {
        if (obj_pause.menuOptions == "Inventario")
        {
            trigger = 1;
            alarm[0] = 5;
        }
    }
    
    if (paso == 10 && !trigger)
    {
        if (push && obj_pause.menuOptions == "Principal" && obj_pause.posCursor == 1)
        {
            trigger = 1;
            alarm[0] = 10;
        }
    }
    
    if (paso == 11 && !trigger)
    {
        if (obj_pause.menuOptions == "Recetas" && push)
        {
            if (ds_list_size(obj_morral.morralCards) > 0)
            {
                io_clear();
                trigger = 1;
                alarm[0] = 10;
            }
        }
    }
    
    if (paso == 12 && !trigger)
    {
        if (obj_morral.mazo_seleccionado[4] > 0)
        {
            trigger = 1;
            alarm[0] = 10;
        }
    }
}

if (paso == 15 && global.pause == 0 && obj_morral.mazo_seleccionado[4] >= 5)
    paso = 16;

if (paso == 17 && !trigger)
{
    if (room_get_name(room) == "rm_battle_tutorial")
    {
        trigger = 1;
        
        if (!instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
                npc = "wanku_tutorial";
        }
        else
        {
            trigger = 0;
        }
    }
}

if (paso == 20 && !trigger)
{
    if (room == rm_battle_tutorial)
    {
        if (obj_enemigo.barHealth <= 65)
        {
            trigger = 1;
            alarm[0] = 10;
        }
    }
}

if (paso == 21 && !trigger)
{
    if (room == rm_battle_tutorial)
    {
        trigger = 1;
        alarm[0] = 280;
    }
}

if (paso == 25 && !trigger)
{
    if (room == rm_tutorial)
    {
        trigger = 1;
        alarm[0] = 10;
    }
}

if (paso == 27 && !trigger)
{
    trigger = 1;
    alarm[0] = 10;
}

if (paso == 29 && !trigger)
{
    trigger = 1;
    alarm[0] = 10;
}

if (paso == 31 && !trigger)
{
    trigger = 1;
    alarm[0] = 10;
}

if (paso == 32 && !trigger)
{
    trigger = 1;
    alarm[0] = 10;
}

if (paso == 33 && !trigger)
{
    trigger = 1;
    alarm[0] = 10;
}

if (room == rm_battle_tutorial)
{
    if (obj_player_battle.barHealth <= 25)
        wanku_help = 1;
    
    if (wanku_help)
    {
        obj_player_battle.barHealth = 25;
        
        if (!instance_exists(obj_escudo_tuto))
            instance_create(obj_player_battle.x + 50, obj_player_battle.y + 20, obj_escudo_tuto);
    }
}
else
{
    wanku_help = 0;
}
