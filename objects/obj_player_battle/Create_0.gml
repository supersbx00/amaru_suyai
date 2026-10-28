personaje_sprite = "Amaru";
phy_fixed_rotation = 1;
combo = 0;
breaker = 0;
color = 16777215;
alpha = 1;
count = 0;
curar = 0;
barHealtant = 0;
create = 0;
escudo_whanku = 0;
playerDeck = ds_list_create();
aux_playerDeck = ds_list_create();
colaCartas = ds_list_create();
posCola = 0;
comboCard_array = ds_list_create();
comboCard_value = 0;
comparaCarta1 = undefined;
comparaCarta2 = undefined;
comparaCarta3 = undefined;
apuntador = 0;
vecesRecuperarCartas = 1;
recuperaCartas = 0;
anim_regreso = 0; // frames que faltan de la animación de regreso de cartas (scr_recuperarCartas)
cartaUsada = undefined;

for (var i = 0; i < 30; i++)
{
    var rastreaCards = ds_list_find_value(obj_morral.mazo_seleccionado[2], i);
    
    if (rastreaCards[0] != 13)
        ds_list_add(playerDeck, rastreaCards);
    else
        i = 100;
}

with (instance_create(x, y, obj_card))
{
    sprite_index = spr_chargCards;
    image_index = 0;
    card_inDeck[0] = sprite_index;
    card_inDeck[1] = image_index;
    card_inDeck[2] = -2;
    card_inDeck[3] = "recarga";
    ds_list_add(obj_player_battle.playerDeck, card_inDeck);
    instance_destroy();
}

with (instance_create(x, y, obj_card))
{
    sprite_index = spr_cardsNull;
    image_index = 0;
    card_inDeck[0] = sprite_index;
    card_inDeck[1] = image_index;
    card_inDeck[2] = 99;
    card_inDeck[3] = "anulacion";
    ds_list_add(obj_player_battle.playerDeck, card_inDeck);
    instance_destroy();
}

ds_list_copy(aux_playerDeck, playerDeck);
CANTMAXCARDS = ds_list_size(playerDeck);
readyPhase1 = 0;
alarmTrigger = 0;
player_cardBreaked = 0;
barHealth = 100;
actionActivate = 1;
apuntador_multiCombo = 0;
anulable = 0;
player_cardBreaked = 0;
rebotado = 0;
hspd = 0;
vspd = 0;
p_hspd = 0;
creador = "player1";
flecha_id = -4;
can_atk = 0;
add = 0;
popUp_on = 0;
scale_x = 1;
go_luna = 0;
go_agua = 0;
go_fuego = 0;
cura_usada = 0;
pos = 0;
distancia = 50;
tipo = undefined;
addCard = 0;
addComboCard = 0;
trigger_teclado = 1;
ancestral = 0;
create_ancestral = 0;
sprite_personaje = 91;
rueda_sensibilidad = 6; // frames mínimos entre dos rotaciones con la rueda del mouse
rueda_espera = 0;
tutorial_rotado = 0;
