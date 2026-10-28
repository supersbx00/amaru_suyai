global.paso = paso;

switch (paso)
{
    case 0:
        paso = 1;
        break;
    
    case 1:
        paso = 2;
        break;
    
    case 2:
        paso = 3;
        global.puntaje_total = 0;
        global.puntaje_total_descrasheo = 0;
        break;
    
    case 3:
        paso = 4;
        break;
    
    case 4:
        paso = 5;
        break;
    
    case 5:
        paso = 6;
        break;
    
    case 6:
        paso = 7;
        break;
    
    case 7:
        paso = 8;
        break;
    
    case 8:
        paso = 9;
        instance_create(x, y, obj_pause);
        break;
    
    case 9:
        paso = 10;
        break;
    
    case 10:
        paso = 11;
        break;
    
    case 11:
        paso = 12;
        break;
    
    case 12:
        paso = 13;
        break;
    
    case 13:
        paso = 14;
        break;
    
    case 14:
        paso = 15;
        break;
    
    case 15:
        paso = 16;
        break;
    
    case 16:
        paso = 17;
        break;
    
    case 17:
        paso = 18;
        break;
    
    case 18:
        paso = 19;
        break;
    
    case 19:
        paso = 20;
        break;
    
    case 20:
        paso = 21;
        break;
    
    case 21:
        paso = 22;
        break;
    
    case 22:
        paso = 23;
        break;
    
    case 23:
        paso = 24;
        break;
    
    case 24:
        global.cinematica = 1;
        paso = 25;
        break;
    
    case 25:
        paso = 26;
        break;
    
    case 26:
        paso = 27;
        break;
    
    case 27:
        paso = 28;
        break;
    
    case 28:
        paso = 29;
        break;
    
    case 29:
        paso = 30;
        break;
    
    case 30:
        paso = 31;
        break;
    
    case 31:
        paso = 32;
        break;
    
    case 32:
        paso = 33;
        break;
    
    case 33:
        with (obj_pause)
            instance_destroy();
        
        global.escena = 0;
        temp[0] = 1184;
        temp[1] = 384;
        temp[2] = 11;
        ds_list_insert(obj_game.cambio_escena, 0, temp);
        scr_go_to_room(temp[2]);
        exit;
    
    default:
        break;
}

trigger = 0;
