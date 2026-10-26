image_speed = 0;

if (sabias == 0)
{
    sabias = 1;
    instance_deactivate_all(true);
}

if (global.zona == 1)
    maximo = 3;

if (global.zona == 2)
    maximo = 5;

if (global.zona == 3)
    maximo = 7;

if (global.zona == 4)
    maximo = 9;

if (global.zona == 5)
    maximo = 10;

if (global.zona == 6)
    maximo = 13;

push = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_select);

if (push)
{
    count += 1;
    image_index = count;
}

if (count > maximo)
{
    instance_activate_all();
    instance_destroy();
}

depth = -1;
