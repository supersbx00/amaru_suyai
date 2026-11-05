push_enter = keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_face3);
push_cont = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);

scr_momia_organos_arrastrar();
scr_momia_paso_avanzar();
