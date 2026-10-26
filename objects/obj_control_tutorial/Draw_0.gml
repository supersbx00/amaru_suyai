draw_set_halign(fa_center);

if (paso == 1)
{
    with (obj_player)
        draw_text(x, y - 96, string_hash_to_newline("Z Z Z Z"));
}

if (paso == 2)
{
    with (obj_player)
        draw_text(x, y - 96, string_hash_to_newline("!  !  !  !"));
}

if (wanku_help)
    image_speed = 0.3;
