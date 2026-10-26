x = (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0] / 2)) - 330;
y = camera_get_view_y(view_camera[0]) + 110;

if (valor_room == 11 || valor_room == 12 || valor_room == 1)
    sprite_index = spr_titulo_humedal;
else if (valor_room == 6 || valor_room == 8 || valor_room == 7)
    sprite_index = spr_titulo_cuevasAnzota;
else if (valor_room == 9 || valor_room == 10)
    sprite_index = spr_titulo_capilla;
else if (valor_room == 14)
    sprite_index = spr_titulo_camarones;
else if (valor_room == 13)
    sprite_index = spr_titulo_costadoMorro;

if (upAlpha == 1 && image_alpha < 3)
    image_alpha += 0.05;

if (image_alpha >= 3 && upAlpha)
{
    upAlpha = 0;
    alarm[1] = 120;
}

if (image_alpha > 0 && upAlpha == 0)
    image_alpha -= 0.05;
