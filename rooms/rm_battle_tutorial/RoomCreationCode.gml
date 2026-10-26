if (instance_exists(obj_enemigo_normal))
{
    with (obj_enemigo_normal)
        instance_destroy();
}

if (global.tipo_enemigo == "normal")
    instance_create(832, 448, obj_enemigo);

if (global.tipo_enemigo == "espiritu_luna")
    instance_create(832, 448, obj_enemigo_luna);

if (global.tipo_enemigo == "espiritu_agua")
    instance_create(832, 448, obj_enemigo_agua);
