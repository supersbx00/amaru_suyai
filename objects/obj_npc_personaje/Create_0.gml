event_inherited();

// NPC genérico: sin nombre es decorativo (como en rm_camarones). Con nombre habla (scr_text_npc)
// y, si tiene regalo, entrega ese material una sola vez por partida. Se llenan en el creation code de cada instancia.
// Con receta (nombre de la receta, data[7] del recipeBook), la enseña al cerrar el primer diálogo (los crea obj_khoru_camarones).
nombre = "";
regalo_sprite = -1;
regalo_cantidad = 0;
receta = "";
materiales_receta = []; // [sprite, cantidad] que entrega junto con la receta: lo justo para fabricar una carta
// Requisito opcional: clave de global.materiales_recogidos que debe existir para hablar de verdad (p. ej. haber hablado con la abuela).
// Mientras falte, dice texto_espera y no entrega nada.
requiere = "";
texto_espera = "";
bloqueado = 0;
count = 0;
