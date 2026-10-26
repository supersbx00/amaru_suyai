draw_sprite(sprite_index, 183, 586, 555);
draw_set_colour(c_black);
draw_set_halign(fa_left);
draw_set_font(general);
draw_text(702, 630, string_hash_to_newline(string(mensaje)));

if (global.numero != 3 && global.numero != 4 && global.numero != 7 && global.numero != 10 && global.numero != 11 && global.numero != 14 && global.numero != 15 && global.numero != 16)
{
    if (gamepad_is_connected(0))
        draw_sprite(spr_siguiente_xbox, 0, 965, 780);
    else
        draw_sprite(spr_siguiente, 0, 965, 780);
}

if (global.numero == 3 || global.numero == 11)
{
    if (gamepad_is_connected(0))
        draw_sprite(spr_botton_x_xbox, 0, 965, 780);
    else
        draw_sprite(spr_enter, 0, 965, 780);
}

if (global.numero == 4 || global.numero == 7 || global.numero == 10 || global.numero == 12 || global.numero == 14 || global.numero == 15 || global.numero == 16)
    draw_sprite(spr_mouse, 0, 965, 780);
