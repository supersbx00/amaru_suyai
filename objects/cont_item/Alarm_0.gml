if (instance_number(obj_item) == 0 && instance_number(obj_escudo_tuto) == 0)
{
    spawn_id = instance_create(0, 0, obj_item);
    
    do
    {
        spawn_id.x = random(room_width / 2);
        spawn_id.y = random_range(384, room_height);
        spawn_id.phy_position_x = random(room_width / 2);
        spawn_id.phy_position_y = random_range(384, room_height);
        
        with (spawn_id)
        {
            collision = place_meeting(x, y, obj_pared);
            collision1 = place_meeting(x, y, obj_item);
            collision2 = place_meeting(x, y, obj_pared_32);
        }
    }
    until (spawn_id.collision == 0 && spawn_id.collision1 == 0 && spawn_id.collision2 == 0);
}

alarm[0] = itemSapawnRate + random_range(-itemTimeDif, itemTimeDif);
