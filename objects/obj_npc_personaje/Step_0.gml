depth = -y;

if (nombre == "")
    exit;

var dist = point_distance(x, y, obj_player.x, obj_player.y);

if (dist <= 100)
{
    if (scr_tecla_z() && count == 0)
    {
        // Si ya entregó el regalo, la versión "_2" del diálogo no lo vuelve a anunciar
        var dialogo = nombre;
        
        if (regalo_sprite != -1 && variable_struct_exists(global.materiales_recogidos, "npc:" + room_get_name(room) + ":" + nombre))
            dialogo = nombre + "_2";
        
        with (instance_create(x, y, obj_dialogo))
            npc = dialogo;
        
        count++;
    }
    
    // El regalo se entrega al cerrar el primer diálogo, después de leer "[Recibiste…]"; queda anotado con la partida
    if (count == 1 && !instance_exists(obj_dialogo) && regalo_sprite != -1)
    {
        var clave = "npc:" + room_get_name(room) + ":" + nombre;
        
        if (!variable_struct_exists(global.materiales_recogidos, clave))
        {
            global.materiales_recogidos[$ clave] = 1;
            scr_morral_agregar(regalo_sprite, regalo_cantidad);
            script_execute(scr_guardar_datos);
        }
        
        count = 2;
    }
}
else
{
    count = 0;
}
