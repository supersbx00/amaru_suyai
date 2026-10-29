if (instance_exists(obj_player))
{
    if (alpha != undefined)
    {
        if (alpha > 0)
        {
            if (alpha <= 1)
                upText += 1;
            
            upText = clamp(upText, 1, 32);
            alpha -= 0.05;
            scr_texto_barro(obj_player.x, obj_player.y - 76 - upText, "+1 " + string(nombreMaterial), 1, alpha);
        }
    }
}

draw_set_colour(c_black);
