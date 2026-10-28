// Clic sobre el ícono o Back avanzan la ayuda, solo tras la espera de cada página (lectura directa: obj_game queda desactivado mientras la ayuda está abierta)
var px = camera_get_view_x(view_camera[0]) + 660;
var py = camera_get_view_y(view_camera[0]) + 368;
push = scr_ayuda_puede_avanzar(scr_ayuda_icono_x(sprite_index, px), scr_ayuda_icono_y(sprite_index, py));
image_speed = 0;

if (!tutorial_popUp && global.pause == 3)
    tutorial_popUp = 1;

if (push)
{
    count += 1;
    
    if (count <= 7)
    {
        valor_popUp = valor[count];
        scr_ayuda_espera_reiniciar();
    }
}

if (count > 7)
{
    instance_activate_all();
    global.pause = 0;
    global.mouse_click = 0; // el clic que cierra la ayuda no debe lanzar una carta
    instance_destroy();
}

if (valor_popUp == "atacar")
{
    if (gamepad_is_connected(0))
        sprite_index = spr_popUp_atacar_xbox;
    else
        sprite_index = spr_popUp_atacar;
}

if (valor_popUp == "recargar")
{
    if (gamepad_is_connected(0))
        sprite_index = spr_popUp_recargar_xbox;
    else
        sprite_index = spr_popUp_recargar;
}

if (valor_popUp == "cardbreak")
{
    if (gamepad_is_connected(0))
        sprite_index = spr_popUp_cardBreak_xbox;
    else
        sprite_index = spr_popUp_cardBreak;
}

if (valor_popUp == "null card")
{
    if (gamepad_is_connected(0))
        sprite_index = spr_popUp_nullCard_xbox;
    else
        sprite_index = spr_popUp_nullCard;
}

if (valor_popUp == "rotar mazo")
{
    if (gamepad_is_connected(0))
        sprite_index = spr_popUp_rotarMazo_xbox;
    else
        sprite_index = spr_popUp_rotarMazo;
}

if (valor_popUp == "curar")
    sprite_index = spr_popUp_curar;

if (valor_popUp == "combo")
    sprite_index = spr_popUp_Combo;

if (valor_popUp == "orbe")
{
    if (gamepad_is_connected(0))
        sprite_index = spr_popup_ancestral_xbox;
    else
        sprite_index = spr_popup_ancestral;
}

x = __view_get(0, 0) + (__view_get(2, 0) / 2);
y = __view_get(1, 0) + (__view_get(3, 0) / 2);
