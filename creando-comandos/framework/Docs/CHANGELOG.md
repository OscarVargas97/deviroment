# Changelog

Todas las notas importantes de los cambios en este proyecto se documentarán en este archivo.

## [Unreleased]
### Added
#### Proyecto:
-Cuando se genera un proyecto. existe una carpeta llamada helpers (contiene funcionalidades comunes entre el proyecto).
Identificar que funcionalidades comunes ya existen y segmentarlas en el helper para framework.
- Cuando un proyecto se genera, Se debe generar una carpeta Docs con un CHANGELOG.md correspondiente
- Cuando se genera un proyecto, se debe generar una carpeta Public correspondiente
- Cuando se genera un proyecto, debe incluirse un .gitignore correspondiente
- El comando del proyecto debe poder ser llamado independiente de main.sh, de manera que se pueda separar de framework
- Framework, deberá solicitar una direccion del proyecto y almacenarlo en un archivo, para ser independiente de la direccion del proyecto en creación

#### Gestión de versiones y cambios.
- Necesito una funcionalidad que genere los cambios realizados en un archivo CHANGELOG.md
- Necesito una funcionalidad que establezca una nueva version. Generando los cambios correspondientes de la version
limpiando los cambios realizados.
- Estos comandos se deben generar en cada proyecto creado

#### Command:
Cuando se crea Command agregar una carpeta helper que contenga los helpers de commands
Identificar los helpers de command

####  Subcomandos:
Agregar la parte se subcomands

####  Rutas:
- Debo integrar una manera de identificar la diferencia entre un comando y una ruta. Es decir, hay casos donde se especificaran rutas
y otro casos donde seran subcomandos, debo especificar en cada posicion de comandos cuando es un subcomand y cuando es una ruta.
Esto dependera de cada comando. Pero el punto es que se debe modificar como se esta comportando la ejecucion de comando, ya que no es correcta la manera generica actual.

### Changed

### Fixed


## [Versión X.X.X] - YYYY-MM-DD
### Added

### Changed

### Fixed





