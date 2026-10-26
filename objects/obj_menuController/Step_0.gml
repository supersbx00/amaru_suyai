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
            menuInicial_cursor = array_length_1d(menuInicial) - 1;
        
        if (menuInicial_cursor > (array_length_1d(menuInicial) - 1))
            menuInicial_cursor = 0;
    }
    
    var push = 0;
    push = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_face1) || gamepad_button_check_pressed(0, gp_start);
    
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
                if (file_exists("Escenario.ini"))
                {
                    if (!instance_exists(obj_confirmar))
                    {
                        id_confirmar = instance_create(camera_get_view_x(view_camera[0]) + 660, camera_get_view_y(view_camera[0]) + 368, obj_confirmar);
                        id_confirmar.estado = "cargar";
                    }
                }
                
                break;
            
            case 2:
                room_goto(rm_final_demo);
                break;
            
            case 3:
                break;
            
            default:
                scr_text("Como llegaste hasta aqui??", 1, 108, (room_height / (4/3)) + 30);
                break;
        }
        
        menuInicial_cursor = 0;
    }
}
