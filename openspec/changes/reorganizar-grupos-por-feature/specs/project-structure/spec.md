# Spec Delta

## Purpose

Definir dónde viven los recursos del juego y cómo se agrupan en GameMaker, para encontrar cada mecánica por su feature sin alterar las rutas nativas.

## ADDED Requirements

### Requirement: Rutas nativas de GameMaker
Los recursos SHALL conservar la ubicación física y la ruta del proyecto que GameMaker asigna por defecto. Reorganizar grupos MUST NOT cambiar esas rutas.

#### Scenario: Reorganización de grupos
- **WHEN** se comparan las rutas de recursos del proyecto antes y después de reorganizar
- **THEN** las rutas son idénticas y ningún archivo cambió de carpeta

### Requirement: Grupos por feature y responsabilidad
Cada objeto, script y room SHALL pertenecer a un grupo `<Feature>/<Responsabilidad>`, y los grupos de feature MUST NOT separar recursos con subgrupos por tipo como `Scripts`, `Objects` o `Rooms`.

#### Scenario: Árbol de recursos
- **WHEN** se abre el proyecto en GameMaker
- **THEN** cada objeto, script y room aparece en el grupo asignado por el mapeo del proyecto

#### Scenario: Recurso compartido
- **WHEN** un objeto o script lo usan varias features y ninguna es su dueña
- **THEN** se ubica en `00_Core`

#### Scenario: Recurso nuevo
- **WHEN** se crea un objeto, script o room
- **THEN** se asigna al grupo de su feature y su archivo queda en la ruta por defecto

### Requirement: Grupos antiguos retirados sin perder recursos
Un grupo antiguo SHALL retirarse solo cuando ningún recurso ni subgrupo dependa de él.

#### Scenario: Sonidos, paths y fuentes
- **WHEN** un sonido, path o fuente está en un grupo que se retira
- **THEN** pasa a un grupo vigente antes de retirar el anterior

#### Scenario: Grupos conservados
- **WHEN** termina la reorganización
- **THEN** los grupos raíz de GameMaker, `grupo1` y los grupos de sprites siguen presentes

### Requirement: Comportamiento conservado
Reorganizar grupos MUST NOT cambiar el código GML, el orden de rooms ni el comportamiento del juego.

#### Scenario: Código y orden de rooms
- **WHEN** se revisan los cambios
- **THEN** ningún archivo `.gml` cambió y el orden de rooms es idéntico

#### Scenario: Partida en GameMaker
- **WHEN** el usuario abre el proyecto, ejecuta el juego, guarda y lo cierra
- **THEN** no se informan recursos faltantes, el juego funciona igual y los grupos se mantienen
