function scr_tecla_z() {
// Z para iniciar una interacción: teclado, gamepad o la Z virtual de Amaru al llegar a un NPC clicado
return keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1) || global.z_virtual;
}
