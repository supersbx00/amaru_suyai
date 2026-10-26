function scr_rotarCartas() {
if (apuntador > (ds_list_size(playerDeck) - 1))
    apuntador = 0;

if (argument0)
{
    popUp_on = 0;
    
    if (apuntador < (ds_list_size(playerDeck) - 1))
        apuntador += 1;
    else
        apuntador = 0;
}

if (argument1)
{
    popUp_on = 0;
    
    if (apuntador == 0)
        apuntador = ds_list_size(playerDeck) - 1;
    else
        apuntador -= 1;
}
}
