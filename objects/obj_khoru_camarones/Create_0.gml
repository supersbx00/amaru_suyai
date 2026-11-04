event_inherited(); // obj_zone: Amaru choca con sus hijos (obj_player/Collision_obj_zone)

// Desafío de Khoru en rm_momificar. Lleva la secuencia con global.desafio_camarones (ver obj_game/Create_0):
// 0 intro de Wanku -> 1 esperando los 4 regalos -> 2 Khoru desafía (batalla PvE) -> 3 ganó: premio -> 4 terminado (NPC de recetas en la sala).
// Lo crea el código de creación de la sala una sola vez (la sala es persistente). Configurable para reusarlo en otra sala.
image_alpha = 0;
image_speed = 0.3;
// Cuerpo físico estático (caja centrada en el dibujo, ver .yy). La sala es persistente: el cuerpo no puede tener escala
// negativa ni distinta por eje (el juego cae al volver de la batalla), así que la escala y hacia dónde mira solo se aplican al dibujar.
phy_fixed_rotation = 1;
// Mientras no se ve, el cuerpo queda fuera de la sala; al aparecer se mueve al punto (el cuerpo siempre está activo)
fuera_x = -500;
fuera_y = -500;
phy_position_x = fuera_x;
phy_position_y = fuera_y;
escala_x = 1;          // misma escala que Khoru en el tutorial
escala_y = 1;
mira = 1;              // 1: mira a la derecha (isométrico, como está dibujado spr_khoru_1; por defecto); -1: a la izquierda
fase = "";             // dentro del estado: "humo", "llama", "espera", "habla", "batalla", "premio", "sale", "guia", "fin"
efecto = 0;            // cuadros del humo oscuro con que aparece (ver Draw)
duracion_humo = 70;
desafio_dicho = 0;     // el desafío completo ya se dijo una vez (después, la versión corta)

enemigo_tipo = "tojone";
// Aparece al medio de la playa (no junto a Amaru), llama a Amaru y espera que llegue a hablarle
punto_aparicion = [1465, 297];   // elegido por el usuario (entre 1432,305 y 1498,288)
// Cartas que entrega Wanku si el mazo no alcanza para el desafío (como las del tutorial): número de carta legado y cantidad
cartas_inicio = [5, 5];   // 5 = Arpón de hueso
cartas_minimas = 5;       // cartas equipadas en el mazo para poder empezar el desafío
cartas_dadas = 0;
// Khoru aparece cuando Amaru habló con la abuela (obligatoria y primera) y con `regalos_minimos` de estos NPC
regalos = ["npc_costa", "npc_moluscos", "npc_arcilla", "npc_pesca"];
regalos_minimos = 2;
clave_anciana = "npc:rm_momificar:anciana";
// Premio al ganar: [sprite del material, cantidad]. Con los regalos de los NPC completa la momia (piezas y arcilla para untar)
premio = []; // [[sprite, cantidad], ...]: lo que falta para la momia al ganar (calcular_premio)
// NPC que enseñan recetas al terminar: [sprite, x, y, clave de texto, receta (data[7] del recipeBook), materiales para una carta]
npcs_recetas = [
    [spr_npc_pesca, 680, 520, "receta_anzuelo_hueso", "Anzuelo hueso de ave", [[spr_fibraVegetal, 2], [spr_huesoAve, 3]]],   // orilla del mar
    [spr_npc_pescador, 1540, 600, "receta_anzuelo_concha", "Anzuelo de concha", [[spr_fibraVegetal, 1], [spr_choritos, 2]]], // rocas del centro
    [spr_npc_stand, 2040, 560, "receta_chope", "Chope Lobo de mar", [[spr_fibraVegetal, 3], [spr_costillasLobo, 1]]],       // rocas de la derecha
    [spr_cazador, 1160, 330, "receta_estolica", "Estolica de Madera", [[spr_madera, 3], [spr_fibraVegetal, 2]]]             // tierra adentro
];
texto_intro = "wanku_camarones_intro";
texto_llamado = "khoru_camarones_llamado";
texto_desafio = "khoru_camarones_desafio";
texto_desafio_2 = "khoru_camarones_desafio_2";
texto_premio = "khoru_camarones_premio";
texto_guia = "wanku_camarones_guia";

// Crea los NPC de recetas (sin duplicar: se reconocen por su nombre)
crear_npcs_recetas = function()
{
    for (var i = 0; i < array_length(npcs_recetas); i++)
    {
        var dato = npcs_recetas[i];
        var existe = false;
        
        with (obj_npc_personaje)
        {
            if (nombre == dato[3])
                existe = true;
        }
        
        if (!existe)
        {
            with (instance_create(dato[1], dato[2], obj_npc_personaje))
            {
                sprite_index = dato[0];
                nombre = dato[3];
                receta = dato[4];
                materiales_receta = dato[5];
                // Los sprites de los NPC están dibujados más grandes que Amaru y Suyai, como los demás de la sala
                image_xscale *= 0.9;
                image_yscale *= 0.9;
            }
        }
    }
};

// Suma `cantidad` cartas del número legado `carta` al inventario, igual que la entrega de Wanku en el tutorial (obj_tuto_wanku)
dar_cartas = function(carta, cantidad)
{
    repeat (cantidad)
    {
        with (instance_create(x, y, obj_card))
        {
            card_morral[0] = carta;
            card_morral[1] = irandom_range(5, 7);
            card_morral[2] = card_morral[1];
            card_morral[3] = "No type";
            card_morral[4] = "No CP";
            card_morral[5] = "No name";
            card_morral[6] = "No description";
            scr_asignaValores_segunCarta();
            var cardExist = 0;
            
            for (var j = 0; j < ds_list_size(obj_morral.morralCards); j++)
            {
                var inventoryCard = ds_list_find_value(obj_morral.morralCards, j);
                
                if (card_morral[5] == inventoryCard[5])
                {
                    var copys_inventoryCard = inventoryCard[2];
                    copys_inventoryCard[card_morral[2]] += 1;
                    inventoryCard[2] = copys_inventoryCard;
                    ds_list_replace(obj_morral.morralCards, j, inventoryCard);
                    cardExist = 1;
                }
            }
            
            if (!cardExist)
            {
                var copys = array_create(10, 0);
                copys[card_morral[2]] += 1;
                var data_card_inventory = [card_morral[0], card_morral[1], copys, card_morral[3], card_morral[4], card_morral[5], card_morral[6]];
                ds_list_add(obj_morral.morralCards, data_card_inventory);
            }
            
            obj_morral.cantidadCartas += 1;
            instance_destroy();
        }
    }
};

// Abre la pausa directo en un submenú, como si se eligiera en el menú (scr_menu): "Editar mazo" (Ver cartas)
// o "Creación" en la pestaña `pestana` con la flecha en la primera receta
abrir_menu = function(opcion, pestana)
{
    with (obj_pause)
    {
        if (global.pause)
            exit;
        
        scr_pause_control();
        
        if (!global.pause)
            exit;
        
        posCursor = 0;
        menuPrincipal = 0;
        menuOptions = opcion;
        
        if (opcion == "Editar mazo")
            menuCartas = 1;
        
        if (opcion == "Creación")
        {
            subCreacion = pestana;
            creacion_foco = "pestana"; // la flecha parte en la pestaña (A, Enter o clic bajan a la primera pieza)
        }
        
        io_clear();
    }
};

// Premio de la primera oleada: justo la madera, fibra y arcilla que faltan para fabricar todas las piezas de la momia
// y untarla (scr_momia_crudo_falta), según el morral en ese momento. El texto va en global.khoru_premio_texto.
calcular_premio = function()
{
    var nombres = [[spr_madera, "Madera"], [spr_fibraVegetal, "Fibra vegetal"], [spr_arcilla, "Arcilla"]];
    var falta = scr_momia_crudo_falta();
    var partes = [];
    premio = [];
    
    for (var i = 0; i < array_length(falta); i++)
    {
        if (falta[i][1] <= 0)
            continue;
        
        array_push(premio, falta[i]);
        
        for (var k = 0; k < array_length(nombres); k++)
        {
            if (nombres[k][0] == falta[i][0])
                array_push(partes, string(falta[i][1]) + " " + nombres[k][1]);
        }
    }
    
    var lista = "";
    
    for (var i = 0; i < array_length(partes); i++)
    {
        if (i > 0)
            lista += (i == array_length(partes) - 1) ? " y " : ", ";
        
        lista += partes[i];
    }
    
    global.khoru_premio_texto = (lista == "") ? "" : "[Recibiste " + lista + "].";
};

abuela_menu = 0;

// La anciana de esta sala (obj_npc_1, compartido con la historia) se presenta solo la primera vez; después responde
// corto según el avance (scr_text_npc: anciana_falta, anciana_materiales, anciana_lista)
with (obj_npc_1)
{
    texto_anciana = function()
    {
        if (!variable_struct_exists(global.materiales_recogidos, "npc:rm_momificar:anciana"))
            return falta_material ? "npc1_falta" : nombre;
        
        if (!falta_material)
            return "anciana_lista";
        
        var crudo = scr_momia_crudo_falta();
        
        for (var i = 0; i < array_length(crudo); i++)
        {
            if (crudo[i][1] > 0)
                return "anciana_falta";
        }
        
        return "anciana_materiales";
    };
}   // ya se abrió Creación → Momificar en esta conversación con la anciana

if (global.desafio_camarones >= 4)
{
    fase = "fin";
    crear_npcs_recetas();
}
