function scr_pause_control() {
if (instance_exists(obj_dialogo) || instance_exists(obj_popup_ayuda))
    exit;

if (instance_exists(obj_control_tutorial))
{
    if (room == rm_tutorial && obj_control_tutorial.paso == 9)
    {
        if (instance_exists(obj_dialogo))
        {
            obj_control_tutorial.trigger = 0;
            
            with (obj_dialogo)
                instance_destroy();
        }
    }
    
    if ((obj_control_tutorial.paso >= 10 && obj_control_tutorial.paso <= 12) || (obj_control_tutorial.paso >= 16 && room != rm_battle_tutorial))
        exit;
    
    if (obj_control_tutorial.paso >= 13 && obj_control_tutorial.paso <= 14 && global.pause != 1)
        exit;
}

if ((room == rm_battle || room == rm_battle_tutorial) && !global.pause)
{
    global.pause = 1;
    instance_deactivate_all(true);
}
else if ((room == rm_battle || room == rm_battle_tutorial) && !global.pause)
{
    global.pause = 0;
    instance_activate_all();
}

if (!global.pause && (room != rm_battle || room != rm_battle_tutorial))
{
    global.pause = 1;
    menuOptions = "Principal";
    script_execute(scr_cambiaSprite);
    instance_deactivate_all(true);
    instance_activate_object(obj_morral);
    instance_activate_object(obj_game);
    instance_activate_object(obj_control_tutorial);
    image_speed = 0.4;
    image_index = 0;
}
else if (!instance_exists(obj_popUp))
{
    global.pause = 0;
    posCursor = 0;
    select = undefined;
    menuOptions = -4;
    editDeck_phase = "cardInventory";
    addRemove_card = "add";
    calculoCP = 0;
    warningMessage = 0;
    readyConstruct = 0;
    script_execute(scr_ordenaMazo);
    instance_activate_all();
    image_speed = 0;
    image_index = 0;
    
    if (instance_exists(obj_player))
    {
        obj_player.hspd = 0;
        obj_player.vspd = 0;
    }
}
}
