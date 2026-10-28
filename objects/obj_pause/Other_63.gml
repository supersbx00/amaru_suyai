// Respuesta de "Renombrar mazo" (get_string_async en scr_renameDeck)
if (async_load[? "id"] == renombrar_peticion)
{
    if (async_load[? "status"] && string_length(async_load[? "result"]) > 0)
        obj_morral.mazo[0, renombrar_mazo] = async_load[? "result"];
    
    renombrar_peticion = -1;
}
