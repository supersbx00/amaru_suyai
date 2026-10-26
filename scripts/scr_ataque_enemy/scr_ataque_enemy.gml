function scr_ataque_enemy() {
var tipos = argument0;

if (global.proyectil_2 == 1)
{
    if (tipos == "normal")
    {
        flecha_id = instance_create(x + distancia, y, obj_flecha);
        flecha_id.creador = creador;
        flecha_id.hspd = p_hspd;
        flecha_id.danho = danho;
        flecha_id.image_xscale = scale_x;
    }
    
    if (tipos == "tojone")
    {
        flecha_id = instance_create(x + distancia, y, obj_cuchilla);
        flecha_id.creador = creador;
        flecha_id.hspd = p_hspd;
        flecha_id.danho = danho;
        flecha_id.image_xscale = scale_x;
    }
    else if (tipos == "especial_fuego")
    {
        proyectil_id = instance_create(x + distancia, y, obj_proyectil);
        
        if (proyectil_id.x < (room_width / 2))
            proyectil_id.hspd = -10;
        else
            proyectil_id.hspd = -10;
        
        proyectil_id.image_xscale = scale_x / 2;
        proyectil_id.image_yscale = 0.5;
        proyectil_id.creador = creador;
        proyectil_id.danho = danho;
        proyectil_id.image_speed = 0.3;
    }
    else if (tipos == "especial_agua")
    {
        proyectil_id = instance_create(x + distancia, y, obj_proyectil_ice);
        
        if (proyectil_id.x < (room_width / 2))
            proyectil_id.hspd = -10;
        else
            proyectil_id.hspd = -10;
        
        proyectil_id.image_xscale = scale_x / 2;
        proyectil_id.image_yscale = 0.5;
        proyectil_id.creador = creador;
        proyectil_id.danho = danho;
        proyectil_id.image_speed = 0.3;
    }
    else if (tipos == "especial_luna")
    {
        proyectil_id = instance_create(x + distancia, y, obj_proyectil_ligth);
        
        if (proyectil_id.x < (room_width / 2))
            proyectil_id.hspd = -10;
        else
            proyectil_id.hspd = -10;
        
        proyectil_id.image_xscale = scale_x / 2;
        proyectil_id.image_yscale = 0.5;
        proyectil_id.creador = creador;
        proyectil_id.danho = danho;
        proyectil_id.image_speed = 0.3;
    }
    
    global.proyectil_2 = 0;
}
}
