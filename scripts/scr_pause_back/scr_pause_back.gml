function scr_pause_back() {
if (instance_exists(obj_control_tutorial))
{
    if (obj_control_tutorial.paso >= 10 && obj_control_tutorial.paso <= 12 && menuOptions == "Principal")
        exit;
}

if (menuOptions != "Principal")
    posCursor = 0;

if (menuOptions == "Principal" && !instance_exists(obj_popUp))
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
    obj_player.hspd = 0;
    obj_player.vspd = 0;
}

if (menuOptions == "Inventario")
    menuOptions = "Principal";

if (menuOptions == "Creación" && !readyConstruct)
    menuOptions = "Principal";
else if (menuOptions == "Creación" && readyConstruct)
    readyConstruct = 0;

if (menuOptions == "Ver cartas")
    menuOptions = "Principal";

if (menuOptions == "Memorin")
    menuOptions = "Principal";

warningMessage = 0;

if (menuOptions == "Editar mazo" || menuOptions == "Borrar cartas")
{
    if (editDeck_phase == "cardInventory")
    {
        script_execute(scr_ordenaMazo);
        menuOptions = "Principal";
        visorRange_min = 0;
        visorRange_max = 8;
    }
    
    if (editDeck_phase == "cardCopy")
    {
        calculoCP = scr_valorCP_total(select);
        editDeck_phase = "cardInventory";
    }
    
    if (editDeck_phase == "cardDeck" && addRemove_card == "add")
    {
        editDeck_phase = "cardCopy";
    }
    else
    {
        addRemove_card = "add";
        editDeck_phase = "cardInventory";
    }
}

if (menuOptions == "Equipar mazo" || menuOptions == "Limpiar mazo" || menuOptions == "Renombrar mazo")
    menuOptions = "Ver cartas";
}
