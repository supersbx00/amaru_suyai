function scr_asignaSprite_segunNombre() {
switch (argument0)
{
    case "Huesos de ave":
        sprite = spr_huesoAve;
        break;
    
    case "Fibra vegetal":
        sprite = spr_fibraVegetal;
        break;
    
    case "Madera":
        sprite = spr_madera;
        break;
    
    case "Choros":
        sprite = spr_choritos;
        break;
    
    case "C. lobo de mar":
        sprite = spr_costillasLobo;
        break;
    
    case "Piedras":
        sprite = spr_piedras;
        break;
    
    case "Arcilla":
        sprite = spr_arcilla;
        break;
    
    default:
        sprite = undefined;
        break;
}

return sprite;
}
