draw_self();
dist = point_distance(x, y, obj_player.x, obj_player.y);

if (dist <= 120)
{
    if (gamepad_is_connected(0))
        draw_sprite(spr_boton_a, 0, obj_player.x, obj_player.y - 104);
    else
        draw_sprite(spr_button_A, 0, obj_player.x, obj_player.y - 104);
}
else
{
    count = 0;
}
