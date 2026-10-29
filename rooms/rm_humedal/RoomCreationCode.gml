global.cinematica = 0;

if (instance_number(obj_player) > 0)
    obj_player.desactivado = 0;

enemigo_id1 = instance_create(256, 896, obj_enemigo_normal1);
enemigo_id2 = instance_create(1280, 1344, obj_enemigo_normal1);
enemigo_id3 = instance_create(2080, 1216, obj_enemigo_normal1);

if (!instance_exists(obj_generate))
    instance_create(0, 0, obj_generate);

if (!instance_exists(obj_pause))
    instance_create(0, 0, obj_pause);

if (!instance_exists(obj_room_controller))
    instance_create(0, 0, obj_room_controller);

// Wanku detiene a Amaru si intenta pelear antes de que Suyai se una
if (!instance_exists(obj_wanku_aviso))
    instance_create(0, 0, obj_wanku_aviso);

if (instance_exists(obj_control_tutorial))
{
    with (obj_control_tutorial)
        instance_destroy();
}
