if (instance_exists(obj_enemigo_normal))
{
    with (obj_enemigo_normal)
        instance_destroy();
}

if (global.tipo_enemigo == "normal")
    instance_create(832, 448, obj_enemigo);

if (global.tipo_enemigo == "tojone")
    instance_create(832, 448, obj_tojotojone);

if (global.tipo_enemigo == "espiritu_luna")
    instance_create(832, 448, obj_enemigo_luna);

if (global.tipo_enemigo == "espiritu_agua")
    instance_create(832, 448, obj_enemigo_agua);

if (global.tipo_enemigo == "espiritu_fuego")
    instance_create(832, 448, obj_enemigo_fuego);

if (global.tipo_enemigo == "khoru")
    instance_create(832, 448, obj_khoru_battle);

if (!instance_exists(obj_control_tutorial))
{
    instance_create(x, y, cont_item);
    instance_create(x, y, cont_item1);
}
