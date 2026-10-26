if (transparencia <= 1 && tiempoVida > 0)
    transparencia += 0.075;

if (transparencia >= 1 && tiempoVida > 0)
    tiempoVida -= 1;

if (tiempoVida <= 0)
    transparencia -= 0.075;

image_alpha = transparencia;
draw_set_alpha(transparencia);
draw_set_halign(fa_center);
draw_set_colour(c_white);

switch (valorTexto)
{
    case "guardar":
        draw_sprite(spr_popUp_guardar, 0, __view_get(0, 0) + (__view_get(2, 0) / 2), (__view_get(1, 0) + (__view_get(3, 0) / 2)) - 50);
        break;
    
    case "material creado":
        draw_sprite(spr_popUp_creaCarta, 0, __view_get(0, 0) + (__view_get(2, 0) / 2), (__view_get(1, 0) + (__view_get(3, 0) / 2)) - 50);
        break;
    
    default:
        draw_text(__view_get(0, 0) + (__view_get(2, 0) / 2), (__view_get(1, 0) + (__view_get(3, 0) / 2)) - 50, string_hash_to_newline("obj_popUp_Draw_1#Mistake Here"));
}
