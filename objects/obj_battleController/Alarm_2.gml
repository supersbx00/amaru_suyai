temp = ds_list_find_value(obj_game.escena_grabada, 0);
script_execute(scr_go_to_room(temp[2]));
script_execute(scr_guardar_cartas);
script_execute(scr_guardar_mazo);
script_execute(scr_guardar_datos);
