function NewUser {
    param (
        [String] $Name
        [String] $Password
        [String] $Group
    )
    New-LocalUser -Username $Name -Password (ConvertTo-SecureString $Password -AsPlainText -Force)#creo el usuario
    Add-LocalGroupMember -Group $Group -Members $Name #lo añado a su grupo correspondiente 

}
function Access {
    param (
        [String] $Group
        [String] $Time
    )
    $Users = Get-LocalGroupMember -Group $Group | Select-Object -ExpandProperty Name #extraigo todos los usuarios de el grupo
    foreach ($User in $Users) {#recorro esa lista
        $PCName, $Name = $User.split("\") #me quedo solo con el nombre de el usuario
        net user $Name /times:$Time 2> $null #establezco la temporalizacion
    }
    
}
#creo los grupos a los que añadire a los usuarios
New-ADGroup -Name "Contaduria"
New-ADGroup -Name "Juridica"
New-ADGroup -Name "Soporte"
New-ADGroup -Name "instalador"

#creo los usuarios de contaduria
UserName -Name "CONTADURIA01" -Password "CONTA01" -Group "Contaduria"
UserName -Name "CONTADURIA02" -Password "CONTA02" -Group "Contaduria"
UserName -Name "CONTADURIA03" -Password "CONTA03" -Group "Contaduria"
UserName -Name "CONTADURIA04" -Password "CONTA04" -Group "Contaduria"
UserName -Name "CONTADURIA05" -Password "CONTA05" -Group "Contaduria"
Access -Group "Contaduria" -Time "L-s,08:00-17:00" #limito su acceso 
#Creo los usuarios de Juridica
UserName -Name "JURIDICA01" -Password "JURI01" -Group "Juridica"
UserName -Name "JURIDICA02" -Password "JURI02" -Group "Juridica"
UserName -Name "JURIDICA03" -Password "JURI03" -Group "Juridica"
Access -Group "Juridica" -Time "L-s,08:00-17:00"#limito su acceso 
#creo los usuarios de soporte
UserName -Name "SOPORTE01" -Password "SOPOR01" -Group "Soporte"
UserName -Name "SOPORTE02" -Password "SOPOR02" -Group "Soporte"
UserName -Name "SOPORTE03" -Password "SOPOR03" -Group "Soporte"
Access -Group "Soporte" -Time "L-s,07:00-21:00"#limito su acceso 
#creo los usuarios de instalador
UserName -Name "INSTALADOR01" -Password "INSTALA01" -Group "Instalador"
UserName -Name "INSTALADOR02" -Password "INSTALA02" -Group "Instalador" #No tienen limitaciones

#2)
#creo la carpeta en la raiz
New-Item -ItemType Directory -Path "C:\compartida"
#la guardo en una variable
$carpetaCompartida = Get-ChildItem -Path "C:\compartida"
#la comparto con todos y les doy acceso a todos
New-SmbShare -Name "compartida" -Path $carpetaCompartida.FullName -AccessPerms Everyone -FullAccess
#3)
#al encender la computadora se ejecuta el archivo copia que esta en esta carpeta
Register-ScheduledJob -Name "AlEncender" -ScriptFile ".\Copia.ps1" -Trigger {
    LogonTrigger -TriggerType StartUp
} -Action {
    Start-Process -FilePath ".\Copia.ps1"
}






