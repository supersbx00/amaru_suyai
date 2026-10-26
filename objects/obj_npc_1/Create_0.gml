blessed = 0;
count = 0;
nombre = "npc1";
enable_room = 1;
ini_open("logros.ini");
logro = ini_read_real(string(id), "logrado", 0);
puntaje = ini_read_real(string(id), "puntaje", 0);
ini_close();
entregoPuntaje = 0;
