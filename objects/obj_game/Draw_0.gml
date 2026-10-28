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
            draw_text_colour(obj_player.x, obj_player.y - 76 - upText, string_hash_to_newline(" + 1 " + string(nombreMaterial)), c_white, c_white, c_white, c_white, alpha);
        }
    }
}

draw_set_colour(c_black);
