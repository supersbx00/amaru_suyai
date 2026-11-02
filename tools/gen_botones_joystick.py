"""Botones del joystick (A, B, X, Y, View) con el disco de madera del Z (spr_button_A), como spr_boton_clic.
Uso: python3 -I gen_botones_joystick.py <repo> <dir_salida>"""
import sys, glob
import numpy as np
from PIL import Image, ImageDraw, ImageFilter, ImageFont

REPO, OUT = sys.argv[1], sys.argv[2]
base = Image.open(glob.glob(f'{REPO}/sprites/spr_button_A/*.png')[0]).convert('RGBA')
lienzo = Image.new('RGBA', (64, 64), (0, 0, 0, 0))
lienzo.alpha_composite(base, (-2, 0))
a = np.array(lienzo).astype(float)

# Disco interior limpio (igual que gen_boton_clic.py)
CX, CY = 31.5, 32.5
RI = 21.5
yy, xx = np.mgrid[0:64, 0:64]
r = np.hypot(xx - CX, yy - CY)
t = np.clip(r / RI, 0, 1)
centro = np.array([250, 178, 40]); borde = np.array([214, 112, 4])
fondo = centro[None, None] * (1 - t[..., None] ** 1.5) + borde[None, None] * (t[..., None] ** 1.5)
fondo += np.random.default_rng(3).normal(0, 4, fondo.shape)
mezcla = np.clip(RI + 1 - r, 0, 1)[..., None]
a[..., :3] = a[..., :3] * (1 - mezcla) + fondo * mezcla
a[r <= RI, 3] = 255
base_limpia = Image.fromarray(np.clip(a, 0, 255).astype(np.uint8), 'RGBA')

SS = 8
grieta = Image.new('RGBA', (64 * SS, 64 * SS), (0, 0, 0, 0))
dg = ImageDraw.Draw(grieta)
for pts in [[(14, 22), (17, 24), (16, 27)], [(46, 40), (43, 43), (45, 46)], [(44, 18), (41, 20)], [(18, 44), (21, 45)]]:
    dg.line([(x * SS, y * SS) for x, y in pts], fill=(120, 50, 0, 150), width=SS)
base_limpia.alpha_composite(grieta.resize((64, 64), Image.LANCZOS))

CREMA = (240, 230, 160, 255)
FUENTE = ImageFont.truetype(f'{REPO}/datafiles/LiberationSansNarrow-Bold.ttf', 38 * SS)

# Colores de barro con el tono de cada botón (oscuros, para que lean sobre el naranjo con el halo crema)
BOTONES = {
    'a': ('A', (28, 110, 22, 255)),
    'b': ('B', (150, 14, 10, 255)),
    'x': ('X', (22, 60, 150, 255)),
    'y': ('Y', (138, 92, 0, 255)),
}

def halo_y_relleno(mascara, color):
    """mascara: L a 64*SS. Halo crema difuso (como la Z) + relleno de color + contorno crema fino."""
    capa = Image.new('RGBA', mascara.size, (0, 0, 0, 0))
    grueso = mascara.filter(ImageFilter.MaxFilter(int(SS * 2.5) | 1))
    halo = Image.new('RGBA', mascara.size, CREMA)
    halo.putalpha(grueso.filter(ImageFilter.GaussianBlur(SS * 0.9)))
    capa.alpha_composite(halo)
    contorno = mascara.filter(ImageFilter.MaxFilter(int(SS * 1.6) | 1))
    capa.paste(Image.new('RGBA', mascara.size, CREMA), (0, 0), contorno)
    capa.paste(Image.new('RGBA', mascara.size, color), (0, 0), mascara)
    return capa.resize((64, 64), Image.LANCZOS)

def letra(ch, color):
    m = Image.new('L', (64 * SS, 64 * SS), 0)
    d = ImageDraw.Draw(m)
    d.text((CX * SS, (CY + 0.5) * SS), ch, font=FUENTE, fill=255, anchor='mm')
    # Trazo grueso, del mismo peso que la Z
    m = m.filter(ImageFilter.MaxFilter(int(SS * 3.2) | 1)).filter(ImageFilter.GaussianBlur(SS * 0.5)).point(lambda v: 255 if v > 110 else 0)
    return halo_y_relleno(m, color)

def view(color):
    # Botón View/Back: dos ventanitas superpuestas
    m = Image.new('L', (64 * SS, 64 * SS), 0)
    d = ImageDraw.Draw(m)
    s = lambda v: v * SS
    d.rounded_rectangle([s(17), s(19), s(38), s(36)], radius=s(3), outline=255, width=int(s(3.5)))
    d.rounded_rectangle([s(25), s(28), s(46), s(45)], radius=s(3), fill=255)
    return halo_y_relleno(m, color)

hojas = []
for nombre, (ch, color) in BOTONES.items():
    f = base_limpia.copy(); f.alpha_composite(letra(ch, color)); f.save(f'{OUT}/spr_boton_{nombre}.png'); hojas.append(f)
f = base_limpia.copy(); f.alpha_composite(view((109, 4, 8, 255))); f.save(f'{OUT}/spr_boton_view.png'); hojas.append(f)

# Comparación: Z, menú, clic | A, B, X, Y, View | A, B y X planos de antes
refs = [Image.open(sorted(glob.glob(f'{REPO}/sprites/{n}/*.png'))[0]).convert('RGBA') for n in ('spr_button_A', 'spr_boton_menu', 'spr_boton_clic')]
viejos = [Image.open(sorted(glob.glob(f'{REPO}/sprites/{n}/*.png'))[0]).convert('RGBA') for n in ('spr_boton_a', 'spr_button_B')]
fila = refs + hojas + viejos
tira = Image.new('RGBA', (72 * len(fila), 72), (90, 90, 90, 255))
for i, im in enumerate(fila):
    tira.alpha_composite(im.crop((0, 0, 64, 64)) if im.width > 64 else im, (72 * i + 4, 4))
tira.resize((tira.width * 3, tira.height * 3), Image.NEAREST).save(f'{OUT}/comparacion.png')
