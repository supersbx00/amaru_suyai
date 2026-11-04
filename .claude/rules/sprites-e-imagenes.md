# Reglas de Procesamiento y Generación de Sprites (DevContainer + Pillow)

## 1. Control de Grilla y Anti-Solapamiento (OBLIGATORIO)
- **Celdas Uniformes:** Todo sprite sheet generado o importado debe alinearse a una cuadrícula con tamaño de celda constante (ej. 32x32, 48x48 o 64x64 px).
- **Consistencia de Origen:** El punto de anclaje de cada frame dentro de la celda debe ser uniforme para evitar saltos o vibraciones (*jitter*) en las animaciones de GameMaker.
- **Limpieza Alfa:** Remover píxeles sueltos o semi-transparentes (alfa < 15) para evitar bordes ruidosos o solapamiento de marcos.

## 2. Consistencia de Paleta Pixel Art
- **Remapeo de Colores:** Los assets procesados deben cuantizarse usando la paleta oficial extraída de los sprites del proyecto (`palette_reference.png`).
- **Sin Anti-Aliasing:** Prohibida la interpolación bilineal o gradientes suaves que rompan el estilo pixel art.

## 3. Generación y Procesamiento Procedural
- Para elementos de UI (botones, barras, marcos), utilizar preferentemente generadores en Python mediante `Pillow` antes que APIs externas.
- Ante cualquier asset gráfico generado o importado, ejecutar el post-procesador:
  `python3 tools/sprite_processor.py <input.png> <output.png> <cell_w> <cell_h> [palette.png]`

## 4. Flujo y Alcance
- El arte también pasa por OpenSpec, con comparación antes/después y aprobación antes de aplicarlo.
- La paleta se aplica solo a assets nuevos, nunca a los sprites existentes. Si un asset se ve con bandas de color, se usa `--sin-paleta` con el visto bueno del usuario.