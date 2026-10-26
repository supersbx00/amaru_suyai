if (string_length(mensaje) < string_length(texto[global.numero]))
    mensaje += string_char_at(texto[global.numero], string_length(mensaje) + 1);

alarm[0] = 1;
