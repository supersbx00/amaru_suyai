dist = point_distance(x, y, obj_player.x, obj_player.y);
image_speed = 0.3;
push_button = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1);

if (dist <= 100)
{
    if (push_button && count == 0)
    {
        with (instance_create(x, y, obj_dialogo))
            npc = other.nombre;
        
        if (!entregoPuntaje)
        {
            global.puntaje_total_descrasheo += 80;
            global.puntaje_total += 80;
            script_execute(scr_guardar_datos);
            entregoPuntaje = 1;
        }
        
        count++;
    }
    
    if (!instance_exists(obj_dialogo) && count == 1 && enable_room)
    {
        global.escena = 1;
        global.anciana = 1;
        scr_go_to_room(3);
        enable_room = 0;
    }
}

depth = -y;

if (enable_room == 1)
    nombre = "npc1";
else if (enable_room == 0)
    nombre = "npc1_2";

if (dist > 100)
{
    enable_room = 1;
    count = 0;
}
