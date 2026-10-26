draw_set_color(c_gray);
draw_sprite(spr_inventario, 0, 0, 0);

for (var i = 0; i < array_length_1d(inventario); i++)
    draw_sprite(spr_objetos, inventario[i], 48, 32 + (i * 67));

if (objetofuera == -4)
    draw_sprite(spr_objetos, mouse_arrastrar, mouse_x, mouse_y);
