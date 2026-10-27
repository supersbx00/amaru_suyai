function scr_text() {
if (!instance_exists(obj_text))
{
    txt = instance_create(argument2, argument3, obj_text);
    
    with (txt)
    {
        padding = 16;
        maxlength = (argument_count > 4) ? argument4 : __view_get(2, 0);
        centrado = (argument_count > 5) ? argument5 : false;
        text = argument0;
        spd = argument1;
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
