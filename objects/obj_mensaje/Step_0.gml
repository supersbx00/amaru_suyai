var condicion = 0;
var forzar_avanzar = 0;
push_enter = keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_face3);
push_cont = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);

switch (global.numero)
{
    case 3:
        if (obj_cuerpo.size == obj_cuerpo.max_size)
        {
            condicion = 1;
            forzar_avanzar = 1;
        }
        
        break;
    
    case 4:
        if (instance_number(obj_organo) == 0)
        {
            condicion = 2;
            forzar_avanzar = 2;
        }
        
        break;
    
    case 7:
        if (global.controlsnap == 6)
        {
            condicion = 3;
            forzar_avanzar = 3;
        }
        
        break;
    
    case 10:
        if (global.controlsnap == 8)
        {
            condicion = 4;
            forzar_avanzar = 4;
        }
        
        break;
    
    case 11:
        if (instance_exists(obj_craneo) && instance_exists(obj_esternon))
        {
            if (obj_craneo.x == 622 && obj_craneo.y == 123 && obj_esternon.x == 607 && obj_esternon.y == 253)
            {
                condicion = 5;
                forzar_avanzar = 5;
            }
        }
        
        break;
    
    case 12:
        if (global.controlsnap == 9)
        {
            condicion = 6;
            forzar_avanzar = 6;
        }
        
        break;
    
    case 14:
        if (global.controlsnap == 10)
        {
            condicion = 7;
            forzar_avanzar = 7;
        }
        
        break;
    
    case 15:
        if (global.controlsnap == 11)
        {
            condicion = 8;
            forzar_avanzar = 8;
        }
        
        break;
    
    case 16:
        if (global.controlsnap == 12)
        {
            condicion = 9;
            forzar_avanzar = 9;
        }
        
        break;
    
    default:
        condicion = 1;
        break;
}

if ((push_cont && global.numero < final) || forzar_avanzar)
{
    if (mensaje == texto[global.numero] && condicion)
    {
        global.numero += 1;
        
        if (global.numero > final)
            global.numero = final;
        
        mensaje = "";
    }
    else
    {
        mensaje = texto[global.numero];
    }
}

if (mensaje == texto[final])
{
    if (!trigerAlarm)
    {
        event_user(0);
        trigerAlarm = 1;
    }
}
