Set-Location C:\Users\vagrant\Downloads
$CurrentPath = $(Get-Location).Path;

Function Install-Chocolatey {
  Log "Instalando Chocolatey"

  Set-ExecutionPolicy Bypass -Scope Process -Force;
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
  iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));
}

Function Set-PTBRKeyboard {
  Log "Setando teclado para layout pt-BR"

  powershell Set-WinUserLanguageList -LanguageList pt-BR -Force
}

Function Install-Chrome {
  Log "Instalando Google Chrome"

  powershell -Command 'choco install googlechrome -y'
}

Install-Chocolatey
Set-PTBRKeyboard
Install-Chrome