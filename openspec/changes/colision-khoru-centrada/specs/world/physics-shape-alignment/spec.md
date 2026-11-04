# Spec Delta

## MODIFIED Requirements

### Requirement: Formas de colisión centradas en el sprite
La forma de colisión de cada objeto con física SHALL tener su centro en el centro del dibujo de su sprite, comprobado en el juego con F6 o F3, con una tolerancia de 4 px. Al centrarla, la forma MUST conservar su tamaño (radio del círculo o medidas de la caja), salvo que otro requisito indique que debe cubrir el dibujo.

#### Scenario: Chocar con un NPC
- **WHEN** Amaru camina hacia un NPC en el mapa
- **THEN** se detiene al tocar el dibujo del NPC, no antes ni a un costado

#### Scenario: Proyectil enemigo
- **WHEN** una bola de fuego, un rayo o un hielo pasa al lado de Amaru sin tocar su dibujo
- **THEN** Amaru no recibe daño

## ADDED Requirements

### Requirement: Colisión de Khoru en el desafío
La colisión de Khoru en el desafío de `rm_momificar` SHALL cubrir todo su dibujo. Amaru MUST poder hablarle después de chocar con él desde cualquier lado.

#### Scenario: Ver la colisión de Khoru
- **WHEN** Khoru aparece en `rm_momificar` y se presiona F6
- **THEN** la caja de colisión cubre a Khoru, sin quedar corrida hacia un lado

#### Scenario: Chocar y hablar
- **WHEN** Amaru choca con Khoru desde arriba, abajo, la izquierda o la derecha
- **THEN** se detiene al tocar su dibujo y aparece el aviso para hablarle
