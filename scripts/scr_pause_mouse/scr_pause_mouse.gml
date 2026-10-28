function scr_pause_mouse() {
// Traduce el mouse a las entradas que ya usa obj_pause (posCursor, push_int, push_out, push_lb, push_rb).
// Las zonas salen de las mismas posiciones que usa obj_pause/Draw_0. Solo cuentan los elementos dibujados.
mouse_objetivo = -1;
mouse_boton = "";

if (!global.pause)
    exit;

// Cambio de pantalla: se reinicia el enfriamiento para que una ráfaga no atraviese varias pantallas
var firma = string(menuOptions) + "|" + string(editDeck_phase) + "|" + string(addRemove_card);

if (firma != mouse_firma)
{
    mouse_firma = firma;
    global.mouse_enfriamiento = MOUSE_ENFRIAMIENTO;
    global.mouse_click = 0;
    global.mouse_atras = 0;
    exit;
}

if (instance_exists(obj_popUp) || instance_exists(obj_dialogo) || instance_exists(obj_popup_ayuda) || instance_exists(obj_confirmar))
    exit;

var vx = __view_get(0, 0);
var vy = __view_get(1, 0);
var vw = __view_get(2, 0);
var vh = __view_get(3, 0);
var tutorial = instance_exists(obj_control_tutorial);

var n = 1;

switch (menuOptions)
{
    case "Principal":
    case "Ver cartas":
        n = 1;

        if (menuOptions == "Principal")
        {
            if (tutorial)
                n = (obj_control_tutorial.paso < 12) ? (obj_control_tutorial.paso - 8) : (array_length(menu) - 2);
            else
                n = array_length(menu);
        }

        for (var i = 0; i < n; i++)
        {
            if (scr_mouse_sobre(spr_maderuchaMenu, vx + 136, vy + 32 + ((i + 1) * 60), 0.5, 0.5))
                mouse_objetivo = i;
        }

        break;

    case "Inventario":
        for (var i = 0; i < ds_list_size(obj_morral.morral); i++)
        {
            var col = i mod 4;
            var fil = i div 4;
            var cx = vx + 128 + (124 * col);
            var cy = vy + 215 + (130 * fil);

            if (point_in_rectangle(mouse_x, mouse_y, cx, cy, cx + 123, cy + 129))
                mouse_objetivo = i;
        }

        break;

    case "Recetas":
        if (!readyConstruct)
        {
            n = tutorial ? 1 : ds_list_size(obj_morral.recipeBook);
            n = min(n, ds_list_size(obj_morral.recipeBook));

            for (var i = 0; i < n; i++)
            {
                if (point_in_rectangle(mouse_x, mouse_y, vx + 90, vy + 165 + (30 * i), vx + 400, vy + 194 + (30 * i)))
                    mouse_objetivo = i;
            }
        }

        break;

    case "Editar mazo":
    case "Borrar cartas":
        var listaMazo = obj_morral.mazo_seleccionado[2];

        if (menuOptions == "Editar mazo")
        {
            if (scr_mouse_sobre(spr_botonAdd, (vx + (vw / 2)) - 60, vy + 128, 1, 1))
                mouse_boton = "add";

            if (scr_mouse_sobre(spr_botonOut, vx + (vw / 2) + 60, vy + 128, 1, 1))
                mouse_boton = "out";
        }

        if (addRemove_card == "add" && editDeck_phase == "cardInventory")
        {
            for (var i = 0; i < ds_list_size(obj_morral.morralCards); i++)
            {
                if (scr_mouse_sobre(spr_baseCarta, vx + 98 + (106 * (i mod 3)), vy + 224 + (140 * (i div 3)), 0.49, 0.49))
                    mouse_objetivo = i;
            }
        }
        else if (addRemove_card == "add" && editDeck_phase == "cardCopy")
        {
            for (var col = 0; col < 2; col++)
            {
                for (var fil = 0; fil < 5; fil++)
                {
                    if (scr_mouse_sobre(spr_cardValue_ori, ((vx + (vw / 2)) - 160) + (110 * col), ((vy + (vh / 2)) - 10) + (42 * fil), 1, 1))
                        mouse_objetivo = fil + (5 * col);
                }
            }
        }
        else if ((addRemove_card == "add" && editDeck_phase == "cardDeck" && menuOptions == "Editar mazo") || addRemove_card != "add")
        {
            for (var k = 0; k < 9; k++)
            {
                var idx = visorRange_min + k;

                if (idx <= 26 && idx < ds_list_size(listaMazo))
                {
                    if (scr_mouse_sobre(spr_baseCarta, ((vx + vw) - 400) + (106 * (k mod 3)), vy + 224 + (140 * (k div 3)), 0.5, 0.5))
                        mouse_objetivo = idx;
                }
            }
        }

        break;

    case "Equipar mazo":
    case "Limpiar mazo":
    case "Renombrar mazo":
        for (var i = 0; i < 3; i++)
        {
            if (scr_mouse_sobre(spr_decks, vx + (vw / 4) + (380 * i), vy + (vh / 2) + 150, 1.5, 1.5))
                mouse_objetivo = i;
        }

        break;
}

// Hover (o clic) sobre otra opción: mover el cursor y refrescar igual que con las flechas
if (mouse_objetivo != -1 && mouse_objetivo != posCursor && (global.mouse_movido || global.mouse_click))
{
    posCursor = mouse_objetivo;

    // Igual que obj_game al usar flechas: el texto de ayuda se rehace para la nueva opción
    if (menuOptions == "Principal" && instance_exists(obj_text))
    {
        with (obj_text)
            instance_destroy();
    }

    switch (menuOptions)
    {
        case "Inventario":
            select = ds_list_find_value(obj_morral.morral, posCursor);
            break;

        case "Editar mazo":
        case "Borrar cartas":
            if (addRemove_card == "add")
            {
                if (editDeck_phase == "cardInventory")
                    select = ds_list_find_value(obj_morral.morralCards, posCursor);

                if (editDeck_phase == "cardCopy")
                    calculoCP = scr_valorCP_total(select);
            }
            else
            {
                var cpCartaMazo = ds_list_find_value(obj_morral.mazo_seleccionado[2], posCursor);

                if (cpCartaMazo != undefined)
                    calculoCP = cpCartaMazo[4];

                select = cpCartaMazo;
            }

            break;
    }
}

// Clic izquierdo: sobre una opción = Z; sobre Añadir/Retirar = A/S. Clic derecho = X.
if (global.mouse_click)
{
    if (mouse_boton == "add")
        push_lb = 1;
    else if (mouse_boton == "out")
        push_rb = 1;
    else if (mouse_objetivo != -1)
        push_int = 1;

    global.mouse_click = 0;
}

if (global.mouse_atras)
{
    push_out = 1;
    global.mouse_atras = 0;
}
}
