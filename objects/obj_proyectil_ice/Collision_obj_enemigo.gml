if (creador == "player1")
{
    other.barHealth -= scr_danho(danho);
    
    if (instance_exists(obj_transparente))
    {
        with (obj_transparente)
            instance_destroy();
    }
    
    instance_destroy();
}
