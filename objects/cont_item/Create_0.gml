randomize();
itemSapawnRate = 40 * room_speed;
itemTimeDif = 5 * room_speed;
alarm[0] = itemSapawnRate + random_range(-itemTimeDif, itemTimeDif);
