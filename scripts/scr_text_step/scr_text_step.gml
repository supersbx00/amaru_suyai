function scr_text_step() {
x = __view_get(0, 0) + 640;
y = __view_get(1, 0) + 640;

// Z, gamepad o clic, con anti-spam (scr_texto_actualizar); solo avanza si el texto ya terminó de escribirse
if (global.texto_confirmar)
{
    if (numero < final && mensaje == texto[numero])
    {
        numero += 1;
        mensaje = "";
    }
}
}
