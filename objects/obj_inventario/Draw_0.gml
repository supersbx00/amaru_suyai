draw_set_color(c_gray);
draw_sprite(spr_inventario, 0, 0, 0);

for (var i = 0; i < array_length(inventario); i++)
    draw_sprite(spr_objetos, inventario[i], 48, 32 + (i * 67));

if (objetofuera == -4)
    draw_sprite(spr_objetos, mouse_arrastrar, mouse_x, mouse_y);

// Indica la casilla de un objeto que falta poner en el paso actual (mientras no se arrastra nada)
if (mouse_arrastrar == 0)
{
    var desde = 0;
    var hasta = -1;
    
    switch (global.numero)
    {
        case 7: desde = 1; hasta = 6; break;
        case 10: desde = 7; hasta = 8; break;
        case 12: desde = 9; hasta = 9; break;
        case 14: desde = 10; hasta = 10; break;
        case 15: desde = 11; hasta = 11; break;
        case 16: desde = 12; hasta = 12; break;
    }
    
    for (var i = 0; i < array_length(inventario); i++)
    {
        if (inventario[i] >= desde && inventario[i] <= hasta)
        {
            // Pequeño y en la esquina, para que se vea el objeto
            draw_sprite_ext(spr_boton_clic, floor(current_time / 133) mod sprite_get_number(spr_boton_clic), 48 + 20, 32 + (i * 67) + 20, 0.45, 0.45, 0, c_white, 1);
            break;
        }
    }
}
