// [reconstruccion] Codigo global de GMS 2.0 (chunk GLOB), se ejecuta al iniciar el juego en orden.
// gml_GlobalScript_0
__init_action();
// gml_GlobalScript_1
__global_object_depths();
// gml_GlobalScript_2
__init_global();

// [reconstruccion] El codigo usa indices numericos de room (scr_go_to_room(7), obj_cartel_room).
// Comprueba que el IDE asigno los mismos indices que el juego original.
var __rooms_originales = ["rm_menu", "rm_tutorial_test", "rm_tutorial", "rm_Momia", "rm_battle", "rm_battle_tutorial", "rm_anzota_2", "rm_cuevas_anzota", "rm_anzota_3", "rm_anzota", "rm_capilla", "rm_humedal", "rm_costa_humedal", "rm_final_morro", "rm_camarones", "rm_final_demo"];
for (var __i = 0; __i < array_length(__rooms_originales); __i++) {
    if (room_get_name(__i) != __rooms_originales[__i]) {
        show_debug_message("[reconstruccion] AVISO: la room " + string(__i) + " deberia ser " + __rooms_originales[__i] + " y es " + room_get_name(__i));
    }
}
