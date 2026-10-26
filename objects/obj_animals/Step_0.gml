if (room == rm_humedal)
{
    tiempoSpawn -= 1;
    
    if (tiempoSpawn <= 0)
    {
        instance_create(__view_get(0, 0) + __view_get(2, 0), __view_get(1, 0), obj_animal_gaviota);
        instance_create(__view_get(0, 0) + __view_get(2, 0) + 860, __view_get(1, 0) - 256, obj_animal_gaviota);
        instance_create(__view_get(0, 0) + __view_get(2, 0) + 608, __view_get(1, 0) + 418, obj_animal_gaviota);
        tiempoSpawn = 90;
    }
}
