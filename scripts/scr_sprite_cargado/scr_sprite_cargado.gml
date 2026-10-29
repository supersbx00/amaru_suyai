// Lee un sprite guardado en el .ini abierto: primero por nombre (guardados nuevos),
// si no por número (guardados anteriores). Devuelve la referencia del sprite o el número leído.
function scr_sprite_cargado(seccion, clave_nombre, clave_numero) {
var nombre = ini_read_string(seccion, clave_nombre, "");

if (nombre != "")
{
    var spr = asset_get_index(nombre);
    
    if (spr != -1 && sprite_exists(spr))
        return spr;
}

return ini_read_real(seccion, clave_numero, 0);
}
