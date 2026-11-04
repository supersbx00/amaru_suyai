# Reglas de Workflow en Git & Claude Code

## 1. Estrategia de Ramas (Feature-Driven Branching)
- **`dev`:** Rama de integración. Las ramas `feature/` y `fix/` salen de `dev` y vuelven a `dev`.
- **`main`:** Código estable y testeado. Prohibidos los commits directos.
- **`feature/<nombre-feature>`:** Ramas independientes para cada módulo de la arquitectura Feature Cascade (ej. `feature/ponytail-physics`, `feature/event-bus`).
- **`fix/<descripcion-corta>`:** Ramas específicas para corrección de bugs.

## 2. Prevención de Conflictos en GameMaker (CRÍTICO)
- **Granularidad de Recursos:** No trabajes en el mismo objeto (`.yy`) o evento desde dos ramas distintas simultáneamente; los JSONs de GameMaker son propensos a conflictos complejos de merge.
- **Integridad del `.yyp`:** Antes de fusionar una rama, verifica que el archivo principal `.yyp` mantenga la estructura de carpetas e índices correcta.

## 3. Convención de Commits Atómicos
- Utilizar el estándar **Conventional Commits**:
  - `feat(scope):` Nueva funcionalidad (ej. `feat(player): agregar struct de movimiento secundario`).
  - `fix(scope):` Corrección de errores.
  - `refactor(scope):` Reestructuración de código GML sin cambiar comportamiento.
  - `docs(scope):` Cambios en documentación o reglas `.md`.
  - `chore(scope):` Actualizaciones de configuración (`.gitignore`, `.mcp.json`).
- Los commits deben ser pequeños y enfocados en un solo cambio para facilitar revertir cambios si un `.yy` se daña.
- Mensajes en español y sin línea de coautor.
- `openspec/` está ignorado: los cambios activos se agregan con `git add -f openspec/changes/<cambio>`, sin `archive/`.

## 4. Control de Ejecución de Git para Claude Code
- **Aprobación Previa:** Claude Code NUNCA debe ejecutar `git commit`, `git push`, `git checkout`, `git merge` ni `git rebase` sin solicitar y recibir autorización explícita.
- **Revisión antes de Commit:** Invocar `git status` y `git diff` para revisar exactamente qué archivos `.gml`, `.yy` o `.md` han sido modificados antes de sugerir un mensaje de commit.
- **Archivos Excluidos:** Asegurar que el `.gitignore` ignore carpetas temporales de compilación (`.gmedit/`, `export/`, `*.yyz`, `[bc]ache/`).