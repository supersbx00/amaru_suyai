function scr_go_to_room() {
room_state = argument0;

if (!instance_exists(obj_transition))
{
    tempRoom = instance_create(x, y, obj_transition);
    tempRoom.tempTarget = room_state;
    
    if (instance_exists(obj_player))
        obj_player.image_xscale = 1;
}
}
