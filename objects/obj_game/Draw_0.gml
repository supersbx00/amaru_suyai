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
            scr_texto_barro(obj_player.x, obj_player.y - 76 - upText, "+" + string(cantidadAviso) + " " + string(nombreMaterial), 1, alpha);
        }
    }
}

draw_set_colour(c_black);

// Formas de colisión en el mapa (F6); en batalla las dibuja obj_battleController
if (global.ver_colisiones && !instance_exists(obj_battleController))
    physics_world_draw_debug(phy_debug_render_shapes);
