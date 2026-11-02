sprite_index = spr_npc_pesca;
// El del pescado: la pesca
nombre = "npc_pesca";
regalo_sprite = spr_fibraVegetal;
regalo_cantidad = 2;
// El sprite está dibujado más grande que Amaru y Suyai: se achica para que queden del mismo tamaño
image_xscale *= 0.9;
image_yscale *= 0.9;
// Desafío de Khoru: primero hay que hablar con la abuela (la anota obj_khoru_camarones)
requiere = "npc:rm_momificar:anciana";
texto_espera = "npc_espera_abuela";
