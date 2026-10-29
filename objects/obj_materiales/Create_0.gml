sprite_index = choose(spr_huesoAve, spr_fibraVegetal, spr_madera, spr_costillasLobo, spr_choritos, spr_piedras);

// En la sala de la abuela solo aparecen los materiales del minijuego de la momia (scr_momia_materiales).
// Sale más seguido el que más falta: peso = material suelto que falta para la momia (scr_momia_crudo_falta, menos lo que ya hay en el suelo) + 1.
if (room == rm_momificar)
{
    var falta = scr_momia_crudo_falta();
    var pesos = array_create(array_length(falta), 1);
    var suma = 0;
    
    for (var k = 0; k < array_length(falta); k++)
    {
        var spr = falta[k][0];
        var en_suelo = 0;
        
        with (obj_materiales)
        {
            if (id != other.id && aparecido && sprite_index == spr)
                en_suelo += 1;
        }
        
        pesos[k] += max(0, falta[k][1] - en_suelo);
        suma += pesos[k];
    }
    
    var r = random(suma);
    sprite_index = falta[array_length(falta) - 1][0];
    
    for (var k = 0; k < array_length(falta); k++)
    {
        r -= pesos[k];
        
        if (r < 0)
        {
            sprite_index = falta[k][0];
            break;
        }
    }
}

// Colocados en el mapa: al recogerlos quedan anotados (se guarda con la partida) y no vuelven.
// Los del tutorial los cuenta obj_control_tutorial: esos se destruyen como siempre.
guarda_recogido = (room != rm_tutorial && room != rm_tutorial_test);
clave = room_get_name(room) + ":" + string(xstart) + ":" + string(ystart);
recogido = 0;

// Aparecidos con el tiempo por scr_materiales_aparecer (fundido y brillo al aparecer)
aparecido = 0;
brillo = 0;
