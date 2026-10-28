randomize();
itemSapawnRate = 40 * game_get_speed(gamespeed_fps);
itemTimeDif = 5 * game_get_speed(gamespeed_fps);
alarm[0] = itemSapawnRate + random_range(-itemTimeDif, itemTimeDif);
