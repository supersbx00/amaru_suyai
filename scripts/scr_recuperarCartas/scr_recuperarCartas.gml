// Frames de la animación de regreso de las cartas a la mano tras recargar (30 fps -> 0,8 s)
#macro CARTA_REGRESO_FRAMES 24

function scr_recuperarCartas() {
if (carta_mid != undefined)
{
    if (carta_mid[3] == "recarga" && ds_list_size(playerDeck) < CANTMAXCARDS)
    {
        sprite_index = spr_amaru_battle_carga;
        recuperaCartas += 0.5;
        
        if (recuperaCartas == 30)
        {
            if (cura_usada == 1)
            {
                ds_list_delete(aux_playerDeck, pos);
                cura_usada = 0;
            }
            
            ds_list_copy(playerDeck, aux_playerDeck);
            recuperaCartas = 0;
            apuntador = 0;
            anim_regreso = CARTA_REGRESO_FRAMES;
        }
    }
}
}

// Dibuja una carta de la mano en (px, py) con escala 1.5. La carta de recarga muestra su llenado.
// Mientras anim_regreso > 0, las cartas llegan por turno (orden 0-3) desde abajo, girando sobre su eje y en el plano.
function scr_carta_mano_dibujar(carta, px, py, alpha, orden) {
var frame = (carta[0] == spr_chargCards) ? (recuperaCartas / vecesRecuperarCartas) : carta[1];
var e = 1;

if (anim_regreso > 0)
{
    var t = clamp(((CARTA_REGRESO_FRAMES - anim_regreso) - (orden * 4)) / (CARTA_REGRESO_FRAMES - 12), 0, 1);
    
    if (t <= 0)
        return; // aún no le toca salir
    
    e = 1 - power(1 - t, 3); // llega rápido y frena al asentarse
}

if (e >= 1)
{
    draw_sprite_ext(carta[0], frame, px, py, 1.5, 1.5, 0, c_white, alpha);
    return;
}

var falta = 1 - e;
var giro = falta * 540;                                // vuelta y media sobre su eje vertical
var sx = 1.5 * max(0.08, abs(dcos(giro)));
var ang = falta * 140;

// Los sprites de carta tienen el origen arriba a la izquierda: se gira y voltea alrededor del centro
var mx = sprite_get_width(carta[0]) * sx / 2;
var my = sprite_get_height(carta[0]) * 1.5 / 2;
var cx = px + (sprite_get_width(carta[0]) * 0.75) + (falta * 70);
var cy = py + (sprite_get_height(carta[0]) * 0.75) + (falta * 240);
var dx = (mx * dcos(ang)) + (my * dsin(ang));
var dy = (-mx * dsin(ang)) + (my * dcos(ang));
draw_sprite_ext(carta[0], frame, cx - dx, cy - dy, sx, 1.5, ang, c_white, alpha);
}
