global.numero = 0;
mensaje = "";
// La abuela habla desde su época: sin fechas, nombres de períodos ni términos de arqueólogo ("momificación", "ajuares", "chinchorro")
texto[0] = "Hola de nuevo, joven.";
texto[1] = "Hoy vas a ayudarme a preparar a nuestro#hermano que partió, para que siga#junto a la familia.";
texto[2] = "Esta ceremonia es muy importante para#nuestro grupo, así que hazlo con cuidado.#Yo te iré explicando cada paso.";

if (gamepad_is_connected(0))
    texto[3] = "Primero hay que retirar la piel del cuerpo#(presiona el botón X hasta que la piel#desaparezca por completo).";
else
    texto[3] = "Primero hay que retirar la piel del cuerpo#(haz clic sobre el cuerpo hasta que la piel#desaparezca por completo).";

if (gamepad_is_connected(0))
    texto[4] = "¡Muy bien! Ahora hay que sacar los órganos,#como el cerebro y los pulmones.#Arrástralos al agujero de la pantalla.#[A toma, el stick mueve y B suelta]";
else
    texto[4] = "¡Muy bien! Ahora hay que sacar los órganos,#como el cerebro y los pulmones.#Arrástralos al agujero de la pantalla.#[usa el mouse]";
texto[5] = "Estás aprendiendo bien, pero aún falta#mucho: es un trabajo largo y delicado.";
texto[6] = "Ahora hay que reforzar las articulaciones#con maderos y cuerdas de fibra vegetal.";
if (gamepad_is_connected(0))
    texto[7] = "Busca en el inventario lo necesario para#reforzar las piernas, los brazos#y el tronco.#[A toma la pieza, el stick mueve, B suelta]";
else
    texto[7] = "Busca en el inventario lo necesario para#reforzar las piernas, los brazos#y el tronco.";
texto[8] = "Muy bien, quedó todo firme.";
texto[9] = "Ahora hay que rellenar el cuerpo#con fibra vegetal.";
texto[10] = "Recuerda rellenar el cráneo y el tórax.";
if (gamepad_is_connected(0))
    texto[11] = "Ahora hay que cerrar el cráneo, para que#no se salga el relleno.#(Presiona A sobre el cuerpo o el botón X)";
else
    texto[11] = "Ahora hay que cerrar el cráneo, para que#no se salga el relleno.#(Haz clic sobre el cuerpo para cerrarlo)";
if (gamepad_is_connected(0))
    texto[12] = "Es hora de moldear el cuerpo con arcilla#y volver a ponerle trozos de su piel.#(Toma la arcilla con A y úntala por todo#el cuerpo con el stick; B para parar)";
else
    texto[12] = "Es hora de moldear el cuerpo con arcilla#y volver a ponerle trozos de su piel.#(Toma la arcilla y úntala con la mano#por todo el cuerpo)";
texto[13] = "Por último, le pondremos estas prendas#y adornos como ofrenda, para honrar#y respetar a nuestros ancestros.";
texto[14] = "Primero, el faldellín.";
texto[15] = "Luego, el pelo.";
texto[16] = "Y al final, la máscara.";
texto[17] = "¡Te felicito! Preparaste a nuestro#hermano con mucho respeto.";
texto[18] = "Has ganado una ayuda de los espíritus.#Con esto podremos detener a Khoru.";
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
