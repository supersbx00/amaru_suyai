function scr_actualiza_listaLogros() {
ini_open("logros.ini");
var data = undefined;
data = ds_list_find_value(listaLogros_personas, 0);
data[0] = ini_read_real("101038", "logrado", 0);
ds_list_replace(listaLogros_personas, 0, data);
data = ds_list_find_value(listaLogros_objetos, 0);
data[0] = ini_read_real("101041", "logrado", 0);
ds_list_replace(listaLogros_objetos, 0, data);
ini_close();
}
