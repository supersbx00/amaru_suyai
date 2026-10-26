var tomaCarta = ds_list_find_value(comboCard_array, apuntador_multiCombo);

if (actionActivate && apuntador_multiCombo < 3)
{
    if (tomaCarta != undefined)
    {
        if (tomaCarta[3] == "rojo")
        {
            actionActivate = 0;
            danho = tomaCarta[1];
            tipo = "normal";
            apuntador_multiCombo++;
            alarm[0] = 10;
        }
        
        if (tomaCarta[3] == "azul")
        {
            actionActivate = 0;
            curar = tomaCarta[1];
            danho = tomaCarta[1];
            apuntador_multiCombo++;
            alarm[1] = 10;
        }
        
        if (tomaCarta[3] == "especial_fuego")
        {
            actionActivate = 0;
            danho = tomaCarta[1];
            tipo = "especial_fuego";
            apuntador_multiCombo++;
            alarm[0] = 10;
        }
        
        if (tomaCarta[3] == "especial_agua")
        {
            actionActivate = 0;
            danho = tomaCarta[1];
            tipo = "especial_agua";
            apuntador_multiCombo++;
            alarm[0] = 10;
        }
        
        if (tomaCarta[3] == "especial_luna")
        {
            actionActivate = 0;
            danho = tomaCarta[1];
            tipo = "especial_luna";
            apuntador_multiCombo++;
            alarm[0] = 10;
        }
    }
}

if (apuntador_multiCombo < 3)
{
    alarm_set(3, 10);
    actionActivate = 1;
}
else
{
    alarm_set(11, 60);
    comboCard_value = 0;
    apuntador_multiCombo = 0;
    ds_list_clear(comboCard_array);
    comparaCarta1 = undefined;
    comparaCarta2 = undefined;
    comparaCarta3 = undefined;
    actionActivate = 1;
}
