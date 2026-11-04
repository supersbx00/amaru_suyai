import sys
import os
import math
from PIL import Image

def process_sprite_sheet(input_path, output_path, cell_width, cell_height, palette_path=None):
    """
    Recorta y fuerza un sprite sheet a una cuadrícula exacta,
    limpia bordes alfa sucios y cuantiza la imagen según la paleta del proyecto.
    """
    img = Image.open(input_path).convert("RGBA")
    width, height = img.size
    
    # 1. Redimensionar lienzo a múltiplos exactos de la celda
    cols = math.ceil(width / cell_width)
    rows = math.ceil(height / cell_height)
    new_width = cols * cell_width
    new_height = rows * cell_height
    
    canvas = Image.new("RGBA", (new_width, new_height), (0, 0, 0, 0))
    canvas.paste(img, (0, 0))
    
    # 2. Umbral de limpieza para alfa (evitar píxeles fantasma)
    datas = canvas.getdata()
    clean_data = []
    for item in datas:
        if item[3] < 15:
            clean_data.append((0, 0, 0, 0))
        else:
            clean_data.append(item)
    canvas.putdata(clean_data)
    
    # 3. Cuantización de paleta opcional
    if palette_path and os.path.exists(palette_path):
        palette_img = Image.open(palette_path).convert("P")
        alpha = canvas.split()[3]
        canvas_p = canvas.convert("RGB").quantize(palette=palette_img, dither=0)
        canvas = canvas_p.convert("RGBA")
        canvas.putalpha(alpha)
        
    canvas.save(output_path, "PNG")
    print(f"[OK] Sprite procesado: {output_path} ({cols}x{rows} celdas de {cell_width}x{cell_height}px)")

if __name__ == "__main__":
    if len(sys.argv) < 5:
        print("Uso: python3 sprite_processor.py <input.png> <output.png> <cell_w> <cell_h> [palette.png]")
        sys.exit(1)
    
    pal = sys.argv[5] if len(sys.argv) > 5 else None
    process_sprite_sheet(sys.argv[1], sys.argv[2], int(sys.argv[3]), int(sys.argv[4]), pal)