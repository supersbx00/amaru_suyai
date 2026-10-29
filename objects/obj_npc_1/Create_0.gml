blessed = 0;
count = 0;
nombre = "npc1";
enable_room = 1;
ini_open("logros.ini");
logro = ini_read_real(string(id), "logrado", 0);
puntaje = ini_read_real(string(id), "puntaje", 0);
ini_close();
entregoPuntaje = 0;
falta_material = 0;

// spr_anciana está dibujada más grande que Amaru y Suyai: se achica para que queden en proporción
image_xscale = 0.9;
image_yscale = 0.9;
