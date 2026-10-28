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

// Clic sobre el ícono o Back, solo tras la espera de cada página (anti-multiclic)
push = scr_ayuda_puede_avanzar(scr_ayuda_icono_x(sprite_index, x), scr_ayuda_icono_y(sprite_index, y));

if (push)
{
    count += 1;
    image_index = count;
    scr_ayuda_espera_reiniciar();
}

if (count > maximo)
{
    instance_activate_all();
    global.mouse_click = 0; // el clic que cierra la ayuda no debe mover a Amaru
    instance_destroy();
}

depth = -1;
