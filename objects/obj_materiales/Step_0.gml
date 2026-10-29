// Aparecido con el tiempo: entra con un fundido y parpadea suave unos segundos
if (aparecido)
{
    brillo += 1;
    
    if (brillo <= 15)
        image_alpha = brillo / 15;
    else if (brillo <= 90)
        image_alpha = 0.8 + (0.2 * sin(brillo * 0.3));
    else
        image_alpha = 1;
    
    exit;
}

// Colocado: el estado sale de global.materiales_recogidos (se guarda con la partida), así también se ajusta al cargar
if (!guarda_recogido)
    exit;

if (variable_struct_exists(global.materiales_recogidos, clave))
{
    if (!recogido)
    {
        recogido = 1;
        visible = false;
        phy_active = false;
    }
}
else if (recogido)
{
    // Se cargó una partida donde todavía no se había recogido
    phy_active = true;
    phy_position_x = xstart;
    phy_position_y = ystart;
    visible = true;
    recogido = 0;
}
