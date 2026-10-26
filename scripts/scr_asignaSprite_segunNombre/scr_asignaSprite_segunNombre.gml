function scr_asignaSprite_segunNombre() {
switch (argument0)
{
    case "Huesos de ave":
        sprite = 63;
        break;
    
    case "Fibra vegetal":
        sprite = 66;
        break;
    
    case "Madera":
        sprite = 64;
        break;
    
    case "Choros":
        sprite = 67;
        break;
    
    case "C. lobo de mar":
        sprite = 68;
        break;
    
    case "Piedras":
        sprite = 69;
        break;
    
    default:
        sprite = undefined;
        break;
}

return sprite;
}
