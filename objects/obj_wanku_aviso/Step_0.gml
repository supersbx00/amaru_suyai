if (!instance_exists(obj_player))
    exit;

var px = obj_player.x;
var py = obj_player.y;

// Para volver a avisar, Amaru tiene que haber salido del radio (evita repetirlo pegado a una pared)
if (!fuera && estado == "espera")
{
    var cerca = instance_nearest(px, py, obj_enemigo_normal1);
    
    if (cerca == noone || point_distance(px, py, cerca.x, cerca.y) > distancia + 40)
        fuera = 1;
}

switch (estado)
{
    case "espera":
        if (fuera && !global.suyai_unida && !instance_exists(obj_dialogo) && !global.pause && global.cinematica == 0 && global.transicion == 0)
        {
            var cerca = instance_nearest(px, py, obj_enemigo_normal1);
            
            if (cerca != noone && point_distance(px, py, cerca.x, cerca.y) < distancia)
            {
                enemigo = cerca;
                fuera = 0;
                global.cinematica = 1;
                
                with (obj_player)
                {
                    hspd = 0;
                    vspd = 0;
                    destino_activo = 0;
                }
                
                // A un costado de Amaru, del lado opuesto al enemigo, mirándolo
                var lado = (px < enemigo.x) ? -1 : 1;
                x = px + 70 * lado;
                y = py;
                image_xscale = lado;   // el sprite mira a la izquierda
                image_alpha = 0;
                estado = "aparece";
            }
        }
        break;
    
    case "aparece":
        image_alpha = min(1, image_alpha + 0.1);
        
        if (image_alpha >= 1)
        {
            with (instance_create(x, y, obj_dialogo))
                npc = other.npc_texto;
            
            estado = "habla";
        }
        break;
    
    case "habla":
        if (!instance_exists(obj_dialogo))
        {
            pasos_empuje = 0;
            estado = "empuja";
        }
        break;
    
    case "empuja":
        pasos_empuje += 1;
        
        if (instance_exists(enemigo))
        {
            var dir = point_direction(enemigo.x, enemigo.y, px, py);
            
            with (obj_player)
            {
                phy_position_x += lengthdir_x(6, dir);
                phy_position_y += lengthdir_y(6, dir);
            }
        }
        
        if (!instance_exists(enemigo) || point_distance(px, py, enemigo.x, enemigo.y) > distancia + 40 || pasos_empuje >= 30)
            estado = "desaparece";
        break;
    
    case "desaparece":
        image_alpha = max(0, image_alpha - 0.1);
        
        if (image_alpha <= 0)
        {
            global.cinematica = 0;
            enemigo = noone;
            estado = "espera";
        }
        break;
}
