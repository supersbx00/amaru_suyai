// game_restart (tras una derrota o el final) no detiene el audio: se corta todo para no arrastrar snd_defeat al menú
audio_stop_all();

// En el menú de inicio suena snd_espiritus; al salir del menú, Step cambia a la música de la zona
sound = (room == rm_menu) ? snd_espiritus : snd_background; // música actual (antes índice GMS1 1)
audio_play_sound(sound, 10, true);
count = 0;
