"""Pruebas de sprite_processor.py, una por escenario de la especificación sprite-tooling.

Uso:
  python3 -m unittest tools/test_sprite_processor.py
"""
import os, shutil, subprocess, sys, tempfile, unittest
import numpy as np
from PIL import Image

SCRIPT = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'sprite_processor.py')
ROJO = (200, 30, 30)
AZUL = (30, 30, 200)


def lienzo(w, h):
    return np.zeros((h, w, 4), 'uint8')


class Base(unittest.TestCase):
    def setUp(self):
        self.d = tempfile.mkdtemp()
        self.addCleanup(shutil.rmtree, self.d)
        # copia en <tmp>/tools/, así la raíz del script es <tmp> y la paleta por defecto se controla en cada prueba
        os.makedirs(os.path.join(self.d, 'tools'))
        self.script = os.path.join(self.d, 'tools', 'sprite_processor.py')
        shutil.copyfile(SCRIPT, self.script)
        self.ent = os.path.join(self.d, 'ent.png')
        self.sal = os.path.join(self.d, 'sal.png')
        self.pal = os.path.join(self.d, 'pal.png')

    def correr(self, a, cw, ch, *extra):
        Image.fromarray(a, 'RGBA').save(self.ent)
        return subprocess.run([sys.executable, self.script, self.ent, self.sal, str(cw), str(ch), *extra],
                              capture_output=True, text=True, cwd=self.d)

    def salida(self):
        return np.array(Image.open(self.sal).convert('RGBA'))

    def paleta(self, colores, ruta=None):
        p = Image.new('RGB', (len(colores), 1))
        p.putdata(colores)
        p.save(ruta or self.pal)

    def bloque(self, w=8, h=8, color=(100, 120, 140)):
        a = lienzo(w, h)
        a[2:6, 2:6] = (*color, 255)
        return a


class Paleta(Base):
    def test_colores_del_resultado(self):
        self.paleta([ROJO, AZUL])
        a = self.bloque(color=(180, 40, 60))
        a[2:4, 2:6] = (50, 40, 180, 255)
        r = self.correr(a, 8, 8, self.pal, '--ancla', 'ninguna')
        self.assertEqual(r.returncode, 0, r.stderr)
        s = self.salida()
        visibles = {tuple(c) for c in s[s[..., 3] > 0][:, :3].tolist()}
        self.assertEqual(visibles, {ROJO, AZUL})

    def test_conserva_alfa(self):
        self.paleta([ROJO])
        a = self.bloque()
        a[2:6, 2:6, 3] = 90
        self.correr(a, 8, 8, self.pal, '--ancla', 'ninguna')
        self.assertTrue((self.salida()[2:6, 2:6, 3] == 90).all())

    def test_paleta_con_mas_de_256_colores(self):
        self.paleta([(i % 256, i // 256, 0) for i in range(257)])
        r = self.correr(self.bloque(), 8, 8, self.pal)
        self.assertNotEqual(r.returncode, 0)
        self.assertFalse(os.path.exists(self.sal))

    def test_paleta_inexistente(self):
        r = self.correr(self.bloque(), 8, 8, os.path.join(self.d, 'no_existe.png'))
        self.assertNotEqual(r.returncode, 0)
        self.assertFalse(os.path.exists(self.sal))
        self.assertNotIn('[OK]', r.stdout)

    def test_paleta_por_defecto_ausente(self):
        r = self.correr(self.bloque(), 8, 8)
        self.assertNotEqual(r.returncode, 0)
        self.assertFalse(os.path.exists(self.sal))

    def test_sin_argumento_usa_la_paleta_por_defecto(self):
        self.paleta([AZUL], os.path.join(self.d, 'palette_reference.png'))
        r = self.correr(self.bloque(), 8, 8)
        self.assertEqual(r.returncode, 0, r.stderr)
        s = self.salida()
        self.assertEqual({tuple(c) for c in s[s[..., 3] > 0][:, :3].tolist()}, {AZUL})

    def test_omision_explicita(self):
        r = self.correr(self.bloque(), 8, 8, '--sin-paleta', '--ancla', 'ninguna')
        self.assertEqual(r.returncode, 0, r.stderr)
        self.assertEqual(tuple(self.salida()[3, 3]), (100, 120, 140, 255))


class Grilla(Base):
    def test_multiplo_de_la_celda_sin_escalar(self):
        a = lienzo(70, 40)
        a[5:9, 5:9] = (100, 120, 140, 255)
        r = self.correr(a, 32, 32, '--sin-paleta', '--ancla', 'ninguna')
        self.assertEqual(r.returncode, 0, r.stderr)
        s = self.salida()
        self.assertEqual(s.shape[:2], (64, 96))
        self.assertTrue((s[5:9, 5:9] == a[5:9, 5:9]).all())
        self.assertEqual(int((s[..., 3] > 0).sum()), 16)


class Origen(Base):
    def test_cuadros_desplazados(self):
        a = lienzo(32, 16)
        a[1:5, 2:6] = (100, 120, 140, 255)
        a[9:13, 24:28] = (100, 120, 140, 255)
        r = self.correr(a, 16, 16, '--sin-paleta')
        self.assertEqual(r.returncode, 0, r.stderr)
        s = self.salida()
        self.assertTrue((s[:, :16] == s[:, 16:]).all())
        ys, xs = np.nonzero(s[:, :16, 3])
        self.assertEqual((ys.max(), xs.min(), xs.max()), (15, 6, 9))

    def test_origen_informado(self):
        r = self.correr(self.bloque(64, 64), 64, 64, '--sin-paleta')
        self.assertIn('x=32, y=63', r.stdout)

    def test_sin_alineacion(self):
        a = self.bloque()
        r = self.correr(a, 8, 8, '--sin-paleta', '--ancla', 'ninguna')
        self.assertEqual(r.returncode, 0, r.stderr)
        self.assertTrue((self.salida() == a).all())

    def test_celda_vacia(self):
        a = lienzo(16, 8)
        a[2:6, 2:6] = (100, 120, 140, 255)
        r = self.correr(a, 8, 8, '--sin-paleta')
        self.assertEqual(r.returncode, 0, r.stderr)
        self.assertEqual(int(self.salida()[:, 8:, 3].sum()), 0)


class Limpieza(Base):
    def test_alfa_bajo(self):
        a = self.bloque()
        a[3, 3, 3] = 14
        self.correr(a, 8, 8, '--sin-paleta', '--ancla', 'ninguna')
        self.assertEqual(tuple(self.salida()[3, 3]), (0, 0, 0, 0))

    def test_pixel_aislado(self):
        a = lienzo(8, 8)
        a[1, 1] = (100, 120, 140, 255)
        self.correr(a, 8, 8, '--sin-paleta', '--ancla', 'ninguna')
        self.assertEqual(int(self.salida()[..., 3].sum()), 0)

    def test_diagonal_conectada(self):
        a = lienzo(8, 8)
        a[1, 1] = a[2, 2] = (100, 120, 140, 255)
        self.correr(a, 8, 8, '--sin-paleta', '--ancla', 'ninguna')
        s = self.salida()
        self.assertEqual((s[1, 1, 3], s[2, 2, 3]), (255, 255))

    def test_conservar_aislados(self):
        a = lienzo(8, 8)
        a[1, 1] = (100, 120, 140, 255)
        self.correr(a, 8, 8, '--sin-paleta', '--ancla', 'ninguna', '--conservar-sueltos')
        self.assertEqual(self.salida()[1, 1, 3], 255)


class Solapamiento(Base):
    def cruzado(self):
        a = lienzo(16, 8)
        a[3:5, 6:10] = (100, 120, 140, 255)
        return a

    def test_dibujo_que_cruza_el_borde(self):
        r = self.correr(self.cruzado(), 8, 8, '--sin-paleta')
        self.assertIn('solapa', (r.stdout + r.stderr).lower())

    def test_salida_con_advertencia(self):
        r = self.correr(self.cruzado(), 8, 8, '--sin-paleta')
        self.assertEqual(r.returncode, 0, r.stderr)
        self.assertTrue(os.path.exists(self.sal))


if __name__ == '__main__':
    unittest.main()
