function scr_combo_enemy() {
buscaTipo = argument0;
var id_pr = -4;

if (buscaTipo[3] == "luna")
{
    id_pr = instance_create(x + distancia, y, obj_proyectil_ligth);
    
    with (id_pr)
    {
        if (x < (room_width / 2))
        {
            hspd = -10;
            image_xscale = 1;
        }
        else
        {
            hspd = -10;
            image_xscale = -1;
        }
        
        creador = "enemy";
        image_speed = 0.3;
    }
}

if (buscaTipo[3] == "agua")
{
    id_pr = instance_create(x + distancia, y, obj_proyectil_ice);
    
    with (id_pr)
    {
        if (x < (room_width / 2))
        {
            hspd = -10;
            image_xscale = 1;
        }
        else
        {
            hspd = -10;
            image_xscale = -1;
        }
        
        creador = "enemy";
        image_speed = 0.3;
    }
}

if (buscaTipo[3] == "fuego")
{
    id_pr = instance_create(x + distancia, y, obj_proyectil);
    
    with (id_pr)
    {
        if (x < (room_width / 2))
        {
            image_xscale = 1;
            hspd = -10;
        }
        else
        {
            image_xscale = -1;
            hspd = -10;
        }
        
        creador = "enemy";
        image_speed = 0.3;
    }
}
}
