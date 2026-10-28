// Acompañante en el mapa: dibuja al personaje que no se controla y sigue el camino del jugador.
// sprite_index guarda el sprite base de Amaru; se traduce al dibujar (scr_sprite_personaje).
distancia_rastro = 80; // px detrás del jugador, medidos sobre el camino recorrido
distancia_minima = 56; // no se acerca más que esto en línea recta
velocidad_max = 8;     // un poco más que el jugador (~7) para alcanzarlo sin saltos
sprite_index = spr_amaru_stand_rightDown;
image_xscale = 1;
image_speed = 0.3;
rastro = ds_list_create(); // puntos [x, y], el más nuevo primero
// Ícono de cambio (spr_cambiar_personaje): aparece sobre la cabeza al pasar el cursor; clic en él = cambio
icono_visible = 0;
icono_frame = 0;
icono_presionado = 0; // frames que se muestra presionado antes de hacer el cambio
icono_x = x;
icono_y = y - 80;
icono_escala = 1.5; // el sprite mide 48 px; se dibuja a 72
icono_radio = 36;

if (instance_exists(obj_player))
    scr_companero_reiniciar_rastro(obj_player.x, obj_player.y);
else
    scr_companero_reiniciar_rastro(x, y);
