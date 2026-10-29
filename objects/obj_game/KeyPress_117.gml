// F6 fuera de batalla: muestra u oculta las formas de colisión (en batalla lo hace F3 en obj_battleController)
if (!instance_exists(obj_battleController))
    global.ver_colisiones = !global.ver_colisiones;
