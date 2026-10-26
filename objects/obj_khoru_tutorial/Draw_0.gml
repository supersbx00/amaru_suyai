draw_self();

if (obj_control_tutorial.paso > 25)
{
    if (real(image_index) <= 1)
        sprite_index = spr_khoru_1;
}

if (obj_control_tutorial.paso == 28)
    image_xscale = -0.89;

if (obj_control_tutorial.paso == 30)
    image_xscale = 0.89;
