function scr_pause_rb() {
if (!instance_exists(obj_control_tutorial))
{
    if (obj_morral.mazo_seleccionado[4] > 5)
    {
        if (menuOptions == "Editar mazo")
        {
            addRemove_card = "remove";
            editDeck_phase = "cardDeck";
            
            for (var search = 0; search <= 26; search++)
            {
                aux_mazoSeleccionado = obj_morral.mazo_seleccionado[2];
                verifica_posVacia = ds_list_find_value(aux_mazoSeleccionado, search);
                
                if (verifica_posVacia[3] != "No Type")
                {
                    posCursor = search;
                    search = 28;
                }
                
                scr_controlVisor();
            }
            
            var listaCartas = obj_morral.mazo_seleccionado[2];
            var cpCartaMazo = ds_list_find_value(listaCartas, posCursor);
            calculoCP = cpCartaMazo[4];
        }
    }
    
    show_debug_message("No puedes sacar cartas debido a que tienes el minimo (5)");
}
}
