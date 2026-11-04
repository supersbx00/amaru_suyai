"""Genera palette_reference.png (raíz del repo, hasta 256 colores) desde los sprites de personajes y UI.

Excluye fondos e ilustraciones. Con los mismos sprites, el resultado es idéntico byte a byte.

Uso:
  python3 tools/gen_palette_reference.py
"""
import glob, os
import numpy as np
from PIL import Image

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SALIDA = os.path.join(RAIZ, 'palette_reference.png')
EXCLUIDOS = ('bk_', 'back', 'background', 'spr_sabias', 'spr_imagen', 'spr_camarones', 'spr_popup')
COLORES = 256
MUESTRA_POR_SPRITE = 2000
SEMILLA = 7


def muestra():
    rng = np.random.default_rng(SEMILLA)
    partes = []
    for carpeta in sorted(os.listdir(os.path.join(RAIZ, 'sprites'))):
        if carpeta.startswith(EXCLUIDOS):
            continue
        # un cuadro por sprite: con todos, las animaciones largas dominan la paleta
        cuadros = sorted(glob.glob(os.path.join(RAIZ, 'sprites', carpeta, '*.png')))
        if not cuadros:
            continue
        a = np.array(Image.open(cuadros[0]).convert('RGBA'))
        rgb = a[a[..., 3] >= 128][:, :3]
        if len(rgb) > MUESTRA_POR_SPRITE:
            rgb = rgb[rng.choice(len(rgb), MUESTRA_POR_SPRITE, replace=False)]
        partes.append(rgb)
    return np.concatenate(partes)


def generar():
    px = muestra()
    q = Image.fromarray(px.reshape(-1, 1, 3)).quantize(COLORES, method=Image.Quantize.MEDIANCUT, dither=Image.Dither.NONE)
    usados = sorted(c for _, c in q.convert('RGB').getcolors(COLORES))
    assert 0 < len(usados) <= COLORES
    lado = 16
    p = Image.new('P', (lado, lado), 0)
    p.putpalette([v for c in usados for v in c])
    p.putdata([i % len(usados) for i in range(lado * lado)])
    p.save(SALIDA, optimize=False)
    print('paleta:', SALIDA, len(usados), 'colores')


if __name__ == '__main__':
    generar()
