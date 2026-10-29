push_enter = keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_face3);
push_cont = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);
global.iventario = instance_number(obj_inventario);

if (global.prioridad > 13 && !instance_exists(obj_huesos))
{
    if (global.objeto_mouse == -4)
    {
        if (mouse_check_button_pressed(mb_left))
        {
            for (var i = 0; i < instance_number(obj_organo); i++)
            {
                var object = instance_find(obj_organo, i);
                
                if (mouse_x > object.bbox_left && mouse_x < object.bbox_right && mouse_y > object.bbox_top && mouse_y < object.bbox_bottom)
                {
                    global.objeto_mouse = object;
                    offset_x = object.x - mouse_x;
                    offset_y = object.y - mouse_y;
                }
            }
        }
    }
    else
    {
        global.objeto_mouse.x = mouse_x + offset_x;
        global.objeto_mouse.y = mouse_y + offset_y;
        
        if (mouse_check_button_released(mb_left))
            global.objeto_mouse = -4;
    }
}

if (can_snap == global.numero)
{
    switch (global.numero)
    {
        case 6:
            for (var i = 0; i < 6; i++)
            {
                snap[i] = instance_create(posicionX[i], posicionY[i], obj_snap);
                
                switch (i)
                {
                    case 0:
                        snap[i].sprite_index = spr_maderabrazoderecho;
                        break;
                    
                    case 1:
                        snap[i].sprite_index = spr_maderohombro;
                        break;
                    
                    case 2:
                        snap[i].sprite_index = spr_maderabrazoizquierdo;
                        break;
                    
                    case 3:
                        snap[i].sprite_index = spr_maderacadera;
                        break;
                    
                    case 4:
                        snap[i].sprite_index = spr_maderapiernaderecha;
                        break;
                    
                    case 5:
                        snap[i].sprite_index = spr_maderapiernaizquierda;
                        can_snap = 9;
                        break;
                }
            }
            
            break;
        
        case 9:
            for (var i = 6; i < 8; i++)
            {
                snap[i] = instance_create(posicionX[i], posicionY[i], obj_snap);
                
                switch (i)
                {
                    case 6:
                        snap[i].sprite_index = spr_paja;
                        break;
                    
                    case 7:
                        snap[i].sprite_index = spr_pajacabeza;
                        snap[i].depth = -101;
                        break;
                }
            }
            
            can_snap = 11;
            break;
        
        case 11:
            // Fijar el cráneo: Enter o un clic sobre el cuerpo
            if (!push_enter && global.mouse_click && scr_mouse_sobre(spr_cuerpo, 544, 103, 1, 1))
            {
                push_enter = 1;
                global.mouse_click = 0;
            }
            
            if (push_enter)
            {
                if (!instance_exists(obj_huesos))
                {
                    with (instance_create(x, y, obj_craneo))
                    {
                        x = 622;
                        y = 123;
                        depth = -105;
                    }
                    
                    with (instance_create(x, y, obj_esternon))
                    {
                        x = 607;
                        y = 253;
                        depth = -105;
                    }
                }
                
                can_snap = 12;
            }
            
            break;
        
        case 12:
            for (var i = 0; i < 8; i++)
            {
                if (instance_exists(snap[i]))
                {
                    with (snap[i])
                        instance_destroy();
                }
            }
            
            // La arcilla se unta a mano (obj_arcilla_untar), en vez de soltar la pieza sobre una silueta
            instance_create_depth(posicionX[8], posicionY[8], -106, obj_arcilla_untar);
            can_snap = 14;
            break;
        
        case 14:
            snap[9] = instance_create(posicionX[9], posicionY[9], obj_snap);
            snap[9].sprite_index = spr_faldellin;
            snap[9].depth = -107;
            can_snap = 15;
            break;
        
        case 15:
            if (instance_exists(snap[9]))
            {
                with (snap[9])
                    instance_destroy();
            }
            
            snap[10] = instance_create(posicionX[10], posicionY[10], obj_snap);
            snap[10].sprite_index = spr_pelo;
            snap[10].depth = -109;
            can_snap = 16;
            break;
        
        case 16:
            if (instance_exists(snap[10]))
            {
                with (snap[10])
                    instance_destroy();
            }
            
            snap[11] = instance_create(posicionX[11], posicionY[11], obj_snap);
            snap[11].sprite_index = spr_cara;
            snap[11].depth = -111;
            can_snap = 17;
            break;
    }
}
