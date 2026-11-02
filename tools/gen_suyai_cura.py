"""Genera spr_suyai_battle_cura (Suyai recuperándose: curar y recargar) desde suyai/suyairecuperandose/.

Misma escala que se usó para spr_suyai_battle_brillo (el cuerpo queda de la misma altura), lienzo 76x92,
origen (38, 46), pies abajo y el cuerpo centrado igual que spr_suyai_battle_stand.

Uso:
  python3 tools/gen_suyai_cura.py <carpeta_salida>      # solo genera los PNG para revisar
  python3 tools/gen_suyai_cura.py --aplicar             # copia los cuadros al sprite del proyecto
"""
import glob, os, re, shutil, sys
from PIL import Image

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ORIGEN = os.path.join(RAIZ, 'suyai', 'suyairecuperandose')
SPR = 'spr_suyai_battle_cura'
W, H = 76, 92
ESCALA = 88 / 563  # brillo: 563 px de alto en el dibujo -> 88 px en el sprite


def centro_bajo(im):
    """Centro horizontal de la mitad de abajo (falda y piernas), sin contar el pelo que se mueve."""
    a = im.split()[3]
    w, h = im.size
    xs = [x for y in range(int(h * 0.6), h) for x in range(w) if a.getpixel((x, y)) > 128]
    return sum(xs) / len(xs)


def stand():
    t = open(os.path.join(RAIZ, 'sprites', 'spr_suyai_battle_stand', 'spr_suyai_battle_stand.yy')).read()
    i = re.findall(r'"name":"([0-9a-f-]{36})","resourceType":"GMSpriteFrame"', t)[0]
    return Image.open(os.path.join(RAIZ, 'sprites', 'spr_suyai_battle_stand', i + '.png')).convert('RGBA')


def cuadros():
    meta = centro_bajo(stand())
    out = []
    for f in sorted(glob.glob(os.path.join(ORIGEN, 'sr*.png'))):
        im = Image.open(f).convert('RGBA')
        im = im.resize((round(im.width * ESCALA), round(im.height * ESCALA)), Image.LANCZOS)
        lienzo = Image.new('RGBA', (W, H), (0, 0, 0, 0))
        x = round(meta - centro_bajo(im))
        lienzo.alpha_composite(im, (max(0, min(W - im.width, x)), H - im.height))
        out.append(lienzo)
    return out


if __name__ == '__main__':
    fs = cuadros()
    if sys.argv[1:] == ['--aplicar']:
        d = os.path.join(RAIZ, 'sprites', SPR)
        t = open(os.path.join(d, SPR + '.yy')).read()
        ids = re.findall(r'"name":"([0-9a-f-]{36})","resourceType":"GMSpriteFrame"', t)
        capa = re.search(r'"resourceType":"GMImageLayer".*?"name":"([0-9a-f-]{36})"|"name":"([0-9a-f-]{36})","resourceType":"GMImageLayer"', t, re.S)
        capa = capa.group(1) or capa.group(2)
        tmp = os.path.join(d, '_tmp.png')
        for i, im in zip(ids, fs):
            im.save(tmp)
            shutil.copyfile(tmp, os.path.join(d, i + '.png'))
            os.makedirs(os.path.join(d, 'layers', i), exist_ok=True)
            shutil.copyfile(tmp, os.path.join(d, 'layers', i, capa + '.png'))
        os.remove(tmp)
        print('aplicado', len(ids), 'cuadros')
    else:
        dest = sys.argv[1]
        os.makedirs(dest, exist_ok=True)
        for n, im in enumerate(fs):
            im.save(os.path.join(dest, f'{n}.png'))
        print('generados', len(fs), 'cuadros en', dest)
