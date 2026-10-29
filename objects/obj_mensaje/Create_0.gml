global.numero = 0;
mensaje = "";
texto[0] = " Hola de nuevo joven chinchorro";
texto[1] = " Bienvenido a fines del Periodo Arcaico Temprano#(8000-5000 a.c.) y principios del Periodo Arcaico# Medio(5000-3000 a.c.).";
texto[2] = " La momificación es parte importante de esta# cultura, así que procura realizar bien el# proceso de momificación, para ello te iré# explicando lo que tienes que hacer.";

if (gamepad_is_connected(0))
    texto[3] = " Como primer paso debes de retirar la piel# del cadáver (presionar el boton X#hasta  desvanecer la piel por completo.) ";
else
    texto[3] = " Como primer paso debes de retirar la piel# del cadáver (haz clic sobre el cuerpo#hasta desvanecer la piel por completo.) ";

texto[4] = " ¡Muy Bien!, es hora de quitar los  órganos del cuerpo,#tales como el cerebro, los pulmones, entre otros,#arrastra los organos al agujero que se encuentra#en la pantalla.[usa el mouse]";
texto[5] = " Creo que estas aprendiendo bien  esto, pero# aun falta mucho, es un proceso  bastante # complejo.";
texto[6] = " Es momento de fijar las articulaciones  con# madera y cuerdas de fibra vegetal.";
texto[7] = " Debes de buscar en el inventario lo necesario# para fijar las articulaciones tanto de # las piernas, como brazos y tronco.";
texto[8] = " Al parecer está todo bien fijo.";
texto[9] = " Es momento de rellenar el cuerpo con fibra#vegetal.";
texto[10] = " Recuerda rellenar el cráneo y el tórax.";
texto[11] = " Ahora es momento de fijar el cráneo, no# queremos que a nuestra momia se le caiga el# relleno del cráneo.#(Haz clic sobre el cuerpo para fijar)";
texto[12] = " Es hora de moldear el cuerpo con la arcilla.# Agregándole algunos pedazos de piel.#(Toma la arcilla y úntala con la mano#por todo el cuerpo)";
texto[13] = " Finalmente...# Incorpora estos ajuares y elementos a la momia# como una ofrenda para rendir tributo y respeto# a nuestros ancestros.";
texto[14] = " Primero ponemos un faldellin.";
texto[15] = " Luego ponemos el Pelo de la Momia.";
texto[16] = " Finalmente Colocamos la Máscara.";
texto[17] = " Te Felicito has conseguido realizar el proceso# de momificación con éxito.";
texto[18] = " Haz ganado una ayuda de los espiritus, #con esto podremos detener a Khoru.";
final = 18;

// Pasos en que hay que hacer algo (retirar piel, órganos, inventario, cráneo); avanzan solos al completarse.
// En los demás, un clic en cualquier parte avanza el diálogo (scr_texto_actualizar).
for (var i = 0; i <= final; i++)
    paso_accion[i] = 0;

paso_accion[3] = 1;
paso_accion[4] = 1;
paso_accion[7] = 1;
paso_accion[10] = 1;
paso_accion[11] = 1;
paso_accion[12] = 1;
paso_accion[14] = 1;
paso_accion[15] = 1;
paso_accion[16] = 1;
image_xscale = 1;
image_yscale = 1;
alarm[0] = 1;
trigerAlarm = 0;
dialogo = 0;
