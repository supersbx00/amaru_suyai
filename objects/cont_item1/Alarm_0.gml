if (instance_exists(obj_player_battle))
{
    if (obj_player_battle.go_luna < 2 && global.win == 0)
    {
        spawn_id = instance_create(0, 0, obj_go_luna);
        
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
    
    alarm[0] = itemSapawnRate1 + random_range(-itemTimeDif1, itemTimeDif1);
}
