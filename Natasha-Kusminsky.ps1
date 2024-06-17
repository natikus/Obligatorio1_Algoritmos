function NewUser {
    param (
        [Parameter(Mandatory = $true)]
        [String] $Name,
    
        [Parameter(Mandatory = $true)]
        [String] $Password,
    
        [Parameter(Mandatory = $true)]
        [String] $Group
    )
    
    # Crea el usuario 
    New-LocalUser -Name $Name -Password (ConvertTo-SecureString $Password -AsPlainText -Force)
    # Lo añado al grupo
    Add-LocalGroupMember -Group $Group -Member $Name
    
    Write-Host "Usuario '$Name' creado y agregado al grupo '$Group'."
}
    
function Access {
    param (
        [Parameter(Mandatory = $true)]
        [String] $Group,
        
        [Parameter(Mandatory = $true)]
        [String] $Time
    )
    #obtengo la lista de usuarios que pertenecen al grupo
    $Usuarios = Get-LocalGroupMember -Group $Group | Select-Object -ExpandProperty Name
        
    foreach ($Usuario in $Usuarios) {
        $Usuario = "$($Usuario.split('\')[1])"  # extraigo el nombre de usuario sin dominio
        #establezco el horario de uso
        net user $Usuario /times:$Time
        Write-Host "Tiempo de acceso establecido para el usuario '$Usuario'."
    }
}      
#creo los grupos a los que añadire a los usuarios
New-LocalGroup -Name "Contaduria"
New-LocalGroup -Name "Juridica"
New-LocalGroup -Name "Soporte"
New-LocalGroup -Name "instalador"

#creo los usuarios de contaduria
NewUser -Name "CONTADURIA01" -Password "CONTA01" -Group "Contaduria"
NewUser -Name "CONTADURIA02" -Password "CONTA02" -Group "Contaduria"
NewUser -Name "CONTADURIA03" -Password "CONTA03" -Group "Contaduria"
NewUser -Name "CONTADURIA04" -Password "CONTA04" -Group "Contaduria"
NewUser -Name "CONTADURIA05" -Password "CONTA05" -Group "Contaduria"
Access -Group "Contaduria" -Time "L-s,08:00-17:00" #limito su acceso 
#Creo los usuarios de Juridica
NewUser -Name "JURIDICA01" -Password "JURI01" -Group "Juridica"
NewUser -Name "JURIDICA02" -Password "JURI02" -Group "Juridica"
NewUser -Name "JURIDICA03" -Password "JURI03" -Group "Juridica"
Access -Group "Juridica" -Time "L-s,08:00-17:00"#limito su acceso 
#creo los usuarios de soporte
NewUser -Name "SOPORTE01" -Password "SOPOR01" -Group "Soporte"
NewUser -Name "SOPORTE02" -Password "SOPOR02" -Group "Soporte"
NewUser -Name "SOPORTE03" -Password "SOPOR03" -Group "Soporte"
Access -Group "Soporte" -Time "L-s,07:00-21:00"#limito su acceso 
#creo los usuarios de instalador
NewUser -Name "INSTALADOR01" -Password "INSTALA01" -Group "Instalador"
NewUser -Name "INSTALADOR02" -Password "INSTALA02" -Group "Instalador" #No tienen limitaciones

#2)
.\Copia.ps1
#creo la carpeta en la raiz
New-Item -ItemType Directory -Path "C:\compartida"
#la guardo en una variable
$carpetaCompartida = Get-Item -Path "C:\compartida"
#la comparto con todos y les doy acceso a todos
New-SmbShare -Name "compartida" -Path $carpetaCompartida.FullName -FullAccess Everyone
#3)
#al encender la computadora se ejecuta el archivo copia que esta en esta carpeta
$trigger = New-JobTrigger -AtStartup

Register-ScheduledJob -Trigger $trigger -FilePath .\Copia.ps1 -Name copia





