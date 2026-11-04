# Spec Delta

## Purpose

Definir cómo se ve Khoru fuera de la batalla, para que se dibuje nítido y con el mismo tamaño en el tutorial y en el mapa.

## ADDED Requirements

### Requirement: Khoru nítido sin reescalar
Fuera de la batalla, Khoru SHALL dibujarse a escala 1, con un sprite de 66×102 px y origen en su centro. Solo MUST invertirse en horizontal para mirar al otro lado.

#### Scenario: Khoru en el tutorial
- **WHEN** Khoru aparece en `rm_tutorial_test` y gira en los pasos 28 y 30
- **THEN** ocupa el mismo lugar y tamaño que antes, se ve más nítido y gira sin cambiar de tamaño

#### Scenario: Khoru en el desafío de los camarones
- **WHEN** Khoru aparece en el desafío y espera a Amaru
- **THEN** se ve a escala 1 y el aviso de interacción queda a la misma altura que antes

#### Scenario: Khoru en rm_final_morro
- **WHEN** el jugador llega a Khoru en `rm_final_morro`
- **THEN** Khoru se ve del mismo tamaño que en las otras salas y conserva su centro

### Requirement: Contorno y apariencia de Khoru
El sprite de Khoru SHALL tener la silueta limpia y un contorno oscuro en los bordes de piel y hueso. Además MUST conservar el diseño, el tono de piel, los ojos rojos y la animación de 6 cuadros.

#### Scenario: Comparación con el sprite anterior
- **WHEN** se comparan los 6 cuadros con los anteriores
- **THEN** se mantienen la pose, los ojos rojos y el movimiento de la capa, sin píxeles sueltos alrededor de la silueta

### Requirement: Colisiones de Khoru conservadas
Cambiar el sprite de Khoru MUST NOT cambiar sus formas de física ni la posición de sus instancias.

#### Scenario: Chocar con Khoru
- **WHEN** Amaru camina hacia Khoru en el desafío o en `rm_final_morro`
- **THEN** se detiene en el mismo lugar que antes
