if (caido)
    exit;

// Cae: queda fuera de la pelea (el controlador decide si se pierde)
if (barHealth <= 0)
{
    caido = 1;
    barHealth = 0;
    hspd = 0;
    vspd = 0;
    phy_active = 0;
    sprite_index = spr_b_defeat;
    image_index = 0;
    image_speed = 0.4;
    exit;
}

// Antes de empezar la pelea y al terminar, quieto
var en_pelea = instance_exists(obj_player_battle) && obj_player_battle.add == 1 && !obj_battleController.win && !obj_battleController.defeat && scr_batalla_vida_grupo() > 0;
var ocupado = (sprite_index == spr_b_danho || sprite_index == spr_b_cura);

if (!en_pelea || ocupado)
{
    hspd = 0;
    vspd = 0;
    
    if (sprite_index == spr_b_run)
        sprite_index = spr_b_stand;
    
    exit;
}

// Suyai cura cuando alguno baja de la mitad de vida
if (personaje == "suyai" && (barHealth < 50 || (obj_player_battle.barHealth > 0 && obj_player_battle.barHealth < 50)))
{
    if (scr_batalla_suyai_curar())
        exit;
}

scr_aliado_mover();

// Ataca cada 50 a 75 cuadros sin gastar cartas, si el personaje controlado no está en la línea de tiro
ataque_t -= 1;

if (ataque_t <= 0)
{
    var tapa = obj_player_battle.barHealth > 0 && obj_player_battle.x > x && abs(obj_player_battle.y - y) < 50;
    
    if (!tapa)
    {
        var f = instance_create(x + distancia, y, obj_flecha);
        f.creador = creador;
        f.hspd = 30;
        f.image_xscale = 1;
        f.danho = irandom_range(ALIADO_DANHO_MIN, ALIADO_DANHO_MAX);
        
        if (personaje == "suyai")
            f.danho *= SUYAI_DANHO_MULT;
        
        sprite_index = spr_b_atk;
        image_index = 0;
        image_speed = 0.3;
        ataque_t = irandom_range(50, 75);
    }
    else
    {
        ataque_t = 10;
    }
}

if ((hspd != 0 || vspd != 0) && sprite_index != spr_b_atk)
{
    sprite_index = spr_b_run;
    image_speed = 0.4;
}
