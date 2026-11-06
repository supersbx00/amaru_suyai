"""Genera spr_suyai_battle_carga: los cuadros de spr_suyai_battle_cura con un aura azul al recargar.

El aura copia el perfil de alfa medido en el aura roja de spr_amaru_battle_carga (anillos de 1 px desde el cuerpo).
Lienzo 88x104 (cura + 6 px por lado), origen (44, 52). Sin paleta, como el aura de Amaru.
Reutiliza crear_yy/aplicar de gen_amaru_brillo.py.

Uso:
  python3 tools/gen_suyai_carga.py <carpeta_salida>   # solo genera los PNG para revisar
  python3 tools/gen_suyai_carga.py --aplicar          # crea el sprite y lo registra en el proyecto
"""
import os, re, sys, uuid
from PIL import Image, ImageChops, ImageFilter
import gen_amaru_brillo as g

g.SPR = 'spr_suyai_battle_carga'
g.PLANTILLA = 'spr_amaru_battle_carga'  # .yy de una línea por cuadro, el formato que entiende crear_yy
CURA = 'spr_suyai_battle_cura'
g.NS = uuid.uuid5(uuid.NAMESPACE_DNS, g.SPR)
PERFIL = [221, 168, 128, 77, 38, 14]   # alfa del aura de Amaru por distancia al cuerpo
COLOR = (30, 110, 255)
PAD = len(PERFIL)
g.W, g.H = 76 + 2 * PAD, 92 + 2 * PAD


def cuadros():
    d = os.path.join(g.RAIZ, 'sprites', CURA)
    t = open(os.path.join(d, CURA + '.yy'), encoding='utf-8').read()
    ids = re.findall(r'\{"\$GMSpriteFrame":"v1","%Name":"([0-9a-f-]+)"', t)
    out = []
    for i in ids:
        f = Image.open(os.path.join(d, i + '.png')).convert('RGBA')
        base = Image.new('RGBA', (g.W, g.H))
        base.paste(f, (PAD, PAD))
        prev = base.getchannel('A').point(lambda v: 255 if v >= 128 else 0)
        glow = Image.new('L', base.size, 0)
        for alfa in PERFIL:
            nxt = prev.filter(ImageFilter.MaxFilter(3))
            glow = ImageChops.lighter(glow, ImageChops.subtract(nxt, prev).point(lambda v, a=alfa: a if v else 0))
            prev = nxt
        aura = Image.new('RGBA', base.size, COLOR + (0,))
        aura.putalpha(glow)
        out.append(Image.alpha_composite(aura, base))
    assert len(out) == 4 and all(o.size == (g.W, g.H) for o in out)
    return out


if __name__ == '__main__':
    fs = cuadros()
    if sys.argv[1:] == ['--aplicar']:
        g.aplicar(fs)
        # Mismo grupo que la cura de Suyai, no el de la plantilla
        yy = os.path.join(g.RAIZ, 'sprites', g.SPR, g.SPR + '.yy')
        cura = open(os.path.join(g.RAIZ, 'sprites', CURA, CURA + '.yy'), encoding='utf-8').read()
        padre = re.search(r'"parent": ?\{[^}]*\}', cura).group(0)
        t = open(yy, encoding='utf-8').read()
        t = re.sub(r'"parent": ?\{[^}]*\}', lambda _: padre, t, count=1)
        open(yy, 'w', encoding='utf-8', newline='').write(t)
    else:
        os.makedirs(sys.argv[1], exist_ok=True)
        for n, im in enumerate(fs):
            im.save(os.path.join(sys.argv[1], f'{n}.png'))
        print('generados', len(fs), 'cuadros en', sys.argv[1])
