// 2 minutos en la sala a 30 fps; máximo por visita
#macro MATERIAL_APARECE 3600
#macro MATERIAL_MAX_VISITA 3
// En rm_momificar solo aparecen los materiales de la momia (obj_materiales) y más rápido, para juntarlos ahí:
// cada 20 s aparecen los que falten para tener 3 en el suelo, sin tope por visita
#macro MATERIAL_APARECE_MOMIFICAR 600
#macro MATERIAL_LOTE_MOMIFICAR 3

// Se ejecuta en obj_game cada frame cuando existe obj_player. En las salas del mapa (no el tutorial),
// cada 2 minutos en la sala aparece un material por donde caminó el personaje en esta visita:
// uno a la vez y hasta 3 por visita (en rm_momificar, ver arriba). Ir a una batalla y volver no cambia la visita.
// T (atajo de prueba): aparece al instante si las reglas lo permiten.
function scr_materiales_aparecer() {
var salas = ["rm_humedal", "rm_costa_humedal", "rm_anzota", "rm_anzota_2", "rm_anzota_3", "rm_cuevas_anzota", "rm_capilla", "rm_camarones", "rm_final_morro", "rm_momificar"];
var nombre = room_get_name(room);
var es_mapa = false;

for (var i = 0; i < array_length(salas); i++)
{
    if (salas[i] == nombre)
        es_mapa = true;
}

if (!es_mapa)
    exit;

// Visita nueva: los que quedaron sin recoger en esta sala (persistente) desaparecen y todo vuelve a cero
if (room != mat_sala)
{
    with (obj_materiales)
    {
        if (aparecido)
            instance_destroy();
    }
    
    mat_sala = room;
    mat_reloj = 0;
    mat_aparecidos = 0;
    mat_actual = noone;
    ds_list_clear(mat_rastro);
}

if (mat_actual != noone && !instance_exists(mat_actual))
    mat_actual = noone;

// Recorrido: puntos por donde pasó el personaje
if ((global.frame_actual mod 10) == 0)
{
    var n = ds_list_size(mat_rastro);
    var ultimo = (n > 0) ? ds_list_find_value(mat_rastro, n - 1) : undefined;
    
    if (ultimo == undefined || point_distance(ultimo[0], ultimo[1], obj_player.x, obj_player.y) > 40)
    {
        ds_list_add(mat_rastro, [obj_player.x, obj_player.y]);
        
        if (ds_list_size(mat_rastro) > 300)
            ds_list_delete(mat_rastro, 0);
    }
}

var momificar = (room == rm_momificar);
var aparece = momificar ? MATERIAL_APARECE_MOMIFICAR : MATERIAL_APARECE;
var lote = momificar ? MATERIAL_LOTE_MOMIFICAR : 1;
var activos = 0;

with (obj_materiales)
{
    if (aparecido)
        activos += 1;
}

if (activos >= lote || (!momificar && mat_aparecidos >= MATERIAL_MAX_VISITA))
    exit;

if (global.pause || global.texto_abierto || global.cinematica != 0 || global.transicion != 0)
    exit;

mat_reloj += 1;

if (keyboard_check_pressed(ord("T")))
    mat_reloj = aparece;

if (mat_reloj < aparece)
    exit;

// Lugar: un punto del recorrido (donde el personaje pudo caminar) lejos de él. El material (origen arriba a la
// izquierda, unos 80x38) se centra en ese punto y todo su rectángulo debe quedar libre de paredes, NPC y otros materiales.
var n = ds_list_size(mat_rastro);
var faltan = lote - activos;

for (var intento = 0; intento < 40 && n > 0 && faltan > 0; intento++)
{
    var punto = ds_list_find_value(mat_rastro, irandom(n - 1));
    var mx = punto[0] - 40;
    var my = punto[1] - 19;
    
    if (point_distance(punto[0], punto[1], obj_player.x, obj_player.y) > 160
        && collision_rectangle(mx - 4, my - 4, mx + 84, my + 42, obj_zone, false, true) == noone
        && collision_rectangle(mx - 24, my - 24, mx + 104, my + 62, obj_materiales, false, true) == noone)
    {
        mat_actual = instance_create(mx, my, obj_materiales);
        mat_actual.aparecido = 1;
        mat_actual.image_alpha = 0;
        mat_aparecidos += 1;
        faltan -= 1;
    }
}

if (faltan < lote - activos)
{
    mat_reloj = 0;
    exit;
}

// Sin lugar todavía: se reintenta en 1 s
mat_reloj = aparece - 30;
}
