if (completo || !en_mano)
    exit;

// Al llegar al límite de lo pagado se gasta otra arcilla del morral (al tomar el terrón y en el 25, 50 y 75 %)
if (arcilla_usada < MOMIA_ARCILLA_UNTAR && cubiertas >= (total * arcilla_usada / MOMIA_ARCILLA_UNTAR) && scr_morral_cantidad(spr_arcilla) > 0)
{
    scr_morral_quitar(spr_arcilla, 1);
    arcilla_usada += 1;
    sin_arcilla = 0;
}

if (mouse_check_button(mb_left))
{
    var lx = mouse_x - ox;
    var ly = mouse_y - oy;
    
    // Solo cerca de la silueta, para no guardar toques que no pintan nada
    if (lx > -radio && lx < ancho + radio && ly > -radio && ly < alto + radio)
    {
        if (prev_x == -1)
        {
            untar(lx, ly);
        }
        else
        {
            // Toques intercalados para que un movimiento rápido no deje huecos
            var d = point_distance(prev_x, prev_y, lx, ly);
            var n = ceil(d / paso_toque);
            
            for (var k = 1; k <= n; k++)
                untar(lerp(prev_x, lx, k / n), lerp(prev_y, ly, k / n));
        }
        
        prev_x = lx;
        prev_y = ly;
    }
    else
    {
        prev_x = -1;
    }
    
    if (total > 0 && cubiertas >= (total * 0.95))
    {
        completo = 1;
        en_mano = 0;
        global.controlsnap = 9;
        
        if (surface_exists(mascara))
            surface_free(mascara);
        
        if (surface_exists(capa))
            surface_free(capa);
    }
}
else
{
    prev_x = -1;
}
