if (!instance_exists(obj_player))
    exit;

// Primer cuadro: delante de Amaru (más abajo en pantalla) y a un costado, mirándolo (el sprite mira a la izquierda).
// Se busca un lugar con los pies fuera de las paredes y el cuerpo entero (180 px sobre los pies) dentro de la vista.
if (!colocado)
{
    colocado = 1;
    var pies = obj_player.y + 45;   // Amaru tiene el origen al centro; Wanku, en los pies
    var opciones = [[95, 70], [-95, 70], [95, 0], [-95, 0]];
    var vista_y = camera_get_view_y(view_camera[0]);
    var elegido = opciones[0];
    
    for (var i = 0; i < array_length(opciones); i++)
    {
        var cx = obj_player.x + opciones[i][0];
        var cy = pies + opciones[i][1];
        
        if (collision_rectangle(cx - 30, cy - 20, cx + 30, cy, obj_pared, false, true) == noone && collision_rectangle(cx - 30, cy - 20, cx + 30, cy, obj_pared_32, false, true) == noone && cy - sprite_height >= vista_y + 10)
        {
            elegido = opciones[i];
            break;
        }
    }
    
    x = obj_player.x + elegido[0];
    y = pies + elegido[1];
    image_xscale = sign(elegido[0]);
}

// Amaru queda quieto mientras Wanku está en pantalla
global.cinematica = 1;

with (obj_player)
{
    hspd = 0;
    vspd = 0;
    destino_activo = 0;
}

switch (estado)
{
    case "aparece":
        image_alpha = min(1, image_alpha + 0.1);
        
        if (image_alpha >= 1 && !instance_exists(obj_dialogo))
        {
            with (instance_create(x, y, obj_dialogo))
                npc = other.npc_texto;
            
            estado = "habla";
        }
        break;
    
    case "habla":
        if (!instance_exists(obj_dialogo))
            estado = "desaparece";
        break;
    
    case "desaparece":
        image_alpha = max(0, image_alpha - 0.1);
        
        if (image_alpha <= 0)
        {
            global.cinematica = 0;
            instance_destroy();
        }
        break;
}
