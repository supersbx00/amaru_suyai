function scr_amaru_clic() {
// Se ejecuta en obj_player cuando puede moverse. Un clic fija el destino que sigue scr_player_move.
// Si el clic cae sobre algo con lo que se puede interactuar, Amaru va hasta ahí y lo activa al llegar.
if (!global.mouse_click || global.pause)
    exit;

global.mouse_click = 0;

// Objetos que se activan con Z estando cerca (usan scr_tecla_z); los obj_info_* de radio largo usan 120
var interactuables = [obj_agua, obj_ayuda, obj_ayuda1, obj_fuego, obj_info_anzota, obj_info_camarones, obj_info_capilla,
    obj_info_capilla1, obj_info_choza, obj_info_junquillo, obj_info_morro, obj_info_oasis, obj_info_rocas, obj_khoru,
    obj_moon, obj_moon1, obj_npc, obj_npc_1, obj_npc_2, obj_npc_3, obj_npc_31, obj_npc_4, obj_npc_estolica,
    obj_npc_pescador, obj_npc_tejedora, obj_tuto_wanku];
var radio_largo = [obj_info_anzota, obj_info_camarones, obj_info_junquillo, obj_info_morro, obj_info_rocas];

objetivo = noone;
radio = 100;

for (var i = 0; i < array_length(interactuables); i++)
{
    // Tolerancia de 24 px alrededor del clic para no tener que apuntar exacto
    var inst = collision_circle(mouse_x, mouse_y, 24, interactuables[i], false, true);
    
    if (inst != noone)
    {
        objetivo = inst;
        
        for (var j = 0; j < array_length(radio_largo); j++)
        {
            if (interactuables[i] == radio_largo[j])
                radio = 120;
        }
        
        break;
    }
}

if (objetivo != noone)
{
    destino_x = objetivo.x;
    destino_y = objetivo.y;
}
else
{
    destino_x = mouse_x;
    destino_y = mouse_y;
}

// Marca en el destino (una sola a la vez)
with (obj_marca_clic)
    instance_destroy();

instance_create(destino_x, destino_y, obj_marca_clic);

destino_activo = 1;
tramo = 0;
atasco_frames = 0;
pos_prev_x = x;
pos_prev_y = y;
}
