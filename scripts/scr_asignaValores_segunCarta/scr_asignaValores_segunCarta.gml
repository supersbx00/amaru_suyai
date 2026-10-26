function scr_asignaValores_segunCarta() {
if (card_morral != undefined)
{
    switch (card_morral[0])
    {
        case 11:
            sprite_index = spr_cardAnzuelo_huesoAve;
            card_morral[0] = sprite_index;
            card_morral[3] = "azul";
            card_morral[4] = 15;
            card_morral[5] = "Anzuelo hueso de Ave";
            card_morral[6] = "Herramienta para el uso de la pesca";
            break;
        
        case 5:
            sprite_index = spr_card_arponHueso;
            card_morral[0] = sprite_index;
            card_morral[3] = "rojo";
            card_morral[4] = 20;
            card_morral[5] = "Arpon de hueso";
            card_morral[6] = "Herramienta para caza de peces y avecillas";
            break;
        
        case 9:
            sprite_index = spr_card_estolicaMadera;
            card_morral[0] = sprite_index;
            card_morral[3] = "rojo";
            card_morral[4] = 16;
            card_morral[5] = "Estolica de Madera";
            card_morral[6] = "Extension de brazo para facilitar la caza terrestre";
            break;
        
        case 1:
            sprite_index = spr_card_anzuelochoro;
            card_morral[0] = sprite_index;
            card_morral[3] = "azul";
            card_morral[4] = 16;
            card_morral[5] = "Anzuelo de concha de Choros";
            card_morral[6] = "Anzuelo confeccionado a base de conchas de choro tallado #y amarrado con una cuerda de fibra vegetal#Artefacto para la captura de peces, normalmente estan amarrados#con piedrecillas para que pueda hundirse en el mar.";
            break;
        
        case 7:
            sprite_index = spr_card_chope;
            card_morral[0] = sprite_index;
            card_morral[3] = "rojo";
            card_morral[4] = 20;
            card_morral[5] = "Chope de lobo de mar";
            card_morral[6] = "Herramienta confeccionada por costillas de lobo marino#esta se utiliza para la extracción de moluscos incrustados en los#roqueríos costeros de la zona.";
            break;
        
        case 16:
            sprite_index = spr_card_agua;
            card_morral[0] = sprite_index;
            card_morral[3] = "especial_agua";
            card_morral[4] = 20;
            card_morral[5] = "Espiritu de agua";
            card_morral[6] = "Espiritu portector del agua.#antiguamente dejaba los cuerpos de las personas ahogadas en la orilla#para luego ser momificados.";
            break;
        
        case 18:
            sprite_index = spr_card_fuego;
            card_morral[0] = sprite_index;
            card_morral[3] = "especial_fuego";
            card_morral[4] = 20;
            card_morral[5] = "Espiritu de Fuego";
            card_morral[6] = "Espiritu de Fuego.#Ilumina el camino para llegar a salvo de los antepasados de la cultura Chinchorro.";
            break;
        
        case 20:
            sprite_index = spr_card_moon;
            card_morral[0] = sprite_index;
            card_morral[3] = "especial_luna";
            card_morral[4] = 20;
            card_morral[5] = "Espiritu de la Luna";
            card_morral[6] = "Espiritu de la Luna.#Ilumina el camino de la noche para sentir la luz de nuestros ancestros.";
            break;
    }
}
}
