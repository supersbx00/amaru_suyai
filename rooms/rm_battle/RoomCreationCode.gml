if (instance_exists(obj_enemigo_normal))
{
    with (obj_enemigo_normal)
        instance_destroy();
}

// Grupo de 2 o 3 enemigos según el avance (scr_batalla_enemigos), y Suyai si ya está unida (scr_batalla_equipo)
scr_batalla_enemigos_crear();
scr_batalla_equipo_crear();

if (!instance_exists(obj_control_tutorial))
{
    instance_create(0, 0, cont_item);
    instance_create(0, 0, cont_item1);
}
