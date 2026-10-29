// Colocado ya recogido (oculto)
if (recogido)
    exit;

scr_morral_agregar(sprite_index, 1);

if (instance_exists(obj_control_tutorial))
{
    if (obj_control_tutorial.tutorialOn)
        obj_control_tutorial.cantidad_materiales--;
}

// Aparecido: se libera el lugar para el próximo y el reloj vuelve a empezar (scr_materiales_aparecer)
if (aparecido)
{
    with (obj_game)
    {
        mat_actual = noone;
        mat_reloj = 0;
    }
    
    instance_destroy();
}
// Colocado en el mapa: se oculta y queda anotado para siempre en esta partida (Step)
else if (guarda_recogido)
{
    global.materiales_recogidos[$ clave] = 1;
    recogido = 1;
    visible = false;
    phy_active = false;
}
else
{
    instance_destroy();
}
