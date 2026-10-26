if (!player_cardBreaked && !anulable)
{
    image_speed = 0.1;
    sprite_index = spr_amaru_battle_cura;
    hspd = 0;
    vspd = 0;
    
    if (curar >= 1 && curar <= 5)
        barHealth += 50;
    
    if (curar >= 6 && curar <= 9)
        barHealth += 100;
    else if (curar == undefined)
        barHealth += 0;
    
    if (barHealth > 100)
        barHealth = 100;
}
else if (player_cardBreaked || anulable)
{
    if (barHealtant < barHealth)
    {
        if (curar >= 1 && curar == 5)
            barHealth -= 50;
        
        if (curar >= 6 && curar == 9)
            barHealth -= 100;
    }
}
