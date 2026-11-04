"""Post-procesa un asset gráfico nuevo: grilla exacta, limpieza de píxeles, origen uniforme y paleta oficial.

Uso:
  python3 tools/sprite_processor.py <input.png> <output.png> <cell_w> <cell_h> [palette.png]

Sin palette.png usa palette_reference.png de la raíz del repo. Si la paleta falta, termina con error y no escribe nada.

Opciones:
  --sin-paleta         conserva los colores originales
  --ancla ninguna      conserva la posición de cada cuadro (por defecto: base-centro de la celda)
  --conservar-sueltos  mantiene los píxeles aislados
"""
import argparse
import math
import os
import sys

import numpy as np
from PIL import Image

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PALETA_DEFECTO = os.path.join(RAIZ, 'palette_reference.png')
ALFA_MIN = 15


class ErrorSprite(Exception):
    pass


def cargar_paleta(ruta):
    if not os.path.isfile(ruta):
        raise ErrorSprite(f'no existe la paleta: {ruta}')
    im = Image.open(ruta)
    if im.mode == 'P':
        return im
    # convert("P") usaría la paleta web de Pillow en vez de los colores de la referencia
    colores = im.convert('RGB').getcolors(256)
    if colores is None:
        raise ErrorSprite(f'la paleta tiene más de 256 colores: {ruta}')
    p = Image.new('P', (1, 1))
    p.putpalette([v for _, c in sorted(colores, key=lambda x: x[1]) for v in c])
    return p


def a_grilla(a, cw, ch):
    alto, ancho = a.shape[:2]
    filas, cols = math.ceil(alto / ch), math.ceil(ancho / cw)
    salida = np.zeros((filas * ch, cols * cw, 4), 'uint8')
    salida[:alto, :ancho] = a
    return salida, cols, filas


def limpiar(a, conservar_sueltos):
    a[a[..., 3] < ALFA_MIN] = 0
    if not conservar_sueltos:
        v = a[..., 3] > 0
        p = np.pad(v, 1)
        vecinos = sum(p[1 + dy:p.shape[0] - 1 + dy, 1 + dx:p.shape[1] - 1 + dx]
                      for dy in (-1, 0, 1) for dx in (-1, 0, 1) if dy or dx)
        a[v & (vecinos == 0)] = 0


def avisar_solapamiento(a, cw, ch, cols, filas):
    v = a[..., 3] > 0
    avisos = []
    for c in range(1, cols):
        for f in range(filas):
            if (v[f * ch:(f + 1) * ch, c * cw - 1] & v[f * ch:(f + 1) * ch, c * cw]).any():
                avisos.append(f'celdas ({c - 1},{f}) y ({c},{f})')
    for f in range(1, filas):
        for c in range(cols):
            if (v[f * ch - 1, c * cw:(c + 1) * cw] & v[f * ch, c * cw:(c + 1) * cw]).any():
                avisos.append(f'celdas ({c},{f - 1}) y ({c},{f})')
    for x in avisos:
        print(f'[AVISO] posible solapamiento entre {x}')


def alinear(a, cw, ch, cols, filas):
    salida = np.zeros_like(a)
    for f in range(filas):
        for c in range(cols):
            celda = a[f * ch:(f + 1) * ch, c * cw:(c + 1) * cw]
            ys, xs = np.nonzero(celda[..., 3])
            if not len(ys):
                continue
            contenido = celda[ys.min():ys.max() + 1, xs.min():xs.max() + 1]
            h, w = contenido.shape[:2]
            x = cw // 2 - w // 2
            if x < 0 or x + w > cw or h > ch:
                raise ErrorSprite(f'el cuadro de la celda ({c},{f}) no cabe tras alinear')
            salida[(f + 1) * ch - h:(f + 1) * ch, c * cw + x:c * cw + x + w] = contenido
    return salida


def cuantizar(a, paleta):
    rgb = Image.fromarray(a[..., :3], 'RGB').quantize(palette=paleta, dither=Image.Dither.NONE).convert('RGB')
    salida = np.dstack([np.array(rgb), a[..., 3]])
    salida[a[..., 3] == 0] = 0
    return salida


def procesar(entrada, salida, cw, ch, paleta=None, ancla='base-centro', conservar_sueltos=False):
    pal = cargar_paleta(paleta) if paleta else None  # toda validación va antes de escribir
    a, cols, filas = a_grilla(np.array(Image.open(entrada).convert('RGBA')), cw, ch)
    limpiar(a, conservar_sueltos)
    avisar_solapamiento(a, cw, ch, cols, filas)
    if ancla == 'base-centro':
        a = alinear(a, cw, ch, cols, filas)
    if pal is not None:
        a = cuantizar(a, pal)
    Image.fromarray(a, 'RGBA').save(salida, 'PNG')
    print(f'[OK] Sprite procesado: {salida} ({cols}x{filas} celdas de {cw}x{ch}px)')
    if ancla == 'base-centro':
        print(f'Origen en GameMaker: x={cw // 2}, y={ch - 1}')


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('entrada')
    ap.add_argument('salida')
    ap.add_argument('cell_w', type=int)
    ap.add_argument('cell_h', type=int)
    ap.add_argument('paleta', nargs='?')
    ap.add_argument('--sin-paleta', action='store_true')
    ap.add_argument('--ancla', choices=('base-centro', 'ninguna'), default='base-centro')
    ap.add_argument('--conservar-sueltos', action='store_true')
    o = ap.parse_args()
    if o.sin_paleta and o.paleta:
        ap.error('--sin-paleta no se puede usar junto con una paleta')
    if o.cell_w <= 0 or o.cell_h <= 0:
        ap.error('el tamaño de celda debe ser mayor que 0')
    paleta = None if o.sin_paleta else (o.paleta or PALETA_DEFECTO)
    try:
        procesar(o.entrada, o.salida, o.cell_w, o.cell_h, paleta, o.ancla, o.conservar_sueltos)
    except (ErrorSprite, OSError) as e:
        print(f'[ERROR] {e}', file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
