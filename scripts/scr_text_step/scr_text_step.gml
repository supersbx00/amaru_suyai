function scr_text_step() {
x = __view_get(0, 0) + 640;
y = __view_get(1, 0) + 640;

if (keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1))
{
    if (numero < final && mensaje == texto[numero])
    {
        numero += 1;
        mensaje = "";
    }
}
}
