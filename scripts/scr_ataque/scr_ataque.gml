function scr_ataque() {
var tipos = argument0;

if (global.proyectil_1 == 1)
{
    if (tipos == "normal")
    {
        flecha_id = instance_create(x + distancia, y, obj_flecha);
        flecha_id.creador = creador;
        flecha_id.hspd = p_hspd;
        flecha_id.danho = danho;
        flecha_id.image_xscale = scale_x;
    }
    else if (tipos == "especial_fuego")
    {
        proyectil_id = instance_create(x + distancia, y, obj_proyectil);
        
        if (proyectil_id.x < (room_width / 2))
            proyectil_id.hspd = 10;
        else
            proyectil_id.hspd = -10;
        
        proyectil_id.image_xscale = scale_x / 2;
        proyectil_id.image_yscale = 0.5;
        proyectil_id.danho = danho;
        proyectil_id.creador = creador;
        proyectil_id.image_speed = 0.3;
    }
    else if (tipos == "especial_agua")
    {
        proyectil_id = instance_create(x + distancia, y, obj_proyectil_ice);
        
        if (proyectil_id.x < (room_width / 2))
            proyectil_id.hspd = 10;
        else
            proyectil_id.hspd = -10;
        
        proyectil_id.image_xscale = scale_x / 2;
        proyectil_id.image_yscale = 0.5;
        proyectil_id.danho = danho;
        proyectil_id.creador = creador;
        proyectil_id.image_speed = 0.3;
    }
    else if (tipos == "especial_luna")
    {
        proyectil_id = instance_create(x + distancia, y, obj_proyectil_ligth);
        
        if (proyectil_id.x < (room_width / 2))
            proyectil_id.hspd = 10;
        else
            proyectil_id.hspd = -10;
        
        proyectil_id.image_xscale = scale_x / 2;
        proyectil_id.image_yscale = 0.5;
        proyectil_id.danho = danho;
        proyectil_id.creador = creador;
        proyectil_id.image_speed = 0.3;
    }
    
    // Los ataques de Suyai hacen menos daño que los de Amaru (scr_batalla_equipo)
    if (variable_instance_exists(id, "personaje") && personaje == "suyai")
    {
        if (tipos == "normal")
            flecha_id.danho *= SUYAI_DANHO_MULT;
        else if (string_pos("especial", tipos) == 1)
            proyectil_id.danho *= SUYAI_DANHO_MULT;
    }
}
}
