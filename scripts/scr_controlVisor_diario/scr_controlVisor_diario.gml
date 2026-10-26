function scr_controlVisor_diario() {
if (subMenu == "personas")
{
    if (posCursor < visorRange_min_diario && visorRange_min_diario == 0)
    {
        if (ds_list_size(listaLogros_personas) > 4)
        {
            visorRange_min_diario = ds_list_size(listaLogros_personas) - 6;
            visorRange_max_diario = ds_list_size(listaLogros_personas) - 1;
            posCursor = ds_list_size(listaLogros_personas) - 1;
        }
        else
        {
            visorRange_min_diario = 0;
            visorRange_max_diario = 5;
        }
    }
    
    if (posCursor < visorRange_min_diario && visorRange_min_diario != 0)
    {
        visorRange_min_diario -= 1;
        visorRange_max_diario -= 1;
    }
    
    if (posCursor > visorRange_max_diario && visorRange_max_diario == (ds_list_size(listaLogros_personas) - 1))
    {
        visorRange_min_diario = 0;
        visorRange_max_diario = 5;
        posCursor = 0;
    }
    
    if (posCursor > visorRange_max_diario && visorRange_max_diario != ds_list_size(listaLogros_personas))
    {
        visorRange_min_diario += 1;
        visorRange_max_diario += 1;
    }
}

if (subMenu == "objetos")
{
    if (posCursor < visorRange_min_diario && visorRange_min_diario == 0)
    {
        if (ds_list_size(listaLogros_objetos) > 4)
        {
            visorRange_min_diario = ds_list_size(listaLogros_objetos) - 6;
            visorRange_max_diario = ds_list_size(listaLogros_objetos) - 1;
            posCursor = ds_list_size(listaLogros_objetos) - 1;
        }
        else
        {
            visorRange_min_diario = 0;
            visorRange_max_diario = 5;
        }
    }
    
    if (posCursor < visorRange_min_diario && visorRange_min_diario != 0)
    {
        visorRange_min_diario -= 1;
        visorRange_max_diario -= 1;
    }
    
    if (posCursor > visorRange_max_diario && visorRange_max_diario == (ds_list_size(listaLogros_objetos) - 1))
    {
        visorRange_min_diario = 0;
        visorRange_max_diario = 5;
        posCursor = 0;
    }
    
    if (posCursor > visorRange_max_diario && visorRange_max_diario != ds_list_size(listaLogros_objetos))
    {
        visorRange_min_diario += 1;
        visorRange_max_diario += 1;
    }
}

if (subMenu == "florafauna")
{
    if (posCursor < visorRange_min_diario && visorRange_min_diario == 0)
    {
        if (ds_list_size(listaLogros_florafauna) > 4)
        {
            visorRange_min_diario = ds_list_size(listaLogros_florafauna) - 6;
            visorRange_max_diario = ds_list_size(listaLogros_florafauna) - 1;
            posCursor = ds_list_size(listaLogros_florafauna) - 1;
        }
        else
        {
            visorRange_min_diario = 0;
            visorRange_min_diario = 5;
        }
    }
    
    if (posCursor < visorRange_min_diario && visorRange_min_diario != 0)
    {
        visorRange_min_diario -= 1;
        visorRange_max_diario -= 1;
    }
    
    if (posCursor > visorRange_max_diario && visorRange_max_diario == (ds_list_size(listaLogros_florafauna) - 1))
    {
        visorRange_min_diario = 0;
        visorRange_max_diario = 5;
        posCursor = 0;
    }
    
    if (posCursor > visorRange_max_diario && visorRange_max_diario != ds_list_size(listaLogros_florafauna))
    {
        visorRange_min_diario += 1;
        visorRange_max_diario += 1;
    }
}
}
