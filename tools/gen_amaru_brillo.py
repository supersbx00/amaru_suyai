"""Genera spr_amaru_battle_brillo (Amaru con los ojos brillando al recargar cartas) desde amarubrillo/.

Los dibujos miran al revés que spr_amaru_battle_stand, así que se invierten. Todos usan la misma escala
y conservan su posición, con lienzo 64x90 y origen (32, 45), iguales al stand. Va sin paleta, aprobado por el usuario.

Uso:
  python3 tools/gen_amaru_brillo.py <carpeta_salida>      # solo genera los PNG para revisar
  python3 tools/gen_amaru_brillo.py --aplicar             # crea el sprite y lo registra en el proyecto
"""
import glob, os, re, shutil, sys, uuid
from PIL import Image, ImageOps

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SPR = 'spr_amaru_battle_brillo'
PLANTILLA = 'spr_amaru_battle_carga'
W, H = 64, 90
ALFA_MIN = 15
NS = uuid.uuid5(uuid.NAMESPACE_DNS, SPR)


def uid(texto):
    return str(uuid.uuid5(NS, texto))


def cuadros():
    src = [ImageOps.mirror(Image.open(f).convert('RGBA')) for f in sorted(glob.glob(os.path.join(RAIZ, 'amarubrillo', '*.png')))]
    cajas = [s.getchannel('A').point(lambda v: 255 if v >= ALFA_MIN else 0).getbbox() for s in src]
    union = (min(c[0] for c in cajas), min(c[1] for c in cajas), max(c[2] for c in cajas), max(c[3] for c in cajas))
    escala = min(W / (union[2] - union[0]), H / (union[3] - union[1]))
    out = []
    for s in src:
        c = s.crop(union)
        c = c.resize((round(c.width * escala), round(c.height * escala)), Image.LANCZOS)
        c.putalpha(c.getchannel('A').point(lambda v: 0 if v < ALFA_MIN else v))
        lienzo = Image.new('RGBA', (W, H), (0, 0, 0, 0))
        lienzo.alpha_composite(c, (W - c.width, H - c.height))
        out.append(lienzo)
    assert len(out) == 5 and all(f.size == (W, H) for f in out)
    return out


def crear_yy(ids, capa):
    """Copia el .yy de carga, que ya está en 01_Batalla, y cambia nombre, medidas, cuadros y capa."""
    t = open(os.path.join(RAIZ, 'sprites', PLANTILLA, PLANTILLA + '.yy'), encoding='utf-8').read()
    viejos = re.findall(r'"name":"([0-9a-f-]{36})","resourceType":"GMSpriteFrame"', t)
    capa_vieja = re.search(r'"\$GMImageLayer":"","%Name":"([0-9a-f-]{36})"', t).group(1)
    t = t.replace(capa_vieja, capa).replace(PLANTILLA, SPR)

    plantilla_f = re.search(r'^ *\{"\$GMSpriteFrame".*\n', t, re.M).group(0)
    bloque_f = ''.join(plantilla_f.replace(viejos[0], i) for i in ids)
    t = re.sub(r'(^ *\{"\$GMSpriteFrame".*\n)+', lambda _: bloque_f, t, flags=re.M)

    plantilla_k = re.search(r'^ *\{"\$Keyframe<SpriteFrameKeyframe>".*\n', t, re.M).group(0)
    id_k = re.search(r'"id":"([0-9a-f-]{36})"', plantilla_k).group(1)
    bloque_k = ''.join(
        plantilla_k.replace(viejos[0], i).replace(id_k, uid('key%d' % n)).replace('"Key":0.0', '"Key":%d.0' % n)
        for n, i in enumerate(ids))
    t = re.sub(r'(^ *\{"\$Keyframe<SpriteFrameKeyframe>".*\n)+', lambda _: bloque_k, t, flags=re.M)

    for clave, valor in (('bbox_bottom', H - 1), ('bbox_left', 0), ('bbox_right', W - 1), ('bbox_top', 0),
                         ('height', H), ('width', W), ('xorigin', W // 2), ('yorigin', H // 2)):
        t = re.sub(r'"%s":\d+' % clave, '"%s":%d' % (clave, valor), t)
    for clave, valor in (('length', len(ids)), ('seqHeight', H), ('seqWidth', W)):
        t = re.sub(r'"%s":[\d.]+' % clave, '"%s":%d.0' % (clave, valor), t)
    return t


def aplicar(fs):
    d = os.path.join(RAIZ, 'sprites', SPR)
    ids = [uid('cuadro%d' % n) for n in range(len(fs))]
    capa = uid('capa')
    for i, im in zip(ids, fs):
        os.makedirs(os.path.join(d, 'layers', i), exist_ok=True)
        im.save(os.path.join(d, i + '.png'))
        shutil.copyfile(os.path.join(d, i + '.png'), os.path.join(d, 'layers', i, capa + '.png'))
    with open(os.path.join(d, SPR + '.yy'), 'w', encoding='utf-8', newline='') as f:
        f.write(crear_yy(ids, capa))

    yyp = os.path.join(RAIZ, 'juego_reconstruido.yyp')
    t = open(yyp, encoding='utf-8', newline='').read()
    if SPR not in t:
        ancla = re.search(r'^ *\{"id":\{"name":"spr_amaru_battle_atk".*\n', t, re.M).group(0)
        t = t.replace(ancla, ancla + ancla.replace('spr_amaru_battle_atk', SPR))
        with open(yyp, 'w', encoding='utf-8', newline='') as f:
            f.write(t)
    print('aplicado', len(ids), 'cuadros')


if __name__ == '__main__':
    fs = cuadros()
    if sys.argv[1:] == ['--aplicar']:
        aplicar(fs)
    else:
        dest = sys.argv[1]
        os.makedirs(dest, exist_ok=True)
        for n, im in enumerate(fs):
            im.save(os.path.join(dest, f'{n}.png'))
        print('generados', len(fs), 'cuadros en', dest)
