// Equipo de Amaru y Suyai en batalla (con Suyai unida).
// obj_player_battle siempre es el personaje que maneja el jugador (mano, combos, escudo, HUD);
// obj_aliado_battle es el compañero con IA. Cambiar de personaje intercambia los datos de cada uno entre los dos.
#macro ALIADO_DANHO_MIN 3
#macro ALIADO_DANHO_MAX 5
#macro SUYAI_DANHO_MULT 0.7
#macro SUYAI_CURA 20
#macro SUYAI_CURA_RECARGA 360   // 12 s
#macro ALIADO_ZONA_X0 96
#macro ALIADO_ZONA_X1 600
#macro ALIADO_ZONA_Y0 304
#macro ALIADO_ZONA_Y1 768
#macro ALIADO_DIST_MIN 120      // el compañero no se le encima al personaje controlado

// Sprites de batalla del personaje (en la instancia que lo dibuja)
function scr_batalla_sprites(p) {
personaje = p;

if (p == "suyai")
{
    // La animación de recuperarse se usa para curar y para recargar
    var cura = spr_suyai_battle_cura;
    
    spr_b_stand = spr_suyai_battle_stand;
    spr_b_run = spr_suyai_battle_run;
    spr_b_atk = spr_suyai_battle_brillo;
    spr_b_danho = spr_suyai_battle_danho;
    spr_b_defeat = spr_suyai_battle_defeat;
    spr_b_cura = cura;
    spr_b_carga = cura;
    spr_b_break = spr_suyai_battle_danho;
}
else
{
    spr_b_stand = spr_amaru_battle_stand;
    spr_b_run = spr_amaru_battle_run;
    spr_b_atk = spr_amaru_battle_atk;
    spr_b_danho = spr_amaru_battle_danho;
    spr_b_defeat = spr_amaru_battle_defeat;
    spr_b_cura = spr_amaru_battle_cura;
    spr_b_carga = spr_amaru_battle_brillo;
    spr_b_break = spr_amaru_battle_CardBreaker;
}
}

// Lo llama rm_battle: con Suyai unida (y fuera del tutorial) entra el compañero.
// El jugador empieza con el personaje que tenía activo en el mapa.
function scr_batalla_equipo_crear() {
if (instance_exists(obj_control_tutorial) || !variable_global_exists("suyai_unida") || !global.suyai_unida)
    exit;

if (!instance_exists(obj_player_battle) || instance_exists(obj_aliado_battle))
    exit;

var a = instance_create(obj_player_battle.x, clamp(obj_player_battle.y + 170, ALIADO_ZONA_Y0, ALIADO_ZONA_Y1), obj_aliado_battle);

if (global.personaje == "suyai")
{
    with (obj_player_battle)
    {
        scr_batalla_sprites("suyai");
        sprite_index = spr_b_stand;
    }
    
    with (a)
    {
        scr_batalla_sprites("amaru");
        sprite_index = spr_b_stand;
    }
}
}

// Personajes que siguen en pie (sin compañero, solo cuenta Amaru)
function scr_batalla_equipo_vivo() {
var n = 0;

if (instance_exists(obj_player_battle) && obj_player_battle.barHealth > 0)
    n += 1;

if (instance_exists(obj_aliado_battle) && !obj_aliado_battle.caido && obj_aliado_battle.barHealth > 0)
    n += 1;

return n;
}

// Intercambia el control. automatico = 1 cuando cae el controlado y el compañero sigue en pie.
function scr_batalla_cambiar(automatico = 0) {
if (!instance_exists(obj_aliado_battle) || !instance_exists(obj_player_battle))
    return 0;

var j = obj_player_battle.id;
var a = obj_aliado_battle.id;

if (a.caido || a.barHealth <= 0)
    return 0;

if (!automatico)
{
    // Solo con el personaje libre: sin carta en curso, carta rota, anulación ni ancestral, y con la batalla en marcha
    if (j.barHealth <= 0 || !j.can_atk || j.alarmTrigger || j.player_cardBreaked || j.anulable || j.ancestral || j.add != 1)
        return 0;
    
    if (obj_battleController.win || obj_battleController.defeat || obj_battleController.phase3)
        return 0;
    
    if (instance_exists(obj_tutorial_popUp) || instance_exists(obj_tutorial_popUp1) || instance_exists(obj_popUp))
        return 0;
}

var jx = j.phy_position_x;
var jy = j.phy_position_y;
var jv = j.barHealth;
var jp = j.personaje;
var js = j.sprite_index;
var ji = j.image_index;

with (j)
{
    phy_position_x = a.phy_position_x;
    phy_position_y = a.phy_position_y;
    barHealth = a.barHealth;
    scr_batalla_sprites(a.personaje);
    sprite_index = a.sprite_index;
    image_index = a.image_index;
    image_speed = 0.3;
    hspd = 0;
    vspd = 0;
    phy_active = 1;
    
    // Si el control pasa porque cayó el anterior, se suelta la carta en curso
    if (automatico)
    {
        player_cardBreaked = 0;
        anulable = 0;
        alarm[0] = -1;
        alarm[2] = -1;
        sprite_index = spr_b_stand;
    }
}

with (a)
{
    phy_position_x = jx;
    phy_position_y = jy;
    barHealth = max(0, jv);
    scr_batalla_sprites(jp);
    sprite_index = js;
    image_index = ji;
    hspd = 0;
    vspd = 0;
    mov_dest_x = jx;
    mov_dest_y = jy;
    mov_pausa = 10;
    
    if (automatico)
    {
        caido = 1;
        barHealth = 0;
        phy_active = 0;
        sprite_index = spr_b_defeat;
        image_index = 0;
        image_speed = 0.4;
    }
    else if (sprite_index != spr_b_danho && sprite_index != spr_b_cura)
    {
        sprite_index = spr_b_stand;
    }
}

global.cambio_destello = 8; // destello blanco en los dos personajes, igual que al cambiar en el mapa
return 1;
}

// Draw de obj_player_battle y obj_aliado_battle: destello al cambiar de personaje (lo descuenta obj_battleController)
function scr_batalla_destello() {
if (global.cambio_destello <= 0)
    exit;

gpu_set_fog(true, c_white, 0, 1);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, global.cambio_destello / 8);
gpu_set_fog(false, c_white, 0, 0);
}

// Curación de Suyai: 20 de vida al que tenga menos vida de los que siguen en pie (o a ella misma).
// La usa la IA cuando alguno baja de la mitad, o el jugador con B / F cuando controla a Suyai.
function scr_batalla_suyai_curar() {
if (!instance_exists(obj_battleController) || obj_battleController.cura_suyai > 0)
    return 0;

var suyai = noone;

if (instance_exists(obj_player_battle) && obj_player_battle.personaje == "suyai" && obj_player_battle.barHealth > 0)
    suyai = obj_player_battle.id;
else if (instance_exists(obj_aliado_battle) && obj_aliado_battle.personaje == "suyai" && !obj_aliado_battle.caido)
    suyai = obj_aliado_battle.id;

if (suyai == noone)
    return 0;

var dest = suyai;

if (instance_exists(obj_player_battle) && obj_player_battle.barHealth > 0 && obj_player_battle.barHealth < dest.barHealth)
    dest = obj_player_battle.id;

if (instance_exists(obj_aliado_battle) && !obj_aliado_battle.caido && obj_aliado_battle.barHealth < dest.barHealth)
    dest = obj_aliado_battle.id;

dest.barHealth = min(100, dest.barHealth + SUYAI_CURA);

with (suyai)
{
    sprite_index = spr_b_cura;
    image_index = 0;
    image_speed = 0.2;
    hspd = 0;
    vspd = 0;
}

obj_battleController.cura_suyai = SUYAI_CURA_RECARGA;
return 1;
}

// Movimiento del compañero con IA en la mitad izquierda: lejos del controlado, a veces a la altura de un enemigo
function scr_aliado_mover() {
if (scr_batalla_esquivar("enemy", ALIADO_ZONA_Y0, ALIADO_ZONA_Y1))
    mov_pausa = 0;

if (mov_pausa > 0)
{
    mov_pausa -= 1;
    hspd = 0;
    vspd = 0;
    return;
}

var j = obj_player_battle;
var dist = point_distance(phy_position_x, phy_position_y, mov_dest_x, mov_dest_y);
var dest_cerca = point_distance(mov_dest_x, mov_dest_y, j.x, j.y) < ALIADO_DIST_MIN;

if (dist <= mov_vel || dest_cerca)
{
    if (!dest_cerca)
    {
        phy_position_x = mov_dest_x;
        phy_position_y = mov_dest_y;
    }
    
    // Destino nuevo, lejos del controlado; 1 de cada 2 a la altura de un enemigo vivo
    var nx = phy_position_x;
    var ny = phy_position_y;
    
    repeat (10)
    {
        nx = random_range(ALIADO_ZONA_X0, ALIADO_ZONA_X1);
        ny = random_range(ALIADO_ZONA_Y0, ALIADO_ZONA_Y1);
        
        if (irandom(1) == 0)
        {
            var e = scr_batalla_enemigo_al_azar();
            
            if (e != noone)
                ny = clamp(e.y + random_range(-20, 20), ALIADO_ZONA_Y0, ALIADO_ZONA_Y1);
        }
        
        if (point_distance(nx, ny, j.x, j.y) >= ALIADO_DIST_MIN)
            break;
    }
    
    mov_dest_x = nx;
    mov_dest_y = ny;
    mov_vel = random_range(4, 6);
    mov_pausa = choose(0, 6, 12, 20);
    hspd = 0;
    vspd = 0;
    return;
}

var dir = point_direction(phy_position_x, phy_position_y, mov_dest_x, mov_dest_y);
hspd = lengthdir_x(mov_vel, dir);
vspd = lengthdir_y(mov_vel, dir);
phy_position_x += hspd;
phy_position_y += vspd;
}

function scr_batalla_enemigo_al_azar() {
var vivos = [];

with (obj_enemigo)
{
    if (barHealth > 0)
        array_push(vivos, id);
}

if (array_length(vivos) == 0)
    return noone;

return vivos[irandom(array_length(vivos) - 1)];
}

// Cabeza del personaje para el HUD (Amaru tiene retrato propio; de Suyai se recorta la cabeza del sprite de pie)
function scr_batalla_cabeza(p, px, py, escala) {
if (p == "suyai")
    draw_sprite_part_ext(spr_suyai_battle_stand, 0, 12, 0, 52, 44, px - (26 * escala * 1.6), py - (26 * escala * 1.6), escala * 1.6, escala * 1.6, c_white, 1);
else
    draw_sprite_ext(spr_amaru_battle_head, 1, px, py, escala, escala, 0, c_white, 1);
}

// Retrato y vida del compañero, bajo la vida del controlado. También es el botón para cambiar con el mouse.
#macro RETRATO_X0 128
#macro RETRATO_Y0 72
#macro RETRATO_X1 330
#macro RETRATO_Y1 114

function scr_batalla_equipo_hud() {
if (!instance_exists(obj_aliado_battle))
    exit;

var a = obj_aliado_battle;
var sobre = scr_batalla_retrato_bajo_mouse();
draw_set_alpha(sobre ? 0.55 : 0.35);
draw_set_color(c_black);
draw_roundrect(RETRATO_X0, RETRATO_Y0, RETRATO_X1, RETRATO_Y1, false);
draw_set_alpha(1);
scr_batalla_cabeza(a.personaje, 152, 98, 0.35);

var bx = 180;
var by = 88;
var ancho = 120;
draw_set_color(c_black);
draw_rectangle(bx - 1, by - 1, bx + ancho + 1, by + 9, false);
draw_set_color(a.caido ? c_dkgray : make_color_rgb(200, 40, 30));
draw_rectangle(bx, by, bx + (ancho * clamp(a.barHealth / 100, 0, 1)), by + 8, false);

// Curación de Suyai: un punto verde cuando está lista
if (a.personaje == "suyai" || obj_player_battle.personaje == "suyai")
{
    draw_set_color((obj_battleController.cura_suyai <= 0) ? make_color_rgb(90, 220, 110) : c_dkgray);
    draw_circle(bx + ancho + 8, by + 4, 4, false);
}

draw_set_color(c_white);
}

function scr_batalla_retrato_bajo_mouse() {
if (!instance_exists(obj_aliado_battle) || obj_aliado_battle.caido)
    return 0;

return point_in_rectangle(mouse_x, mouse_y, RETRATO_X0, RETRATO_Y0, RETRATO_X1, RETRATO_Y1);
}
