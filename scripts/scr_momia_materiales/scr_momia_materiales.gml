// Materiales que pide el minijuego de momificación (rm_Momia). Se revisan antes de empezar (obj_npc_1)
// y se gastan al poner cada pieza (obj_inventario) o al untar (obj_arcilla_untar). Las piezas se fabrican en Creación.

// Arcilla para untar todo el cuerpo: cada unidad cubre el 25 %
#macro MOMIA_ARCILLA_UNTAR 4

// Pieza fabricada (Creación) que gasta cada objeto del inventario de la momia: índice = número del objeto
// (1-6 madera, 7-8 relleno, 9 arcilla (se cobra al untar), 10 faldellín, 11 pelo, 12 máscara). [sprite, cantidad] o [] si no cuesta.
function scr_momia_costos() {
return [
    [],
    [spr_momia_palo, 1], [spr_momia_travesano, 1], [spr_momia_palo, 1], [spr_momia_travesano, 1], [spr_momia_palo, 1], [spr_momia_palo, 1],
    [spr_momia_relleno, 1], [spr_momia_relleno, 1],
    [],
    [spr_momia_faldellin, 1],
    [],
    [spr_momia_mascara, 1]
];
}

// Recetas de la pestaña Momificar de Creación: [nombre, sprite de la pieza, [[sprite del material, nombre, cantidad], ...], descripción]
function scr_momia_recetas() {
return [
    ["Palo amarrado", spr_momia_palo, [[spr_madera, "Madera", 1], [spr_fibraVegetal, "Fibra vegetal", 1]], "Refuerza los brazos y las piernas.#Hacen falta 4."],
    ["Travesaño amarrado", spr_momia_travesano, [[spr_madera, "Madera", 1], [spr_fibraVegetal, "Fibra vegetal", 1]], "Refuerza los hombros y la cadera.#Hacen falta 2."],
    ["Relleno vegetal", spr_momia_relleno, [[spr_fibraVegetal, "Fibra vegetal", 1]], "Rellena el cráneo y el tórax.#Hacen falta 2."],
    ["Faldellín", spr_momia_faldellin, [[spr_fibraVegetal, "Fibra vegetal", 2]], "Viste a la momia.#Hace falta 1."],
    ["Máscara", spr_momia_mascara, [[spr_arcilla, "Arcilla", 1]], "Cubre la cara de la momia.#Hace falta 1."]
];
}

// Fabrica la receta `i` de scr_momia_recetas: si alcanzan los materiales los descuenta y suma la pieza al morral.
// Devuelve "" si se fabricó o el texto con lo que falta.
function scr_momia_fabricar(i) {
var receta = scr_momia_recetas()[i];
var mats = receta[2];
var falta = "";

for (var k = 0; k < array_length(mats); k++)
{
    var tiene = scr_morral_cantidad(mats[k][0]);
    
    if (tiene < mats[k][2])
        falta += ((falta == "") ? "" : ", ") + mats[k][1] + " " + string(tiene) + "/" + string(mats[k][2]);
}

if (falta != "")
    return falta;

for (var k = 0; k < array_length(mats); k++)
    scr_morral_quitar(mats[k][0], mats[k][2]);

scr_morral_agregar(receta[1], 1);
return "";
}

// Total del minijuego: [[sprite, nombre, cantidad], ...] con las piezas fabricadas y la arcilla para untar
function scr_momia_total() {
var total = [[spr_momia_palo, "Palo amarrado", 0], [spr_momia_travesano, "Travesaño amarrado", 0], [spr_momia_relleno, "Relleno vegetal", 0],
    [spr_momia_faldellin, "Faldellín", 0], [spr_momia_mascara, "Máscara", 0], [spr_arcilla, "Arcilla", MOMIA_ARCILLA_UNTAR]];
var costos = scr_momia_costos();

for (var i = 0; i < array_length(costos); i++)
{
    if (array_length(costos[i]) == 0)
        continue;
    
    for (var k = 0; k < array_length(total); k++)
    {
        if (total[k][0] == costos[i][0])
            total[k][2] += costos[i][1];
    }
}

return total;
}

// Texto con lo que falta, por ejemplo "Palo amarrado 2/4, Arcilla 1/4" (dos por línea); "" si está todo
function scr_momia_faltantes() {
var total = scr_momia_total();
var texto = "";
var n = 0;

for (var k = 0; k < array_length(total); k++)
{
    var tiene = scr_morral_cantidad(total[k][0]);
    
    if (tiene < total[k][2])
    {
        if (n > 0)
            texto += ((n mod 2) == 0) ? ",#" : ", ";
        
        texto += total[k][1] + " " + string(tiene) + "/" + string(total[k][2]);
        n += 1;
    }
}

return texto;
}

// Cobra el costo del objeto `objeto` del inventario de la momia al quedar puesto
function scr_momia_cobrar(objeto) {
var costos = scr_momia_costos();

if (objeto >= 0 && objeto < array_length(costos) && array_length(costos[objeto]) > 0)
    scr_morral_quitar(costos[objeto][0], costos[objeto][1]);
}

// Materiales sueltos que todavía faltan para la momia, contando las piezas que faltan fabricar (por receta)
// y la arcilla para untar, menos lo que ya hay en el morral: [[sprite, cantidad], ...] de madera, fibra y arcilla.
// Lo usa obj_materiales en rm_momificar para que salga más seguido lo que más falta.
function scr_momia_crudo_falta() {
var crudo = [[spr_madera, 0], [spr_fibraVegetal, 0], [spr_arcilla, MOMIA_ARCILLA_UNTAR]];
var total = scr_momia_total();
var recetas = scr_momia_recetas();

for (var k = 0; k < array_length(total); k++)
{
    for (var r = 0; r < array_length(recetas); r++)
    {
        if (recetas[r][1] != total[k][0])
            continue;
        
        var piezas_faltan = max(0, total[k][2] - scr_morral_cantidad(total[k][0]));
        var mats = recetas[r][2];
        
        for (var m = 0; m < array_length(mats); m++)
        {
            for (var c = 0; c < array_length(crudo); c++)
            {
                if (crudo[c][0] == mats[m][0])
                    crudo[c][1] += piezas_faltan * mats[m][2];
            }
        }
    }
}

for (var c = 0; c < array_length(crudo); c++)
    crudo[c][1] = max(0, crudo[c][1] - scr_morral_cantidad(crudo[c][0]));

return crudo;
}
