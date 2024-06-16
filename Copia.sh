#!/bin/bash

# 3) Crea la carpeta de respaldo si ya no existe
if [ ! -d "C:/respaldo" ]; then
    mkdir "C:/respaldo"
fi

# Obtiene la fecha actual
fecha_actual=$(date +%Y-%m-%d)

# crea el nombre del archivo
nombre_archivo="$fecha_actual.zip"

# comprime el archivo 
zip -r "C:/RESPALDO/$nombre_archivo" "C:/compartida"
