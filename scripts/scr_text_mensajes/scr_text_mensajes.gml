function scr_text_mensajes() {
if (numero < final)
{
    if (string_length(mensaje) < string_length(texto[numero]))
        mensaje += string_char_at(texto[numero], string_length(mensaje) + 1);
    
    if (keyboard_check_pressed(ord("Z")) && numero == (final - 1) && string_length(mensaje) == string_length(texto[numero]))
    {
        if (instance_exists(obj_player))
            obj_player.enable_player = 0;
        
        instance_destroy();
    }
    else if (gamepad_button_check_pressed(0, gp_face1) && numero == (final - 1) && string_length(mensaje) == string_length(texto[numero]))
    {
        if (instance_exists(obj_player))
            obj_player.enable_player = 0;
        
        instance_destroy();
    }
}

alarm[0] = 1;
}
