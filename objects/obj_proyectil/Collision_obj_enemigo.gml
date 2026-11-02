if (creador == "player1")
{
    other.barHealth -= scr_danho(danho);
    
    if (instance_exists(obj_transparente))
    {
        with (obj_transparente)
        {
            if (sprite_index == spr_fuego)
                instance_destroy();
        }
    }
    
    instance_destroy();
}
