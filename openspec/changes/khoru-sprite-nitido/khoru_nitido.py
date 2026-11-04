"""Rehace spr_khoru_1 a 66x102, desde los cuadros guardados en originales/, con silueta limpia y contorno.

Va sin paleta, aprobado por el usuario. Parte siempre de originales/ para no reducir un sprite ya reducido.

Uso:
  python3 khoru_nitido.py <carpeta_salida>   # genera cuadros, comparacion.png y animacion.gif para revisar
  python3 khoru_nitido.py --aplicar          # actualiza el sprite del proyecto
"""
import os, re, shutil, sys
import numpy as np
from PIL import Image

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = AQUI
while not any(f.endswith('.yyp') for f in os.listdir(RAIZ)):
    RAIZ = os.path.dirname(RAIZ)
SPR = 'spr_khoru_1'
DIR = os.path.join(RAIZ, 'sprites', SPR)
W, H = 66, 102
FONDO = (70, 90, 80, 255)
ALFA_CERO, ALFA_LLENO = 60, 110
BRILLO_MIN = 70
CONTORNO = np.array([62, 24, 16])


def reducir(im):
    """LANCZOS con alfa premultiplicado, para que el fondo transparente no ensucie los bordes."""
    a = np.array(im).astype('float32')
    a[..., :3] *= a[..., 3:] / 255
    o = np.stack([np.array(Image.fromarray(a[..., i], 'F').resize((W, H), Image.LANCZOS)) for i in range(4)], -1)
    o[..., :3] = o[..., :3] * 255 / np.maximum(o[..., 3:], 1e-3)
    return o.clip(0, 255).astype('uint8')


def cuerpo_principal(m):
    """Se queda con la zona conectada (8 vecinos) más grande: quita los píxeles sueltos."""
    pendientes, mejor = m.copy(), np.zeros_like(m)
    for y, x in zip(*np.nonzero(m)):
        if not pendientes[y, x]:
            continue
        zona, pila = [], [(y, x)]
        pendientes[y, x] = False
        while pila:
            cy, cx = pila.pop()
            zona.append((cy, cx))
            for ny in range(max(cy - 1, 0), min(cy + 2, m.shape[0])):
                for nx in range(max(cx - 1, 0), min(cx + 2, m.shape[1])):
                    if pendientes[ny, nx]:
                        pendientes[ny, nx] = False
                        pila.append((ny, nx))
        if len(zona) > mejor.sum():
            mejor = np.zeros_like(m)
            mejor[tuple(zip(*zona))] = True
    return mejor


def nitido(im):
    a = reducir(im).astype(int)
    a[..., 3] = np.where(a[..., 3] < ALFA_CERO, 0, np.where(a[..., 3] >= ALFA_LLENO, 255, a[..., 3]))
    a[..., 3] = np.where(cuerpo_principal(a[..., 3] > 0), a[..., 3], 0)
    solido = a[..., 3] == 255
    p = np.pad(~solido, 1, constant_values=True)
    borde = solido & (p[:-2, 1:-1] | p[2:, 1:-1] | p[1:-1, :-2] | p[1:-1, 2:])
    claro = borde & (a[..., :3].max(2) > BRILLO_MIN)  # el pelo y la capa ya son oscuros
    a[claro, :3] = (a[claro, :3] * 0.35 + CONTORNO * 0.65).astype(int)
    return Image.fromarray(a.astype('uint8'), 'RGBA')


def cuadros():
    orig = [Image.open(os.path.join(AQUI, 'originales', f'{n}.png')).convert('RGBA') for n in range(6)]
    fs = [nitido(o) for o in orig]
    assert len(fs) == 6 and all(f.size == (W, H) for f in fs)
    return orig, fs


def ids_yy():
    t = open(os.path.join(DIR, SPR + '.yy'), encoding='utf-8', newline='').read()
    ids = re.findall(r'"name":"([0-9a-f-]{36})","resourceType":"GMSpriteFrame"', t)
    capa = re.search(r'"\$GMImageLayer":"","%Name":"([0-9a-f-]{36})"', t).group(1)
    assert len(ids) == 6
    return t, ids, capa


def aplicar(fs):
    t, ids, capa = ids_yy()
    tmp = os.path.join(DIR, '_tmp.png')
    for i, im in zip(ids, fs):
        im.save(tmp)
        shutil.copyfile(tmp, os.path.join(DIR, i + '.png'))  # los PNG son de root: copyfile conserva el dueño
        shutil.copyfile(tmp, os.path.join(DIR, 'layers', i, capa + '.png'))
    os.remove(tmp)
    cajas = [f.getchannel('A').getbbox() for f in fs]
    caja = (min(c[0] for c in cajas), min(c[1] for c in cajas), max(c[2] for c in cajas), max(c[3] for c in cajas))
    for clave, valor in (('bbox_left', caja[0]), ('bbox_top', caja[1]), ('bbox_right', caja[2] - 1), ('bbox_bottom', caja[3] - 1),
                         ('height', H), ('width', W), ('xorigin', W // 2), ('yorigin', H // 2)):
        t = re.sub(r'"%s":\d+' % clave, '"%s":%d' % (clave, valor), t)
    for clave, valor in (('seqHeight', H), ('seqWidth', W)):
        t = re.sub(r'"%s":[\d.]+' % clave, '"%s":%d.0' % (clave, valor), t)
    with open(os.path.join(DIR, SPR + '.yy'), 'w', encoding='utf-8', newline='') as f:
        f.write(t)
    print('aplicado', len(ids), 'cuadros, caja', caja)


def revisar(dest, orig, fs):
    os.makedirs(dest, exist_ok=True)
    for n, f in enumerate(fs):
        f.save(os.path.join(dest, f'{n}.png'))
    Z, paso = 3, W * 3 + 8
    juego = [o.resize((W, H), Image.BILINEAR) for o in orig]  # como se ve hoy con la escala 0.89x0.85
    hoja = Image.new('RGBA', (paso * 6, (H * Z + 8) * 2), FONDO)
    for n in range(6):
        hoja.alpha_composite(juego[n].resize((W * Z, H * Z), Image.NEAREST), (n * paso, 0))
        hoja.alpha_composite(fs[n].resize((W * Z, H * Z), Image.NEAREST), (n * paso, H * Z + 8))
    hoja.save(os.path.join(dest, 'comparacion.png'))
    g = []
    for a, b in zip(juego, fs):
        c = Image.new('RGBA', (paso * 2, H * Z), FONDO)
        c.alpha_composite(a.resize((W * Z, H * Z), Image.NEAREST), (0, 0))
        c.alpha_composite(b.resize((W * Z, H * Z), Image.NEAREST), (paso, 0))
        g.append(c.convert('P', palette=Image.ADAPTIVE))
    g[0].save(os.path.join(dest, 'animacion.gif'), save_all=True, append_images=g[1:], duration=111, loop=0)
    print('revision en', dest)


if __name__ == '__main__':
    orig, fs = cuadros()
    if sys.argv[1:] == ['--aplicar']:
        aplicar(fs)
    else:
        revisar(sys.argv[1], orig, fs)
