morral = ds_list_create();
morralCards = ds_list_create();
morralCards_aux = ds_list_create();
nivelMorral = 1;
limite_inventario = 20;
cantidadMaterial = 0;
cant_tipoMaterial = 0;
cantidadCartas = 0;
cant_tipoCartas = 0;
recipeBook = ds_list_create();
cp_limit = 800;
deck_limit = 27;
mazo_seleccionado[0] = 0;
mazo_seleccionado[1] = undefined;
mazo_seleccionado[2] = undefined;
mazo_seleccionado[3] = 0;
mazo_seleccionado[4] = 0;
mazo_seleccionado_copia = ds_list_create();

for (var a = 0; a < 5; a++)
{
    for (var b = 0; b < 3; b++)
    {
        switch (a)
        {
            case 0:
                mazo[a, b] = "Mazo " + string(b + 1);
                break;
            
            case 1:
                mazo[a, b] = ds_list_create();
                
                for (var i = 0; i < 27; i++)
                {
                    noCard[0] = 13;
                    noCard[1] = undefined;
                    noCard[2] = 0;
                    noCard[3] = "No Type";
                    noCard[4] = 0;
                    noCard[5] = "Sin Nombre";
                    noCard[6] = "Sin Descripcion";
                    ds_list_add(mazo[a, b], noCard);
                }
                
                break;
            
            case 2:
                mazo[a, b] = 0;
                break;
            
            case 3:
                mazo[a, b] = ds_list_create();
                break;
            
            case 4:
                mazo[a, b] = 0;
                break;
        }
    }
}

script_execute(scr_cargar_receta);
global.espiritu_luna = 0;
global.espiritu_agua = 0;
global.espiritu_fuego = 0;
global.khoru = 0;
global.tipo_enemigo = undefined;
