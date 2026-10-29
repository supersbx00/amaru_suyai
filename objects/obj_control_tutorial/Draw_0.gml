draw_set_halign(fa_center);

// Amaru se sorprende cuando aparece Wanku: un solo "!" con las letras del menú
if (paso == 2)
{
    with (obj_player)
        scr_texto_barro(x, y - 96, "!", 2, 1);
}

if (wanku_help)
    image_speed = 0.3;
