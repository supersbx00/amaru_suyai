import sys
import os
import re
import json

# Reglas de funciones nativas de GML sugeridas (Ponytail Discipline)
BUILTIN_SUGGESTIONS = {
    r"sqrt\s*\(\s*sqr\([^)]+\)\s*\+\s*sqr\([^)]+\)\s*\)": "point_distance()",
    r"for\s*\(\s*var\s+i\s*=\s*0;\s*i\s*<\s*array_length": "array_foreach() o funciones nativas de arreglos",
}

def load_yyp_resources(yyp_path):
    """Carga los nombres de recursos válidos registrados en el .yyp"""
    resources = set()
    if not os.path.exists(yyp_path):
        return resources
    try:
        with open(yyp_path, "r", encoding="utf-8") as f:
            data = json.load(f)
            for res in data.get("resources", []):
                name = res.get("id", {}).get("name", "")
                if name:
                    resources.add(name)
    except Exception as e:
        print(f"[WARN] No se pudo parsear el .yyp: {e}")
    return resources

def lint_gml_file(file_path, valid_resources):
    """Analiza sintaxis y reglas Ponytail en un archivo .gml"""
    if not os.path.exists(file_path):
        print(f"[ERROR] Archivo no encontrado: {file_path}")
        return

    with open(file_path, "r", encoding="utf-8") as f:
        lines = f.readlines()

    issues = []
    stack = []
    pairs = {')': '(', '}': '{', ']': '['}

    for idx, line in enumerate(lines, 1):
        clean_line = line.split("//")[0] # Ignorar comentarios de línea

        # 1. Balance de llaves / paréntesis
        for char in clean_line:
            if char in "({[":
                stack.append((char, idx))
            elif char in ")}]":
                if not stack or stack[-1][0] != pairs[char]:
                    issues.append(f"Línea {idx}: Error de sintaxis, '{char}' no coincide con apertura.")
                else:
                    stack.pop()

        # 2. Ponytail: Detección de código reinventado
        for pattern, suggestion in BUILTIN_SUGGESTIONS.items():
            if re.search(pattern, clean_line):
                issues.append(f"Línea {idx} [PONYTAIL]: Considera usar la función nativa '{suggestion}'.")

        # 3. Referencias a recursos inexistentes (spr_, obj_, scr_)
        found_refs = re.findall(r'\b(spr_\w+|obj_\w+|scr_\w+)\b', clean_line)
        for ref in found_refs:
            if valid_resources and ref not in valid_resources:
                issues.append(f"Línea {idx} [RESOURCE]: El recurso '{ref}' no está registrado en el .yyp.")

    # Símbolos no cerrados
    for char, line_num in stack:
        issues.append(f"Línea {line_num}: Símbolo '{char}' quedó sin cerrar al final del archivo.")

    # Reporte
    print(f"\n--- Reporte para: {file_path} ---")
    if not issues:
        print("[OK] Sintaxis limpia y cumple con las reglas de Ponytail.")
    else:
        for issue in issues:
            print(f"  ❌ {issue}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Uso: python3 tools/gml_linter.py <archivo_o_directorio.gml> [ruta_proyecto.yyp]")
        sys.exit(1)

    target = sys.argv[1]
    yyp = sys.argv[2] if len(sys.argv) > 2 else "proyecto_reconstruido_v2.yyp"
    resources = load_yyp_resources(yyp)

    if os.path.isfile(target):
        lint_gml_file(target, resources)
    elif os.path.isdir(target):
        for root, _, files in os.walk(target):
            for file in files:
                if file.endswith(".gml"):
                    lint_gml_file(os.path.join(root, file), resources)