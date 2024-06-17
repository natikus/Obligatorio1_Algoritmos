#!/bin/bash

# 3) Crea la carpeta de respaldo si ya no existe
if [ ! -d "/respaldo" ]; then
    sudo mkdir "/respaldo"
fi

# Obtiene la fecha actual
fecha_actual=$(date +%Y-%m-%d)

# crea el nombre del archivo
nombre_archivo="$fecha_actual.zip"

# comprime el archivo 
sudo zip -r "/respaldo/$nombre_archivo" "/compartida"
