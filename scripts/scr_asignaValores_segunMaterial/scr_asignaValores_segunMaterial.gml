function scr_asignaValores_segunMaterial() {
switch (sprite_index)
{
    case spr_fibraVegetal:
        material[0] = sprite_index;
        material[1] = "Fibra vegetal";
        material[2] = "Materia prima recolectada para#sujetar las herramientas ocupadas para#la pesca y caza.#Ademas fue utilizada para la confección del#vestuario y campamentos.";
        material[3] = 1;
        break;
    
    case spr_huesoAve:
        material[0] = sprite_index;
        material[1] = "Huesos de ave";
        material[2] = "Resto utilizado para la#confección de herramientas para la caza#marina y terrestre.";
        material[3] = 1;
        break;
    
    case spr_madera:
        material[0] = sprite_index;
        material[1] = "Madera";
        material[2] = "Fragmento recolectado del tallo#del árbol, utilizado para realizar herramientas#de caza y pesca marina.";
        material[3] = 1;
        break;
    
    case spr_choritos:
        material[0] = sprite_index;
        material[1] = "Choros";
        material[2] = "Molusco utilizado para la#elaboración de anzuelo de pesca, para#adornar el cuerpo como la#confección de collares, pulseras, etc.";
        material[3] = 1;
        break;
    
    case spr_costillasLobo:
        material[0] = sprite_index;
        material[1] = "C. lobo de mar";
        material[2] = "Fragmento de hueso utilizado#para confeccionar un chope#(Instrumento para la recolección de mariscos)";
        material[3] = 1;
        break;
    
    case spr_piedras:
        material[0] = sprite_index;
        material[1] = "Piedras";
        material[2] = "Fueron recolectadas en el#medioambiente para ser utilizadas como puntas#de flechas.#Antes de ser agregadas a la flecha, fueron#talladas a mano y luego amarradas formando#un arpón.";
        material[3] = 1;
        break;
    
    default:
        material[0] = sprite_index;
        material[1] = "UNKNOWN";
        material[2] = "scr_asignaValores_segunMaterial para definir extravagante#elemento encontrado";
        material[3] = 1;
}
}
