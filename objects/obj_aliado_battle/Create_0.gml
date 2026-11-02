// Compañero con IA en batalla (scr_batalla_equipo): Suyai, o Amaru si el jugador maneja a Suyai.
// Es un sensor físico: lo tocan los ataques, pero no choca con paredes ni con el personaje controlado.
scr_batalla_sprites("suyai");
sprite_index = spr_b_stand;
image_speed = 0.3;
phy_fixed_rotation = 1;
barHealth = 100;
caido = 0;
hspd = 0;
vspd = 0;
creador = "player1";
distancia = 50;
mov_dest_x = x;
mov_dest_y = y;
mov_vel = 4;
mov_pausa = 30;
esquivados = []; // ataques enemigos ya evaluados para esquivar (scr_batalla_esquivar)
ataque_t = irandom_range(50, 75);
