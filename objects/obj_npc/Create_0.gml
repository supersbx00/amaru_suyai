blessed = 0;
count = 0;
nombre = "npc";

// Con Suyai unida: en rm_humedal ya no está; en las demás salas queda como punto de charla invisible y sin cuerpo
if (global.suyai_unida)
{
    if (room == rm_humedal)
        instance_destroy();
    else
        phy_active = false;
}
