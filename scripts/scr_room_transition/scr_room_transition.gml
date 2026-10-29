function scr_room_transition() {
fadeAlpha = clamp(fadeAlpha + (fadeState * fadeSpeed), 0, 1);

if (fadeAlpha == 1)
{
    if (global.ide != undefined && instance_exists(global.ide))
    {
        with (global.ide)
            instance_destroy();
    }
    
    // Las salas del mapa son persistentes: al volver, la física rehace los cuerpos circulares y no acepta
    // escala distinta por eje (image_xscale -1). Recuperan su orientación al moverse.
    with (obj_player)
        image_xscale = 1;

    with (obj_enemigo_normal)
        image_xscale = 1;

    room_goto(tempTarget);
    fadeState = -1;
}

if (fadeState == -1)
    instance_destroy();

draw_set_colour(c_black);
draw_set_alpha(fadeAlpha);
draw_rectangle(__view_get(0, 0), __view_get(1, 0), __view_get(0, 0) + __view_get(2, 0), __view_get(1, 0) + 810, false);
draw_set_alpha(1);
}
