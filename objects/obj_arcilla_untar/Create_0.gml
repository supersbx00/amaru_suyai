// Paso de la arcilla: el jugador toma el terrón del inventario y lo unta con el clic apretado.
// La capa spr_barro aparece solo por donde pasa la mano; al cubrir el 95 % se completa sola.
ox = x; // (546, 114), donde va la capa de arcilla
oy = y;
ancho = sprite_get_width(spr_barro);
alto = sprite_get_height(spr_barro);
radio = 20;
paso_toque = 6;
celda = 5;
en_mano = 0;
completo = 0;
mascara = -1;
capa = -1;
toques = [];
dibujados = 0;
prev_x = -1;
prev_y = -1;
// Arcilla del morral gastada: cada unidad deja cubrir otro 25 % (scr_momia_materiales)
arcilla_usada = 0;
sin_arcilla = 0;

// Celdas de 5x5 px de la silueta (0 = fuera, 1 = sin cubrir, 2 = cubierta) para medir el porcentaje sin leer la superficie
cols = ceil(ancho / celda);
filas = ceil(alto / celda);
celdas = array_create(cols * filas, 0);
total = 0;
cubiertas = 0;

var surf = surface_create(ancho, alto);
surface_set_target(surf);
draw_clear_alpha(c_black, 0);
gpu_set_blendenable(false);
draw_sprite(spr_barro, 0, 0, 0);
gpu_set_blendenable(true);
surface_reset_target();

var buf = buffer_create(ancho * alto * 4, buffer_fixed, 1);
buffer_get_surface(buf, surf, 0);
surface_free(surf);

for (var j = 0; j < filas; j++)
{
    for (var i = 0; i < cols; i++)
    {
        var cx = min((i * celda) + (celda div 2), ancho - 1);
        var cy = min((j * celda) + (celda div 2), alto - 1);
        
        if (buffer_peek(buf, (((cy * ancho) + cx) * 4) + 3, buffer_u8) > 128)
        {
            celdas[(j * cols) + i] = 1;
            total += 1;
        }
    }
}

buffer_delete(buf);

// Un toque de la mano en coordenadas locales: se guarda para la máscara y marca las celdas dentro del radio
untar = function(lx, ly)
{
    // Sin arcilla para el siguiente 25 % no se unta más
    if (cubiertas >= (total * arcilla_usada / MOMIA_ARCILLA_UNTAR))
    {
        sin_arcilla = 1;
        return;
    }
    
    array_push(toques, lx, ly);
    var i0 = max(0, floor((lx - radio) / celda));
    var i1 = min(cols - 1, floor((lx + radio) / celda));
    var j0 = max(0, floor((ly - radio) / celda));
    var j1 = min(filas - 1, floor((ly + radio) / celda));
    
    for (var j = j0; j <= j1; j++)
    {
        for (var i = i0; i <= i1; i++)
        {
            var k = (j * cols) + i;
            
            if (celdas[k] == 1 && point_distance(lx, ly, (i * celda) + (celda / 2), (j * celda) + (celda / 2)) <= radio)
            {
                celdas[k] = 2;
                cubiertas += 1;
            }
        }
    }
};
