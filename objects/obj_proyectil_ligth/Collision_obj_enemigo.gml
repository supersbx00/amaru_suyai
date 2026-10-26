if (creador == "player1")
{
    other.barHealth -= danho;
    
    if (instance_exists(obj_transparente))
    {
        with (obj_transparente)
        {
            if (sprite_index == spr_moon)
                instance_destroy();
        }
    }
    
    instance_destroy();
}
