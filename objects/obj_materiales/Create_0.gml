sprite_index = choose(spr_huesoAve, spr_fibraVegetal, spr_madera, spr_costillasLobo, spr_choritos, spr_piedras);

// Colocados en el mapa: al recogerlos quedan anotados (se guarda con la partida) y no vuelven.
// Los del tutorial los cuenta obj_control_tutorial: esos se destruyen como siempre.
guarda_recogido = (room != rm_tutorial && room != rm_tutorial_test);
clave = room_get_name(room) + ":" + string(xstart) + ":" + string(ystart);
recogido = 0;

// Aparecidos con el tiempo por scr_materiales_aparecer (fundido y brillo al aparecer)
aparecido = 0;
brillo = 0;
