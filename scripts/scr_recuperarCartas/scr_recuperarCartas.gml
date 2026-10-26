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
        }
    }
}
}
