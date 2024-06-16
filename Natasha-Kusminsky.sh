#!/bin/bash

#crea los grupos
CrearGrupo() {
    group=$1

    groupadd $group
}

# CCrea los usuarios
newuser() {
    username=$1
    password=$2
    groupname=$3

    # Creo el usuario con su contraseña
    sudo useradd -m -p $(echo $password | mkpasswd -s) $username
    

    #lo añado al grupo que le corresponde
    sudo usermod -aG "$groupname" "$username"
}

# Set user access times
setuseraccess() {
    groupname=$1
    timespec=$2

    users= getent group $groupname | cut -d: -f4

    for $user in $users
        # pone la condicion en el archivo de configuracion
        echo "login;*;$user;$timespec" | sudo tee -a /etc/security/time.conf > /dev/null

        # pone como parametro el horario cuando se van a logear
        if ! grep -q "pam_time.so" /etc/pam.d/login; then
            echo "account required pam_time.so" | sudo tee -a /etc/pam.d/login > /dev/null
        fi
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
setuseraccess Contaduría "Al0800-1700" #seteo sus horarios

#creo los usuarios de Juridica
newuser JURIDICA01 JURI01 Jurídica
newuser JURIDICA02 JURI02 Jurídica
newuser JURIDICA03 JURI03 Jurídica
setuseraccess Jurídica "Al0800-1700" #Seteo sus horarios

#creo los usuarios de Soporte
newuser SOPORTE01 SOPOR01 Soporte
newuser SOPORTE02 SOPOR02 Soporte
newuser SOPORTE03 SOPOR03 Soporte
setuseraccess Soporte "Al0700-2100"

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
