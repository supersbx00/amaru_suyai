function scr_text(_texto, _spd, _x, _y, _ancho = undefined, _centrado = false) {
if (!instance_exists(obj_text))
{
    txt = instance_create(_x, _y, obj_text);
    
    with (txt)
    {
        padding = 16;
        maxlength = (_ancho == undefined) ? __view_get(2, 0) : _ancho;
        centrado = _centrado;
        text = _texto;
        spd = _spd;
        font = 0;
        text_length = string_length(text);
        font_size = font_get_size(font);
        text_width = string_width_ext(string_hash_to_newline(text), font_size + (font_size / 2), maxlength);
        text_height = string_height_ext(string_hash_to_newline(text), font_size + (font_size / 2), maxlength);
        boxwidth = text_width + (padding * 2);
        boxheigth = padding * 2;
    }
}
}
