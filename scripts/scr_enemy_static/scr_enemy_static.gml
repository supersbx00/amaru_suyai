function scr_enemy_static() {
var dist = point_distance(x, y, obj_player.x, obj_player.y);
playerx = obj_player.x;
playery = obj_player.y;
enemyx = x;
enemyy = y;

if (obj_player.hspd == 0 && obj_player.vspd == 0 && dist < 100)
{
    if (count == 0)
    {
        with (instance_create(x, y, obj_dialogo))
            npc = other.nombre;
        
        count = 1;
    }
    
    if (playery < enemyy && playerx < enemyx)
    {
        sprite_index = spr_enemigo_back_stand;
        obj_player.sprite_index = spr_amaru_stand_rightDown;
        obj_player.image_xscale = 1;
        x = obj_player.x - 85;
        y = obj_player.y + 45;
    }
    
    if (playery > enemyy && playerx > enemyx)
    {
        sprite_index = spr_enemigo_battle_stand;
        obj_player.sprite_index = spr_amaru_stand_rightTop;
        obj_player.image_xscale = -1;
        x = obj_player.x - 85;
        y = obj_player.y - 45;
    }
    
    if (playery > enemyy && playerx < enemyx)
    {
        sprite_index = spr_enemigo_battle_stand;
        obj_player.sprite_index = spr_amaru_stand_rightTop;
        obj_player.image_xscale = 1;
        x = obj_player.x + 85;
        y = obj_player.y - 45;
    }
    
    if (playery < enemyy && playerx > enemyx)
    {
        sprite_index = spr_enemigo_back_stand;
        obj_player.sprite_index = spr_amaru_stand_rightDown;
        obj_player.image_xscale = -1;
        x = obj_player.x - 85;
        y = obj_player.y + 45;
    }
    
    if (!instance_exists(obj_dialogo) && count == 1)
    {
        show_debug_message(rival_digno);
        persistent = true;
        global.last_room = room;
        
        if (instance_exists(obj_control_tutorial))
        {
            global.last_paso = obj_control_tutorial.paso;
            
            if (rival_digno)
            {
                global.escena = 1;
                global.tipo_enemigo = argument[0];
                global.ide = id;
                script_execute(scr_go_to_room(5));
            }
        }
        else
        {
            global.ide = id;
            
            if (rival_digno)
            {
                show_debug_message(rival_digno);
                global.escena = 1;
                global.tipo_enemigo = argument[0];
                script_execute(scr_go_to_room(4));
                obj_player.enable_player = 1;
            }
        }
    }
}
else if (dist >= 100)
{
    state = 49;
}
}
