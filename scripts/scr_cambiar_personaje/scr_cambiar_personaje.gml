// Intercambia el personaje controlado con el acompañante: el jugador pasa a la posición del acompañante
// con el otro personaje, y el acompañante pasa a donde estaba el jugador.
function scr_cambiar_personaje() {
if (!global.suyai_unida || !instance_exists(obj_player) || !instance_exists(obj_companero))
    return;

var cx = obj_companero.x;
var cy = obj_companero.y;
var c_spr = obj_companero.sprite_index;
var c_xs = obj_companero.image_xscale;
var px = obj_player.x;
var py = obj_player.y;
var p_spr = obj_player.sprite_index;
var p_xs = obj_player.image_xscale;

with (obj_player)
{
    // Objeto con física: se mueve el cuerpo y se frena por completo para que no vuelva a donde estaba
    phy_speed_x = 0;
    phy_speed_y = 0;
    phy_position_x = cx;
    phy_position_y = cy;
    hspd = 0;
    vspd = 0;
    destino_activo = 0;
    objetivo = noone;
    sprite_index = c_spr;
    image_xscale = c_xs;
}

with (obj_marca_clic)
    instance_destroy();

global.personaje = (global.personaje == "amaru") ? "suyai" : "amaru";
global.cambio_destello = 8; // frames de destello en ambos personajes

with (obj_companero)
{
    x = px;
    y = py;
    sprite_index = p_spr;
    image_xscale = p_xs;
    scr_companero_reiniciar_rastro(cx, cy);
}
}

// Deja el rastro con solo dos puntos: el jugador (en jx, jy) y el acompañante. Se llama desde obj_companero.
function scr_companero_reiniciar_rastro(jx, jy) {
ds_list_clear(rastro);
ds_list_add(rastro, [jx, jy]);
ds_list_add(rastro, [x, y]);
}
