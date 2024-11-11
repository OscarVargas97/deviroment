# Entorno de Desarrollo
Este script permite instalar y configurar un entorno de desarrollo automatizado, gestionando la instalación de herramientas esenciales como Docker, Docker Compose, Git, y `xxd`. También crea la estructura de directorios necesarios para los proyectos de la empresa y clona los repositorios de GitHub indicados. Además, configura los aliases necesarios para facilitar el uso de los comandos.

## Sistemas Compatibles

Este script está diseñado para ser compatible con las siguientes distribuciones de Linux:

* **Fedora** (principalmente utilizado en este sistema).
* **Ubuntu**
* **Windows Subsystem for Linux (WSL)** : Aunque es posible que el script funcione en WSL, se requiere una configuración especial para Docker. No es compatible con Docker Desktop; se debe realizar una instalación directa de Docker dentro de WSL para asegurar la funcionalidad.

Las configuraciones y comandos de instalación son específicos para estas distribuciones, garantizando que las dependencias y herramientas se instalen correctamente en cada una.

## Funcionalidades Principales

- **Instalación de herramientas:** Docker, Docker Compose, Git y `xxd` (según la distribución Linux detectada).
- **Clonación de proyectos:** Clona los repositorios de GitHub de la empresa en una carpeta específica dentro del sistema.
- **Configuración de aliases:** Automatiza la carga de comandos específicos en los archivos de configuración `.bashrc` o `.zshrc`.
- **Desinstalación opcional:** Permite la eliminación del entorno y los aliases configurados.

## Ejecución

Para ejecutar el script, asegúrate de tener permisos de ejecución y utiliza el siguiente comando en la terminal:

```bash
./install.sh
```

Una vez ejecutado, el script pedirá confirmación para instalar o desinstalar el entorno de desarrollo.

## Comandos Disponibles

Una vez instalado, el entorno de desarrollo incluye los siguientes comandos que se ejecutan usando `hos {comando}`:

- **home**: Redirecciona al directorio donde se encuentran los proyectos de la empresa.
- **code**: Abre el proyecto especificado con Visual Studio Code. Si no se indica un proyecto, muestra la lista de proyectos disponibles. (Ejemplo: `hos code {proyecto}`)
- **rcode**: Abre el proyecto especificado en Visual Studio Code dentro del contenedor de desarrollo. Si no se indica un proyecto, muestra la lista de proyectos disponibles. (Ejemplo: `hos rcode {proyecto}`)
- **compose**: Ejecuta comandos de Docker Compose desde cualquier ubicación. Puedes añadir cualquier comando adicional tras el nombre del proyecto. (Ejemplo: `hos compose {proyecto} up -d`). Si no se indica un proyecto, muestra la lista de proyectos disponibles.
- **attach**: Ingresa al contenedor de desarrollo de un proyecto desde cualquier ubicación. Si no se indica un proyecto, muestra la lista de proyectos disponibles. (Ejemplo: `hos attach {proyecto}`)

## Futuras Implementaciones

Se planea agregar las siguientes funcionalidades al script:

- **Instalación de GitHub CLI**: Comandos para instalar GitHub CLI tanto en Fedora como en Ubuntu.
- **Automatización en la obtención de proyectos**: Se planea incluir una función que permita la descarga automatizada de proyectos directamente desde GitHub o GitLab, facilitando la gestión de repositorios. El script resolverá los nombres de los proyectos automáticamente, sin necesidad de declararlos explícitamente, consultando directamente en la plataforma seleccionada (GitHub o GitLab) para obtener y sincronizar los nombres de los repositorios.
- **Comando para generar un nuevo proyecto**:
  - Se solicitarán los datos necesarios para crear un proyecto.
  - El script descargará archivos de Docker desde un repositorio central si están disponibles.
  - Se nombrará al contenedor de desarrollo y se configurará según los datos proporcionados.
  - Se generará un nuevo repositorio en GitHub o GitLab (según la plataforma seleccionada) y se añadirá a los comandos válidos del entorno de desarrollo.

## Deuda Técnica

Actualmente, el protocolo de versionado en Git no está implementado, y los mensajes de commit no siguen ninguna regla uniforme ni son suficientemente descriptivos. Este aspecto del flujo de trabajo está en proceso de revisión para establecer un estándar de versionado.

Además, se ha identificado un problema en ciertos casos al levantar el contenedor de desarrollo y acceder a este mediante Visual Studio Code: la terminal Zsh no se configura correctamente. Este problema está bajo investigación, y se están revisando los archivos de configuración de Docker para encontrar la causa y posibles soluciones.
