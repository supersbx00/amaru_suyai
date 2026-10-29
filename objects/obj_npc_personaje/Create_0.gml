event_inherited();

// NPC genérico: sin nombre es decorativo (como en rm_camarones). Con nombre habla (scr_text_npc)
// y, si tiene regalo, entrega ese material una sola vez por partida. Se llenan en el creation code de cada instancia.
nombre = "";
regalo_sprite = -1;
regalo_cantidad = 0;
count = 0;
