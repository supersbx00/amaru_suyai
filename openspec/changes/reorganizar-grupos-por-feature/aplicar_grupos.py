#!/usr/bin/env python3
"""Aplica grupos.json: cambia `parent` en cada .yy y `Folders` en el .yyp.

Sin argumentos solo informa. Con --aplicar escribe, y solo si no hubo errores.
Ejecutar desde la raíz del proyecto, con GameMaker cerrado.
"""
import glob
import json
import os
import re
import sys

# shortcut: usa el orden IDE de gms-mcp en su venv, copiar la función si se reutiliza en otra máquina
sys.path.insert(0, "/usr/local/py-utils/venvs/gms-mcp/lib/python3.11/site-packages")
from gms_helpers.gm_order import ide_2026_key

YYP = "juego_reconstruido.yyp"
MAPEO = os.path.join(os.path.dirname(os.path.abspath(__file__)), "grupos.json")
RAICES = {"Fonts", "Objects", "Paths", "Rooms", "Scripts", "Shaders", "Sounds", "Sprites", "Tile Sets"}
CONSERVAR = {"Scripts/grupo1"}
PARENT = re.compile(r'("parent"\s*:\s*\{\s*"name"\s*:\s*")[^"]*("\s*,\s*"path"\s*:\s*"folders/)([^"]*)(\.yy")')
FOLDER = re.compile(r'"folderPath":"folders/([^"]*)\.yy"')
ENTRADA = '    {{"$GMFolder":"","%Name":"{n}","folderPath":"folders/{g}.yy","name":"{n}","resourceType":"GMFolder","resourceVersion":"2.0",}},'


def leer(ruta):
    with open(ruta, encoding="utf-8", newline="") as f:
        return f.read()


def escribir(ruta, texto):
    with open(ruta, "w", encoding="utf-8", newline="") as f:
        f.write(texto)


def con_ancestros(grupo):
    partes = grupo.split("/")
    return {"/".join(partes[: i + 1]) for i in range(len(partes))}


def clave(grupo):
    return ide_2026_key(f"folders/{grupo}.yy")


def calcular_folders(actuales, usados):
    """Devuelve (grupos finales ordenados, a crear, a retirar)."""
    necesarios = RAICES | CONSERVAR
    for grupo in usados | CONSERVAR:
        necesarios |= con_ancestros(grupo)
    finales = necesarios | {g for g in actuales if g.startswith("Sprites/")}
    return sorted(finales, key=clave), sorted(finales - set(actuales), key=clave), sorted(set(actuales) - finales, key=clave)


def autoprueba():
    finales, crear, retirar = calcular_folders(
        ["01_Viejo", "01_Viejo/Objects", "Scripts", "Sprites", "Sprites/X"], {"02_Nuevo/Sub", "Sprites/X"}
    )
    assert crear[:2] == ["02_Nuevo", "02_Nuevo/Sub"], crear
    assert retirar == ["01_Viejo", "01_Viejo/Objects"], retirar
    assert "Scripts/grupo1" in finales and "Sprites/X" in finales and "Fonts" in finales, finales
    bloque = '"parent":{"name":"A","path":"folders/A/B.yy",},'
    assert PARENT.search(bloque).group(3) == "A/B"


def main():
    autoprueba()
    aplicar = "--aplicar" in sys.argv
    errores = []
    mapeo = json.load(open(MAPEO, encoding="utf-8"))
    yyp = leer(YYP)

    cambios = {}
    for ruta, grupo in mapeo.items():
        if not os.path.exists(ruta):
            errores.append(f"no existe: {ruta}")
            continue
        if f'"path":"{ruta}"' not in yyp:
            errores.append(f"no registrado en el .yyp: {ruta}")
        texto = leer(ruta)
        if len(PARENT.findall(texto)) != 1:
            errores.append(f"no tiene un único parent: {ruta}")
            continue
        nombre = grupo.rsplit("/", 1)[-1]
        nuevo = PARENT.sub(lambda m: f"{m[1]}{nombre}{m[2]}{grupo}{m[4]}", texto)
        if nuevo != texto:
            cambios[ruta] = nuevo

    # Grupos en uso después del mapeo, contando también los recursos fuera de él (sprites, tilesets, etc.).
    usados = set(mapeo.values())
    for ruta in glob.glob("*/*/*.yy"):
        if ruta.replace(os.sep, "/") not in mapeo:
            m = PARENT.search(leer(ruta))
            if m:
                usados.add(m[3])

    salto = "\r\n" if "\r\n" in yyp else "\n"
    lineas = yyp.split(salto)
    filas = [i for i, l in enumerate(lineas) if '"resourceType":"GMFolder"' in l]
    if filas != list(range(filas[0], filas[-1] + 1)) or '"Folders":[' not in lineas[filas[0] - 1]:
        errores.append("Folders no es un bloque continuo de una entrada por línea")
    actuales = [FOLDER.search(lineas[i])[1] for i in filas]
    if actuales != sorted(actuales, key=clave):
        errores.append("Folders no sigue hoy el orden IDE")

    finales, crear, retirar = calcular_folders(actuales, usados)
    existentes = dict(zip(actuales, (lineas[i] for i in filas)))
    bloque = [existentes.get(g) or ENTRADA.format(n=g.rsplit("/", 1)[-1], g=g) for g in finales]
    nuevo_yyp = salto.join(lineas[: filas[0]] + bloque + lineas[filas[-1] + 1 :])

    print(f"Recursos en el mapeo: {len(mapeo)}; con cambio de parent: {len(cambios)}")
    print(f"Folders: {len(actuales)} -> {len(finales)}; a crear: {len(crear)}; a retirar: {len(retirar)}")
    print("Crear:", ", ".join(crear))
    print("Retirar:", ", ".join(retirar))
    print("Errores:", len(errores))
    for e in errores:
        print(" -", e)
    if errores:
        return 1
    if not aplicar:
        print("Ensayo: no se escribió nada. Usa --aplicar para escribir.")
        return 0
    for ruta, texto in cambios.items():
        escribir(ruta, texto)
    escribir(YYP, nuevo_yyp)
    print("Aplicado.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
