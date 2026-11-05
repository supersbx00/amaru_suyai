var condicion = 0;
var forzar_avanzar = 0;
push_enter = keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_face3);
// Z, gamepad o clic sobre el cuadro, con anti-spam (scr_texto_actualizar)
push_cont = global.texto_confirmar;

switch (global.numero)
{
    case MOMIA_PASO_PIEL:
        if (obj_cuerpo.size == obj_cuerpo.max_size)
        {
            condicion = 1;
            forzar_avanzar = 1;
        }
        
        break;
    
    case MOMIA_PASO_ORGANOS:
        if (instance_number(obj_organo) == 0)
        {
            condicion = 2;
            forzar_avanzar = 2;
        }
        
        break;
    
    case MOMIA_PASO_MADEROS:
        if (global.controlsnap == 6)
        {
            condicion = 3;
            forzar_avanzar = 3;
        }
        
        break;
    
    case MOMIA_PASO_RELLENO:
        if (global.controlsnap == 8)
        {
            condicion = 4;
            forzar_avanzar = 4;
        }
        
        break;
    
    case MOMIA_PASO_CRANEO:
        if (scr_momia_craneo_cerrado())
        {
            condicion = 5;
            forzar_avanzar = 5;
        }
        
        break;
    
    case MOMIA_PASO_ARCILLA:
        if (global.controlsnap == 9)
        {
            condicion = 6;
            forzar_avanzar = 6;
        }
        
        break;
    
    case MOMIA_PASO_FALDELLIN:
        if (global.controlsnap == 10)
        {
            condicion = 7;
            forzar_avanzar = 7;
        }
        
        break;
    
    case MOMIA_PASO_PELO:
        if (global.controlsnap == 11)
        {
            condicion = 8;
            forzar_avanzar = 8;
        }
        
        break;
    
    case MOMIA_PASO_MASCARA:
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
    else if (forzar_avanzar)
    {
        // Solo el puzzle completa el texto al instante; el jugador no puede saltárselo mientras se escribe
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
