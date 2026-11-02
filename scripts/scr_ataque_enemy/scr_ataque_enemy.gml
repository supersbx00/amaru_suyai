// Disparo de un enemigo. angulo (grados): inclinación del disparo, para el abanico (scr_enemigo_disparar).
// Cada proyectil recuerda a su dueño: si a ese enemigo lo aturden o le anulan la carta, el ataque desaparece.
function scr_ataque_enemy(tipos, angulo = 0) {
var nuevo = noone;

if (global.proyectil_2 == 1)
{
    if (tipos == "normal")
    {
        flecha_id = instance_create(x + distancia, y, obj_flecha);
        flecha_id.creador = creador;
        flecha_id.hspd = p_hspd;
        flecha_id.danho = danho;
        flecha_id.image_xscale = scale_x;
        nuevo = flecha_id;
    }
    
    if (tipos == "tojone")
    {
        flecha_id = instance_create(x + distancia, y, obj_cuchilla);
        flecha_id.creador = creador;
        flecha_id.hspd = p_hspd;
        flecha_id.danho = danho;
        flecha_id.image_xscale = scale_x;
        nuevo = flecha_id;
    }
    else if (tipos == "especial_fuego")
    {
        proyectil_id = instance_create(x + distancia, y, obj_proyectil);
        
        if (proyectil_id.x < (room_width / 2))
            proyectil_id.hspd = -15;
        else
            proyectil_id.hspd = -15;
        
        proyectil_id.image_xscale = scale_x / 2;
        proyectil_id.image_yscale = 0.5;
        proyectil_id.creador = creador;
        proyectil_id.danho = danho;
        proyectil_id.image_speed = 0.3;
        nuevo = proyectil_id;
    }
    else if (tipos == "especial_agua")
    {
        proyectil_id = instance_create(x + distancia, y, obj_proyectil_ice);
        
        if (proyectil_id.x < (room_width / 2))
            proyectil_id.hspd = -15;
        else
            proyectil_id.hspd = -15;
        
        proyectil_id.image_xscale = scale_x / 2;
        proyectil_id.image_yscale = 0.5;
        proyectil_id.creador = creador;
        proyectil_id.danho = danho;
        proyectil_id.image_speed = 0.3;
        nuevo = proyectil_id;
    }
    else if (tipos == "especial_luna")
    {
        proyectil_id = instance_create(x + distancia, y, obj_proyectil_ligth);
        
        if (proyectil_id.x < (room_width / 2))
            proyectil_id.hspd = -15;
        else
            proyectil_id.hspd = -15;
        
        proyectil_id.image_xscale = scale_x / 2;
        proyectil_id.image_yscale = 0.5;
        proyectil_id.creador = creador;
        proyectil_id.danho = danho;
        proyectil_id.image_speed = 0.3;
        nuevo = proyectil_id;
    }
    
    if (nuevo != noone)
    {
        nuevo.dueno = id;
        nuevo.vspd = abs(nuevo.hspd) * dtan(angulo);
    }
    
    global.proyectil_2 = 0;
}
}
