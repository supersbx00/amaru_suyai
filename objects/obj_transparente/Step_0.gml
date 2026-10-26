image_alpha = 0.7;
image_speed = 0.3;
x = obj_player_battle.x + 40;
y = obj_player_battle.y;

if (instance_exists(obj_player_battle))
{
    if (obj_player_battle.player_cardBreaked == 1)
        instance_destroy();
    
    if (obj_player_battle.anulable == 1)
        instance_destroy();
}
