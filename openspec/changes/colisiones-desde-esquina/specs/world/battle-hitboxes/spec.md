# Spec Delta

## MODIFIED Requirements

### Requirement: Colisiones de batalla alineadas con el dibujo
En batalla, la forma de colisión de Amaru, de los enemigos y de sus proyectiles SHALL cubrir el cuerpo dibujado de cada uno, comprobado en el juego con F3. Un proyectil MUST impactar cuando toca el cuerpo visible, y MUST NOT impactar cuando pasa al lado sin tocarlo.

#### Scenario: Arpón que toca al enemigo
- **WHEN** el arpón de Amaru toca el cuerpo visible del enemigo
- **THEN** el enemigo recibe el daño

#### Scenario: Arpón que pasa por debajo
- **WHEN** el arpón pasa por debajo o al costado del enemigo sin tocar su dibujo
- **THEN** el enemigo no recibe daño

#### Scenario: Ver las colisiones
- **WHEN** el jugador presiona F3 en una batalla
- **THEN** se muestran las formas de colisión sobre los sprites, y al presionarlo otra vez se ocultan
