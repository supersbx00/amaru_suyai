if (global.gp == 1)
    gamepad_set_axis_deadzone(0, 0.7);

if (instance_exists(obj_confirmar))
{
    exit;
}
else
{
    up = keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(0, gp_padu);
    down = keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(0, gp_padd);
    var move = 0;
    move -= max(up, 0);
    move += max(down, 0);
    
    if (move != 0)
    {
        menuInicial_cursor += move;
        
        if (menuInicial_cursor < 0)
            menuInicial_cursor = array_length(menuInicial) - 1;
        
        if (menuInicial_cursor > (array_length(menuInicial) - 1))
            menuInicial_cursor = 0;
    }
    
    var push = 0;
    push = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_face1) || gamepad_button_check_pressed(0, gp_start);
    
    // Mouse: pasar por encima mueve el cursor, clic izquierdo sobre la tabla = Z
    var mouse_objetivo = -1;
    
    for (var i = 0; i < array_length(menuInicial); i++)
    {
        if (scr_mouse_sobre(spr_maderuchaMenu, (room_width / 1.6) + 60, ((room_height / 2) - 50) + (menuInicial_paso * i), 1, 1))
            mouse_objetivo = i;
    }
    
    if (mouse_objetivo != -1 && (global.mouse_movido || global.mouse_click))
        menuInicial_cursor = mouse_objetivo;
    
    if (global.mouse_click)
    {
        if (mouse_objetivo != -1)
            push = 1;
        
        global.mouse_click = 0;
    }
    
    if (push)
        global.mouse_enfriamiento = MOUSE_ENFRIAMIENTO;
    
    if (push)
    {
        io_clear();
        
        switch (menuInicial_cursor)
        {
            case 0:
                if (!instance_exists(obj_confirmar))
                {
                    id_confirmar = instance_create(camera_get_view_x(view_camera[0]) + 660, camera_get_view_y(view_camera[0]) + 368, obj_confirmar);
                    id_confirmar.estado = "nuevo";
                }
                
                break;
            
            case 1:
                // Sala de pruebas: sin confirmación, sin preparar partida nueva (scr_recetas borra los guardados) y sin guardar nada
                // El cursor se queda en "Momificar" durante el fundido (no vuelve a "Nueva partida")
                global.modo_prueba = 1;
                scr_go_to_room(rm_momificar);
                exit;
            
            case 2:
                if (file_exists("Escenario.ini"))
                {
                    if (!instance_exists(obj_confirmar))
                    {
                        id_confirmar = instance_create(camera_get_view_x(view_camera[0]) + 660, camera_get_view_y(view_camera[0]) + 368, obj_confirmar);
                        id_confirmar.estado = "cargar";
                    }
                }
                
                break;
            
            case 3:
                room_goto(rm_final_demo);
                break;
            
            default:
                scr_text("Como llegaste hasta aqui??", 1, 108, (room_height / (4/3)) + 30);
                break;
        }
        
        menuInicial_cursor = 0;
    }
}
