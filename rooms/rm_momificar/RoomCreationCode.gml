global.cinematica = 0;

if (instance_number(obj_player) > 0)
    obj_player.desactivado = 0;

// Entrando desde el menú no hay punto de entrada en cambio_escena y Amaru quedaría en (0, 0):
// parte donde está colocado en la sala (1856, 96), el mismo punto de entrada que usa la historia.
if (ds_list_empty(obj_game.cambio_escena))
{
    with (obj_player)
    {
        player_x = x;
        player_y = y;
    }
}

// Sala de pruebas: Suyai acompaña desde el inicio (el acompañante lo crea obj_player en su Room Start)
if (global.modo_prueba)
    global.suyai_unida = 1;

if (global.zona < 2)
    global.zona = 2;

if (!instance_exists(obj_generate))
    instance_create(0, 0, obj_generate);

if (!instance_exists(obj_pause))
    instance_create(0, 0, obj_pause);

if (!instance_exists(obj_room_controller))
    instance_create(0, 0, obj_room_controller);

if (instance_exists(obj_control_tutorial))
{
    with (obj_control_tutorial)
        instance_destroy();
}

with (instance_create(camera_get_view_width(view_camera[0]) / 2, 150, obj_cartel_room))
    valor_room = room;
