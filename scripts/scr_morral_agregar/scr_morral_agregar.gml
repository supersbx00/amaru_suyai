// Agrega `cantidad` unidades del material `spr` al morral y muestra el aviso "+N Nombre" sobre Amaru.
// Lo usan obj_materiales (al recoger del mapa) y los NPC que regalan materiales (obj_npc_personaje).
function scr_morral_agregar(spr, cantidad) {
// scr_asignaValores_segunMaterial lee sprite_index del que llama: se cambia un momento y se restaura
var spr_antes = sprite_index;
sprite_index = spr;
script_execute(scr_asignaValores_segunMaterial);
sprite_index = spr_antes;

var materialExist = 0;

for (var j = 0; j < ds_list_size(obj_morral.morral); j++)
{
    var inventoryMaterial = ds_list_find_value(obj_morral.morral, j);
    
    if (material[0] == inventoryMaterial[0])
    {
        inventoryMaterial[3] += cantidad;
        ds_list_replace(obj_morral.morral, j, inventoryMaterial);
        materialExist = 1;
    }
}

if (!materialExist)
    ds_list_add(obj_morral.morral, [material[0], material[1], material[2], cantidad]);

obj_morral.cantidadMaterial += cantidad;
obj_game.upText = 1;
obj_game.alpha = 1.5;
obj_game.nombreMaterial = material[1];
obj_game.cantidadAviso = cantidad;
}

// Cantidad del material `spr` que hay en el morral (0 si no está)
function scr_morral_cantidad(spr) {
for (var j = 0; j < ds_list_size(obj_morral.morral); j++)
{
    var m = ds_list_find_value(obj_morral.morral, j);
    
    if (m[0] == spr)
        return m[3];
}

return 0;
}

// Quita hasta `cantidad` unidades del material `spr`; si llega a 0 se borra la entrada (como al usar una receta)
function scr_morral_quitar(spr, cantidad) {
for (var j = 0; j < ds_list_size(obj_morral.morral); j++)
{
    var m = ds_list_find_value(obj_morral.morral, j);
    
    if (m[0] == spr)
    {
        var n = min(cantidad, m[3]);
        m[3] -= n;
        obj_morral.cantidadMaterial -= n;
        
        if (m[3] <= 0)
            ds_list_delete(obj_morral.morral, j);
        else
            ds_list_replace(obj_morral.morral, j, m);
        
        return;
    }
}
}
