function scr_player_move() {
k_left = keyboard_check(vk_left) || gamepad_axis_value(0, gp_axislh) < 0;
k_right = keyboard_check(vk_right) || gamepad_axis_value(0, gp_axislh) > 0;
k_up = keyboard_check(vk_up) || gamepad_axis_value(0, gp_axislv) < 0;
k_down = keyboard_check(vk_down) || gamepad_axis_value(0, gp_axislv) > 0;

// Movimiento con clic: se simula una de las 4 flechas, así el ángulo, la velocidad y la animación son los del teclado
if (k_left || k_right || k_up || k_down)
{
    destino_activo = 0;
}
else if (destino_activo)
{
    // Distancia al destino contada en pasos por eje diagonal:
    // alfa = eje abajo (+6.31, +3.15) / arriba; beta = eje derecha (+6.31, -3.15) / izquierda
    var dx = destino_x - x;
    var dy = destino_y - y;
    var alfa = ((dx / 6.31) + (dy / 3.15)) / 2;
    var beta = ((dx / 6.31) - (dy / 3.15)) / 2;
    var dist_objetivo = (objetivo != noone && instance_exists(objetivo)) ? point_distance(x, y, objetivo.x, objetivo.y) : -1;
    var llegado = (abs(alfa) < 1 && abs(beta) < 1) || (dist_objetivo >= 0 && dist_objetivo <= (radio - 10));
    
    // Atasco: casi sin avanzar durante 10 frames (pared u obstáculo)
    if (point_distance(x, y, pos_prev_x, pos_prev_y) < 1)
        atasco_frames += 1;
    else
        atasco_frames = 0;
    
    pos_prev_x = x;
    pos_prev_y = y;
    
    if (llegado || atasco_frames >= 10)
    {
        // Al llegar a algo clicado se activa como si se apretara Z a su lado (lo ven todos los objetos el próximo frame)
        if (dist_objetivo >= 0 && dist_objetivo <= radio)
            global.z_virtual_pendiente = 1;
        
        destino_activo = 0;
        objetivo = noone;
    }
    else
    {
        // Se recorre primero el tramo más largo y se sigue en él hasta terminarlo (sin zigzag)
        if (tramo == 0 || (tramo == 1 && abs(alfa) < 1) || (tramo == 2 && abs(beta) < 1))
            tramo = (abs(alfa) >= abs(beta)) ? 1 : 2;
        
        if (tramo == 1)
        {
            if (alfa > 0)
                k_down = 1;
            else
                k_up = 1;
        }
        else if (beta > 0)
        {
            k_right = 1;
        }
        else
        {
            k_left = 1;
        }
    }
}

if (k_down)
{
    vspd = 3.15;
    hspd = 6.31;
    sprite_index = spr_amaru_walk_rightDown;
    image_xscale = 1;
    image_speed = 0.3;
}
else if (k_up)
{
    vspd = -3.15;
    hspd = -6.31;
    sprite_index = spr_amaru_walk_rightTop;
    image_xscale = -1;
    image_speed = 0.3;
}
else if (k_left)
{
    vspd = 3.15;
    hspd = -6.31;
    sprite_index = spr_amaru_walk_rightDown;
    image_xscale = -1;
    image_speed = 0.3;
}
else if (k_right)
{
    vspd = -3.15;
    hspd = 6.31;
    sprite_index = spr_amaru_walk_rightTop;
    image_xscale = 1;
    image_speed = 0.3;
}
else if (keyboard_check_released(vk_right) || !k_right)
{
    vspd = 0;
    hspd = 0;
}
else if (keyboard_check_released(vk_up) || !k_up)
{
    vspd = 0;
    hspd = 0;
}
else if (keyboard_check_released(vk_down) || !k_down)
{
    vspd = 0;
    hspd = 0;
}
else if (keyboard_check_released(vk_left) || !k_left)
{
    vspd = 0;
    hspd = 0;
}
}
