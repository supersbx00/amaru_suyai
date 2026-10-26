if (objetofuera != -4)
{
    objetofuera.x = mouse_x;
    objetofuera.y = mouse_y;
    var abr = objetofuera;
    objetofuera.snap = 0;
    
    for (var i = 0; i < instance_number(obj_snap); i++)
    {
        var snap = instance_find(obj_snap, i);
        
        if (snap.sprite_index == abr.sprite_index)
        {
            if (point_distance(abr.x, abr.y, snap.x, snap.y) < 30)
            {
                abr.x = snap.x;
                abr.y = snap.y;
                abr.snap = 1;
            }
        }
    }
}
