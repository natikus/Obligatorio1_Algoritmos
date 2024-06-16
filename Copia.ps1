#3)
#creo la carpeta respaldo si es que no existe
if (!(Test-Path "C:\respaldo")) {
    New-Item -ItemType Directory -Path "C:\respaldo"
}
#obtengo la fecha actual
$fechaActual = Get-Date -Format "yyyy-MMdd"
#guardo el nombre que va a tener la carpeta
$nombreArchivo = "$fechaActual.zip"
#comprimo la carpeta para crear su respaldo 
Compress-Archive -Path C:\compartida -DestinationPath "C:\RESPALDO\$nombreArchivo"