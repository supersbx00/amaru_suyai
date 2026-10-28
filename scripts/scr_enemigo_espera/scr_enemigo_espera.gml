// Frames que espera un enemigo entre un ataque y el siguiente (más lento en el tutorial)
function scr_enemigo_espera() {
if (instance_exists(obj_control_tutorial) && obj_control_tutorial.paso < 25)
    return irandom_range(50, 60);

return irandom_range(30, 45);
}
