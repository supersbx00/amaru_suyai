if (gamepad_is_connected(0))
    sprite_index = spr_cuadro_dialogo_xbox;
else
    sprite_index = spr_cuadro_dialogo;

script_execute(scr_text_step);
depth = -1 * room_height;
