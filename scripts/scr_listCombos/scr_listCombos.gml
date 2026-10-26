function scr_listCombos() {
buscaTipo = ds_list_find_value(argument0[4], 0);
var id_tns = -4;
var id_pr = -4;
danho = argument0[2];

if (argument0[2] >= 10)
{
    if (buscaTipo[3] == "especial_luna")
    {
        id_tns = instance_create(x, y, obj_transparente);
        
        with (id_tns)
        {
            image_xscale = 1.3;
            image_yscale = 1.3;
            sprite_index = spr_moon;
        }
        
        id_pr = instance_create(x, y, obj_proyectil_ligth);
        
        with (id_pr)
        {
            if (x < (room_width / 2))
                hspd = 10;
            else
                hspd = -10;
            
            creador = argument1;
            image_speed = 0.3;
        }
        
        id_pr.danho = danho;
    }
    
    if (buscaTipo[3] == "especial_agua")
    {
        id_tns = instance_create(x, y, obj_transparente);
        
        with (id_tns)
        {
            image_xscale = 1.3;
            image_yscale = 1.3;
            sprite_index = spr_agua;
        }
        
        id_pr = instance_create(x, y, obj_proyectil_ice);
        
        with (id_pr)
        {
            if (x < (room_width / 2))
                hspd = 10;
            else
                hspd = -10;
            
            creador = argument1;
            image_speed = 0.3;
        }
        
        id_pr.danho = danho;
    }
    
    if (buscaTipo[3] == "especial_fuego")
    {
        id_tns = instance_create(x, y, obj_transparente);
        
        with (id_tns)
        {
            image_xscale = 1.3;
            image_yscale = 1.3;
            sprite_index = spr_fuego;
        }
        
        id_pr = instance_create(x, y, obj_proyectil);
        
        with (id_pr)
        {
            if (x < (room_width / 2))
                hspd = 10;
            else
                hspd = -10;
            
            creador = argument1;
            image_speed = 0.3;
        }
        
        id_pr.danho = danho;
    }
    
    if (buscaTipo[3] == "rojo")
    {
        id_pr = instance_create(x + distancia, y, obj_flecha_espiritual);
        id_tns = instance_create(x, y, obj_transparente);
        
        with (id_tns)
            sprite_index = spr_wanku;
        
        with (id_pr)
        {
            if (obj_flecha_espiritual.x < (room_width / 2))
            {
                image_xscale = -1;
                hspd = 20;
            }
            else
            {
                image_xscale = 1;
                hspd = -20;
            }
            
            image_speed = 0.3;
            creador = argument1;
        }
        
        id_pr.danho = danho;
    }
    
    if (buscaTipo[3] == "azul")
    {
        with (instance_create(x, y, obj_proyectilHealth))
        {
            creador = argument1;
            image_speed = 0.3;
        }
    }
}
else
{
    if (buscaTipo[3] == "rojo")
    {
        tipo = "normal";
        alarm_set(0, 10);
    }
    
    if (buscaTipo[3] == "azul")
        alarm_set(1, 10);
    
    if (buscaTipo[3] == "especial_fuego")
    {
        tipo = "especial_fuego";
        alarm_set(0, 10);
    }
    
    if (buscaTipo[3] == "especial_agua")
    {
        tipo = "especial_agua";
        alarm_set(0, 10);
    }
    
    if (buscaTipo[3] == "especial_luna")
    {
        tipo = "especial_luna";
        alarm_set(0, 10);
    }
}
}
