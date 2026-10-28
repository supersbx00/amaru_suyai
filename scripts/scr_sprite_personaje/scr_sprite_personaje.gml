// Traduce un sprite de Amaru en el mapa al equivalente del personaje indicado ("amaru" o "suyai").
// Si no hay equivalente, devuelve el mismo sprite.
function scr_sprite_personaje(spr, personaje) {
if (personaje != "suyai")
    return spr;

switch (spr)
{
    case spr_amaru_walk_rightDown:
        return spr_suyai_walk_rightDown;
    
    case spr_amaru_walk_rightTop:
        return spr_suyai_walk_rightTop;
    
    case spr_amaru_stand_rightDown:
        return spr_suyai_stand_rightDown;
    
    case spr_amaru_stand_rightTop:
        return spr_suyai_stand_rightTop;
}

return spr;
}
