if (!instance_exists(obj_player))
    exit;

depth = -y;
var libre = !instance_exists(obj_dialogo) && !instance_exists(obj_wanku_guia) && global.transicion == 0 && !global.pause;

// Por defecto mira a la derecha; mientras habla con Amaru, lo mira a él
var hablando = instance_exists(obj_dialogo) && (fase == "llama" || fase == "habla" || fase == "premio");
mira = (hablando && obj_player.x < x) ? -1 : 1;

switch (global.desafio_camarones)
{
    case 0:
        // Primera entrada: Wanku presenta Camarones
        if (libre && global.cinematica == 0)
        {
            with (instance_create(x, y, obj_wanku_guia))
                npc_texto = other.texto_intro;
            
            global.desafio_camarones = 1;
        }
        break;
    
    case 1:
        // La abuela (obj_npc_1, también en la historia: no se toca) queda anotada apenas Amaru le habla
        if (!variable_struct_exists(global.materiales_recogidos, clave_anciana) && instance_exists(obj_npc_1) && obj_npc_1.count >= 1)
            global.materiales_recogidos[$ clave_anciana] = 1;
        
        // Aparece cuando Amaru habló con la abuela y con al menos 2 NPC más (3 en total)
        if (libre && global.cinematica == 0)
        {
            var hablados = 0;
            
            for (var i = 0; i < array_length(regalos); i++)
            {
                if (variable_struct_exists(global.materiales_recogidos, "npc:" + room_get_name(room) + ":" + regalos[i]))
                    hablados += 1;
            }
            
            if (variable_struct_exists(global.materiales_recogidos, clave_anciana) && hablados >= regalos_minimos)
            {
                global.desafio_camarones = 2;
                phy_position_x = punto_aparicion[0];
                phy_position_y = punto_aparicion[1];
                image_alpha = 0;
                efecto = 0;
                fase = "humo";
            }
        }
        break;
    
    case 2:
        if (fase == "humo")
        {
            // Humo oscuro al medio de la playa; Khoru se hace visible dentro de él y llama a Amaru
            global.cinematica = 1;
            
            with (obj_player)
            {
                hspd = 0;
                vspd = 0;
                destino_activo = 0;
            }
            
            efecto += 1;
            image_alpha = clamp((efecto - 20) / 25, 0, 1);
            
            if (efecto >= duracion_humo)
            {
                efecto = 0;
                image_alpha = 1;
                
                with (instance_create(x, y, obj_dialogo))
                    npc = other.texto_llamado;
                
                fase = "llama";
            }
        }
        else if (fase == "llama")
        {
            if (!instance_exists(obj_dialogo))
            {
                global.cinematica = 0;
                fase = "espera";
            }
        }
        else if (fase == "habla")
        {
            if (!instance_exists(obj_dialogo))
            {
                fase = "espera";
                
                // Sin un mazo de 5 cartas no hay pelea: Wanku entrega los arpones (la primera vez), abre el menú en Ver cartas
                // y el globo del menú pide equipar 5 cartas. Después Amaru vuelve a hablarle a Khoru
                if (obj_morral.mazo_seleccionado[4] >= cartas_minimas)
                {
                    global.desafio_mazo_guia = 0;
                    fase = "batalla";
                    script_execute(scr_guardar_datos);
                    global.enable_battle = 1;
                    global.enable_player = 1;
                    global.escena = 1;
                    global.tipo_enemigo = enemigo_tipo;
                    scr_go_to_room(4);
                }
                else
                {
                    with (instance_create(x, y, obj_wanku_guia))
                        npc_texto = other.cartas_dadas ? "wanku_camarones_cartas_2" : "wanku_camarones_cartas";
                    
                    if (!cartas_dadas)
                    {
                        dar_cartas(cartas_inicio[0], cartas_inicio[1]);
                        cartas_dadas = 1;
                    }
                    
                    fase = "mazo";
                }
            }
        }
        else if (fase == "mazo")
        {
            // Cuando Wanku se va, se abre la pausa directo en Ver cartas (como al elegirla en el menú, scr_menu)
            if (!instance_exists(obj_wanku_guia) && !instance_exists(obj_dialogo))
            {
                fase = "espera";
                global.desafio_mazo_guia = 1; // el globo de Editar mazo pide las 5 cartas (obj_pause/Draw_0)
                
                if (ds_list_size(obj_morral.morralCards) > 0)
                    abrir_menu("Editar mazo", "");
            }
        }
        else if (fase == "espera" && libre && global.cinematica == 0 && point_distance(x, y, obj_player.x, obj_player.y) <= 100 && scr_tecla_z())
        {
            // Amaru llega y le habla: el desafío completo la primera vez, después la versión corta
            with (instance_create(x, y, obj_dialogo))
                npc = other.desafio_dicho ? other.texto_desafio_2 : other.texto_desafio;
            
            desafio_dicho = 1;
            fase = "habla";
        }
        break;
    
    case 3:
        // De vuelta de la batalla ganada: premio
        if (fase != "premio")
        {
            if (libre)
            {
                image_alpha = 1;
                calcular_premio();
                
                with (instance_create(x, y, obj_dialogo))
                    npc = other.texto_premio;
                
                fase = "premio";
            }
        }
        else if (!instance_exists(obj_dialogo))
        {
            for (var i = 0; i < array_length(premio); i++)
                scr_morral_agregar(premio[i][0], premio[i][1]);
            
            global.desafio_camarones = 4;
            script_execute(scr_guardar_datos);
            fase = "sale";
        }
        break;
    
    case 4:
        if (fase == "sale")
        {
            // Khoru se va y Wanku orienta
            image_alpha = max(0, image_alpha - 0.1);
            
            if (image_alpha <= 0)
            {
                phy_position_x = fuera_x;
                phy_position_y = fuera_y;
                
                with (instance_create(x, y, obj_wanku_guia))
                    npc_texto = other.texto_guia;
                
                fase = "guia";
            }
        }
        else if (fase == "guia")
        {
            if (!instance_exists(obj_wanku_guia))
            {
                crear_npcs_recetas();
                fase = "fin";
            }
        }
        else if (fase == "fin" && instance_exists(obj_npc_1))
        {
            // La anciana (obj_npc_1, también en la historia: no se toca). Cada vez que dice que faltan piezas,
            // al cerrar su diálogo se abre Creación → Momificar con el globo de lo que falta (obj_pause/Draw_0)
            if (obj_npc_1.count == 0)
                abuela_menu = 0;
            else if (!obj_npc_1.falta_material)
                global.desafio_momia_guia = 0; // ya tiene todo: la anciana empieza la ceremonia
            else if (!abuela_menu && !instance_exists(obj_dialogo) && !global.pause && global.transicion == 0)
            {
                abuela_menu = 1;
                global.desafio_momia_guia = 1;
                abrir_menu("Creación", "momificar");
            }
        }
        break;
}
