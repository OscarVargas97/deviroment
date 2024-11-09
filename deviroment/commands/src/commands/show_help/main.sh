#!/bin/bash

echo "Uso: hos {comando}"
echo ""
echo "Comandos disponibles:"
# New_Commands:
echo "  home        Redirecciona al directorio donde se encuentran los proyectos de HOStudios"
echo "  code        Si usas el nombre del proyecto y b o f concatenado, se abre el backen o el front del proyecto"
echo "              la lista de proyectos, te lo dicta al ejecutar el comando sin argumento"
echo "  rcode        Si usas el nombre del proyecto + (b|f) (ejemplo: proyectob|proyectof ) abrira el contenedor de "
echo "              desarrollo en vs code "
echo "  compose     Si usas el nombre del proyecto y b o f concatenado, se ejecutara docker compose del backen o "                    
echo "              del front del proyecto la lista de proyectos, te lo dicta al ejecutar el comando sin argumento"
echo "  attach     Si usas el nombre del proyecto y b o f concatenado, se abrira el contenedor de desarrollo en tu consola"                    