function scr_return_hdCard() {
// Acepta el numero de carta original (recetas) o el sprite actual de la carta (inventario/mazo)
var carta = argument0;

if (carta == 1 || carta == spr_card_anzuelochoro)
    return spr_card_anzuelochoro2;

if (carta == 5 || carta == spr_card_arponHueso)
    return spr_card_arponHueso2;

if (carta == 7 || carta == spr_card_chope)
    return spr_card_chope2;

if (carta == 9 || carta == spr_card_estolicaMadera)
    return spr_card_estolicaMadera2;

if (carta == 11 || carta == spr_cardAnzuelo_huesoAve)
    return spr_cardAnzuelo_huesoAve2;

if (carta == 16 || carta == spr_card_agua)
    return spr_card_agua2;

if (carta == 18 || carta == spr_card_fuego)
    return spr_card_fuego2;

if (carta == 20 || carta == spr_card_moon)
    return spr_card_moon2;

return -1;
}
