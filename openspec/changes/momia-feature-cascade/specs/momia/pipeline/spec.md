# Spec Delta

## Purpose

Definir que el minijuego de momia ejecuta su lógica como pipeline en cascada, sin alterar su comportamiento ni la forma en que otras features lo llaman.

## ADDED Requirements

### Requirement: Comportamiento del minijuego conservado
Aplicar la cascada al minijuego de momia MUST NOT cambiar el comportamiento del juego ni la forma en que otros módulos llaman a sus funciones.

#### Scenario: Minijuego con mouse
- **WHEN** se juega `rm_Momia` completo con mouse después del cambio
- **THEN** cada paso funciona igual que en la prueba previa

#### Scenario: Minijuego con joystick
- **WHEN** se toma una pieza con A y se suelta con B después del cambio
- **THEN** la pieza sigue tomada desde A hasta B, igual que antes

#### Scenario: Fabricación desde el menú
- **WHEN** se fabrica una pieza en la pestaña Momificar de Creación después del cambio
- **THEN** los materiales y las piezas cambian igual que antes
