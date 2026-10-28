function scr_text_mensajes() {
if (numero < final)
{
    if (string_length(mensaje) < string_length(texto[numero]))
        mensaje += string_char_at(texto[numero], string_length(mensaje) + 1);
    
    // Z, gamepad o clic, con anti-spam (scr_texto_actualizar); solo cierra si el último texto ya terminó de escribirse
    if (global.texto_confirmar && numero == (final - 1) && string_length(mensaje) == string_length(texto[numero]))
    {
        if (instance_exists(obj_player))
            obj_player.enable_player = 0;
        
        instance_destroy();
    }
}

alarm[0] = 1;
}
