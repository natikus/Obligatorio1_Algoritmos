#!/bin/bash

#crea los grupos
CrearGrupo() {
    group=$1

    adgroup addcn -n "$group" -dn "CN=$group,DC=example,DC=com"
}

# CCrea los usuarios
newuser() {
    username=$1
    password=$2
    groupname=$3

    # Creo el usuario con su contraseña
    sudo useradd -m -p $(echo $password | mkpasswd -s) $username
    

    #lo añado al grupo que le corresponde
    addgroup -g "$groupname" "$username"
}

# Set user access times
setuseraccess() {
    groupname=$1
    timespec=$2

    # obtengo los usuarios que tengo que setear
    users=$(groups "$groupname" | awk '{print $1}')

    for user in $users; do
        # seteo los horqarios de cada usuario
        usermod -T "$timespec" "$user"
        echo "Access time set for user '$user'."
    done
}

#llamo a la c¿funcion para crear los grupos
CrearGrupo Contaduría
CrearGrupo Jurídica
CrearGrupo Soporte
CrearGrupo Instalador

# Creo los usuarios de contaduria
newuser CONTADURIA01 CONTA01 Contaduría
newuser CONTADURIA02 CONTA02 Contaduría
newuser CONTADURIA03 CONTA03 Contaduría
newuser CONTADURIA04 CONTA04 Contaduría
newuser CONTADURIA05 CONTA05 Contaduría
setuseraccess Contaduría "L-S,08:00-17:00" #seteo sus horarios

#creo los usuarios de Juridica
newuser JURIDICA01 JURI01 Jurídica
newuser JURIDICA02 JURI02 Jurídica
newuser JURIDICA03 JURI03 Jurídica
setuseraccess Jurídica "L-S,08:00-17:00" #Seteo sus horarios

#creo los usuarios de Soporte
newuser SOPORTE01 SOPOR01 Soporte
newuser SOPORTE02 SOPOR02 Soporte
newuser SOPORTE03 SOPOR03 Soporte
setuseraccess Soporte "L-S,07:00-21:00"

# Creo los usuarios de INstalador que no llevan ninguna restringcion
newuser INSTALADOR01 INSTALA01 Instalador
newuser INSTALADOR02 INSTALA02 Instalador

# Creo la carpeta 
mkdir -p /compartida
chmod 777 /compartida

#la comparto con todos
smbpasswd -a -U root -N everyone /shared

#abre el archivo copia
Copia -e

# se especifica que al iniciar se debe ejecutar ese archivo
echo "@reboot root ./Copia.sh"

#sale
exit
