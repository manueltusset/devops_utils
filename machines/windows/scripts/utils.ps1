$ErrorActionPreference = 'Stop';

Function Download-File([string] $Url, [string] $Path) {
    Write-Host $(Get-Date) "Iniciando Download $url" -ForegroundColor Yellow
    
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest "$Url" -OutFile "$Path"

    Write-Host $(Get-Date) "Download Finalizado" -ForegroundColor Yellow
}

Function Extract-File([string] $ZipPath, [string] $Dest, [string] $Pass = "", [boolean] $RemoveFile = $true) {
    Write-Host $(Get-Date) "Extraindo arquivo $ZipPath para o destino $Dest ------ "

    $path7z = "'C:\Program Files\7-Zip\7z.exe'"

    if (-not ([string]::IsNullOrEmpty($Pass)))
    {
        $Pass = "-p'$Pass'"
    }

    powershell -Command "& $path7z x '$ZipPath' -o'$Dest' $Pass -y"

    if ($true -eq $RemoveFile)
    {
        Remove-Item "$ZipPath" -Force
    }
}

Function Install-MSI([string] $File, [boolean] $RemoveFile = $true, [string] $ArgumentList) {
    Write-Host $(Get-Date) "Instalando $File ------ "
    
    Start-Process "msiexec.exe" -ArgumentList "/i $File /L*v $File.log $ArgumentList /quiet" -Wait
    
    if ($true -eq $RemoveFile)
    {
        Remove-Item "$File" -Force
    }
}

Function Install-EXE([string] $File, [string] $ArgumentList, [boolean] $RemoveFile = $true) {
    Write-Host $(Get-Date) "Instalando $File ------ "

    Start-Process "$File" -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1 $ArgumentList" -Wait

    if ($true -eq $RemoveFile)
    {
        Remove-Item "$File" -Force
    }
}

Function Install-VCredist([string] $File, [boolean] $RemoveFile = $true) {
    Write-Host $(Get-Date) "Instalando VCredist $File ------ "

    Start-Process "$File" -ArgumentList "/qb /passive /norestart" -Wait
    
    if ($true -eq $RemoveFile)
    {
        Remove-Item "$File" -Force
    }
}

Function Replace-Content-File([string] $File, [string] $OldValue, [string] $NewValue) {
    ((Get-Content -path "$File" -Raw) -replace "$OldValue","$NewValue") | Set-Content -Path "$File"
}

Function Log([string] $Message = "") {
    Write-Host " "
    Write-Host "------------------------------------------------------------------------------"
    Write-Host $(Get-Date) "$Message"
    Write-Host "------------------------------------------------------------------------------"
}

Function Get-Value-Settings([string] $File, [string] $Key) {
    return ((Get-Content "$File") | Select-String "$Key").ToString().Replace("$Key=","");
}