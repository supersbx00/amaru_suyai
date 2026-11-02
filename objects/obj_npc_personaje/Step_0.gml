depth = -y;

if (nombre == "")
    exit;

var dist = point_distance(x, y, obj_player.x, obj_player.y);

if (dist <= 100)
{
    if (scr_tecla_z() && count == 0)
    {
        // Si ya entregó el regalo o enseñó la receta, la versión "_2" del diálogo no lo vuelve a anunciar
        var dialogo = nombre;
        
        if ((regalo_sprite != -1 || receta != "") && variable_struct_exists(global.materiales_recogidos, "npc:" + room_get_name(room) + ":" + nombre))
            dialogo = nombre + "_2";
        
        bloqueado = (requiere != "" && !variable_struct_exists(global.materiales_recogidos, requiere));
        
        if (bloqueado)
            dialogo = texto_espera;
        
        with (instance_create(x, y, obj_dialogo))
            npc = dialogo;
        
        count++;
    }
    
    // El regalo (o la receta) se entrega al cerrar el primer diálogo, después de leer el aviso; queda anotado con la partida
    if (count == 1 && !instance_exists(obj_dialogo) && !bloqueado && (regalo_sprite != -1 || receta != ""))
    {
        var clave = "npc:" + room_get_name(room) + ":" + nombre;
        
        if (!variable_struct_exists(global.materiales_recogidos, clave))
        {
            global.materiales_recogidos[$ clave] = 1;
            
            if (regalo_sprite != -1)
                scr_morral_agregar(regalo_sprite, regalo_cantidad);
            
            if (receta != "")
            {
                scr_desbloquearRecetas(receta);
                
                for (var i = 0; i < array_length(materiales_receta); i++)
                    scr_morral_agregar(materiales_receta[i][0], materiales_receta[i][1]);
                
                script_execute(scr_guardar_recetas);
            }
            
            script_execute(scr_guardar_datos);
        }
        
        count = 2;
    }
}
else
{
    count = 0;
}
