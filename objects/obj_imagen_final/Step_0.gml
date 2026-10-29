// Volver al menú inicial: Enter / Start como siempre, y también "atrás" (clic derecho, Escape o X) como en los demás menús
push = keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_start)
    || global.mouse_atras || keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("X"));

if (push)
{
    global.mouse_atras = 0;
    game_restart();
}
