function scr_pause_lb() {
if (!instance_exists(obj_control_tutorial))
{
    if (menuOptions == "Editar mazo")
    {
        addRemove_card = "add";
        editDeck_phase = "cardInventory";
        posCursor = 0;
    }
}
}
