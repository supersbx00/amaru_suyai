// Grupo de enemigos de rm_battle: cuántos son, quiénes, su vida y a quién le toca atacar.
// Una batalla nueva solo agrega su fila en scr_batalla_enemigo_principal.
#macro BATALLA_VIDA_PRINCIPAL 0.75   // el enemigo de la batalla pelea con esta parte de su vida
#macro BATALLA_VIDA_ACOMP 50         // vida de cada acompañante normal

// Objeto del enemigo principal según global.tipo_enemigo
function scr_batalla_enemigo_principal() {
switch (global.tipo_enemigo)
{
    case "tojone": return obj_tojotojone;
    case "espiritu_luna": return obj_enemigo_luna;
    case "espiritu_agua": return obj_enemigo_agua;
    case "espiritu_fuego": return obj_enemigo_fuego;
    case "khoru": return obj_khoru_battle;
}

return obj_enemigo;
}

// Espíritus que ya tiene Amaru (luna, agua y fuego)
function scr_batalla_espiritus() {
var n = 0;

if (variable_global_exists("espiritu_luna"))
    n += (global.espiritu_luna == 1);

if (variable_global_exists("espiritu_agua"))
    n += (global.espiritu_agua == 1);

if (variable_global_exists("espiritu_fuego"))
    n += (global.espiritu_fuego == 1);

return n;
}

// Lo llama rm_battle al entrar: 2 enemigos, o 3 desde el primer espíritu. Las posiciones no se pisan.
function scr_batalla_enemigos_crear() {
var cantidad = (scr_batalla_espiritus() >= 1) ? 3 : 2;
var pos;

if (cantidad == 2)
    pos = [[832, 400], [1088, 640]];
else
    pos = [[832, 352], [1120, 512], [832, 672]];

var principal = instance_create(pos[0][0], pos[0][1], scr_batalla_enemigo_principal());
principal.barHealth = ceil(principal.barHealth * BATALLA_VIDA_PRINCIPAL);
principal.vida_max = principal.barHealth;

for (var i = 1; i < cantidad; i++)
{
    var acomp = instance_create(pos[i][0], pos[i][1], obj_tojotojone);  // acompañante genérico
    acomp.barHealth = BATALLA_VIDA_ACOMP;
    acomp.vida_max = BATALLA_VIDA_ACOMP;
}

obj_battleController.enemigo_turno = principal;
}

// ¿Puede atacar este enemigo? Sin turno asignado (tutorial, 1 enemigo) atacan todos, como antes.
function scr_batalla_mi_turno() {
if (!instance_exists(obj_battleController))
    return 1;

var turno = obj_battleController.enemigo_turno;
return (turno == noone || turno == id);
}

// El turno pasa al siguiente enemigo vivo, en orden circular
function scr_batalla_turno_siguiente() {
if (!instance_exists(obj_battleController))
    exit;

var vivos = [];

with (obj_enemigo)
{
    if (barHealth > 0)
        array_push(vivos, id);
}

var n = array_length(vivos);

if (n == 0)
    exit;

var actual = obj_battleController.enemigo_turno;
var siguiente = vivos[0];

for (var i = 0; i < n; i++)
{
    if (vivos[i] == actual)
    {
        siguiente = vivos[(i + 1) mod n];
        break;
    }
}

obj_battleController.enemigo_turno = siguiente;
}

// Vida sumada de todos los enemigos vivos (barra de arriba y fin de la batalla)
function scr_batalla_vida_grupo() {
var suma = 0;

with (obj_enemigo)
    suma += max(0, barHealth);

return suma;
}

// ¿Le queda menos de la mitad de su vida? Entonces se mueve y ataca más rápido, y se ve rojizo.
function scr_enemigo_agresivo() {
return (barHealth > 0 && barHealth < vida_max / 2);
}

// Draw de todo enemigo de batalla: reemplaza a draw_self()
function scr_enemigo_dibujar() {
var col = scr_enemigo_agresivo() ? make_color_rgb(255, 190, 190) : c_white;
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, col, image_alpha);

// Aviso antes de disparar: el enemigo brilla en blanco
if (ataque_fase == "avisar")
{
    gpu_set_fog(true, c_white, 0, 0);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 0.3 + (0.3 * abs(dsin(current_time * 0.9))));
    gpu_set_fog(false, c_white, 0, 0);
}

// Barra pequeña y marca de turno: solo cuando hay más de un enemigo
if (instance_number(obj_enemigo) < 2 || barHealth <= 0)
    exit;

var ancho = 56;
var bx = x - (ancho / 2);
var by = bbox_top - 12;
draw_set_color(c_black);
draw_rectangle(bx - 1, by - 1, bx + ancho + 1, by + 6, false);
draw_set_color(make_color_rgb(190, 30, 20));
draw_rectangle(bx, by, bx + (ancho * clamp(barHealth / vida_max, 0, 1)), by + 5, false);

if (instance_exists(obj_battleController) && obj_battleController.enemigo_turno == id)
{
    var ty = by - 10 + (3 * dsin(current_time * 0.4));
    draw_set_color(make_color_rgb(250, 210, 60));
    draw_triangle(x - 8, ty - 10, x + 8, ty - 10, x, ty, false);
}

draw_set_color(c_white);
}

// A quién apunta el enemigo: Amaru o Suyai, al azar entre los que siguen en pie
function scr_batalla_objetivo() {
var lista = [];

if (instance_exists(obj_player_battle) && obj_player_battle.barHealth > 0)
    array_push(lista, obj_player_battle.id);

if (instance_exists(obj_aliado_battle) && !obj_aliado_battle.caido)
    array_push(lista, obj_aliado_battle.id);

if (array_length(lista) == 0)
    return noone;

return lista[irandom(array_length(lista) - 1)];
}

// Patrón del próximo ataque. Lejos (más de 500 px): simple o ráfaga; cerca: simple o abanico.
// Con poca vida, ráfaga o abanico 2 de cada 3 veces. Espíritus y Khoru: siempre simple.
function scr_enemigo_elegir_patron() {
if (object_index != obj_enemigo && object_index != obj_tojotojone)
    return "simple";

var lejos = !instance_exists(objetivo) || (abs(objetivo.x - x) > 500);
var fuerte = lejos ? "rafaga" : "abanico";

if (scr_enemigo_agresivo())
    return (irandom(2) < 2) ? fuerte : "simple";

return choose("simple", fuerte);
}

// Lo llama el Alarm_0 del enemigo (en vez de scr_ataque_enemy): dispara el patrón elegido.
// En ráfaga y abanico cada disparo hace un tercio del daño de la carta, para que el total quede parecido.
function scr_enemigo_disparar(tipo) {
tipo_disparo = tipo;

if (patron == "simple" || instance_exists(obj_control_tutorial))
{
    global.proyectil_2 = 1;
    scr_ataque_enemy(tipo);
    exit;
}

danho = ceil(danho / 3);

if (patron == "abanico")
{
    var angulos = [-12, 0, 12];
    
    for (var i = 0; i < 3; i++)
    {
        global.proyectil_2 = 1;
        scr_ataque_enemy(tipo, angulos[i]);
    }
}
else
{
    global.proyectil_2 = 1;
    scr_ataque_enemy(tipo);
    rafaga_restan = 2;
    rafaga_t = 8;
}
}

// Al final del Step de cada enemigo: cuando acaba de elegir carta, en vez de disparar enseguida
// se pone a la altura de su objetivo, brilla 12 cuadros (8 con poca vida) y recién entonces dispara.
// La espera hasta el próximo turno (alarm[11]) se cuenta desde que termina el ataque.
// En el tutorial todo sigue como antes.
function scr_enemigo_ataque_fases() {
if (barHealth > vida_max)
    vida_max = barHealth;

// Se mueve por posición: un choque con un proyectil no lo deja deslizándose
phy_speed_x = 0;
phy_speed_y = 0;

// Aturdido por el escudo: dura ESCUDO_ATURDE (su Step ya dejó la animación de carta rota y alarm[10])
if (escudo_aturdido)
{
    escudo_aturdido = 0;
    alarm[10] = ESCUDO_ATURDE;
}

if (instance_exists(obj_control_tutorial))
    exit;

// Aturdido, dañado o derrotado a mitad del ataque: se cancela y el turno sigue su curso
if (ataque_fase != "" && (player_cardBreaked || player_danho || barHealth <= 0))
{
    ataque_fase = "";
    rafaga_restan = 0;
    alarm[0] = -1;
    
    if (alarm[11] < 0)
        alarm[11] = max(1, espera_pendiente);
    
    exit;
}

switch (ataque_fase)
{
    case "":
        // Acaba de elegir carta (su Step dejó el disparo en alarm[0])
        if (escoger == 1 && alarm[0] > 0)
        {
            espera_pendiente = scr_enemigo_agresivo() ? irandom_range(20, 30) : max(1, alarm[11]);
            alarm[11] = -1;
            alarm[0] = -1;
            objetivo = scr_batalla_objetivo();
            patron = scr_enemigo_elegir_patron();
            ataque_fase = "apuntar";
            fase_t = 0;
            mov_dest_x = phy_position_x;
            mov_dest_y = phy_position_y;
            mov_vel = max(mov_vel, 6);
            mov_pausa = 0;
            apunta_margen = random_range(-16, 16);
        }
        break;
    
    case "apuntar":
        fase_t += 1;
        
        // Sigue la altura de su objetivo mientras se acerca (con un margen al azar)
        if (instance_exists(objetivo) && fase_t < 30)
            mov_dest_y = clamp(objetivo.y + apunta_margen, ENEMIGO_ZONA_Y0, ENEMIGO_ZONA_Y1);
        
        if (point_distance(phy_position_x, phy_position_y, mov_dest_x, mov_dest_y) < 1 || fase_t >= 45)
        {
            ataque_fase = "avisar";
            fase_t = scr_enemigo_agresivo() ? 8 : 12;
        }
        break;
    
    case "avisar":
        fase_t -= 1;
        
        if (fase_t <= 0)
        {
            ataque_fase = "disparando";
            alarm[0] = 1;
        }
        break;
    
    case "disparando":
        if (rafaga_restan > 0)
        {
            rafaga_t -= 1;
            
            if (rafaga_t <= 0)
            {
                global.proyectil_2 = 1;
                scr_ataque_enemy(tipo_disparo);
                rafaga_restan -= 1;
                rafaga_t = 8;
            }
        }
        else if (alarm[0] < 0)
        {
            ataque_fase = "";
            alarm[11] = max(1, espera_pendiente);
        }
        break;
}
}

// Enemigo contra el que se juega el duelo de cartas: el del turno, o el único que hay (tutorial)
function scr_batalla_enemigo_duelo() {
if (instance_exists(obj_battleController) && obj_battleController.enemigo_turno != noone && instance_exists(obj_battleController.enemigo_turno))
    return obj_battleController.enemigo_turno;

if (instance_exists(obj_enemigo))
    return instance_find(obj_enemigo, 0);

return noone;
}
