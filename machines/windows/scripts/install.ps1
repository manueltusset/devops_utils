Param (
  [string]$Tag,
  [string]$Branch
)
Import-Module .\utils.ps1;

Write-Host "=====> Tag: $Tag <=====" -ForegroundColor Yellow
Write-Host "=====> Branch: $Branch <=====" -ForegroundColor Yellow

Set-Location C:\Users\vagrant\Downloads
$CurrentPath = $(Get-Location).Path;

Function Install-IIS {
  Log "Instalando IIS"
  Install-WindowsFeature Web-WebServer, Web-Default-Doc, Web-Dir-Browsing, Web-Http-Errors, Web-Static-Content, Web-Http-Redirect, Web-Http-Logging, Web-Custom-Logging, Web-Stat-Compression, Web-Dyn-Compression, Web-Filtering, Web-Basic-Auth, Web-CGI, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Mgmt-Tools, Web-Mgmt-Service, Web-Scripting-Tools, Web-Http-Tracing -Verbose
}

Function Install-IISAdministration {
  Log "Instalando IISAdministration"

  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  Install-PackageProvider -Name NuGet -Force
  Install-Module IISAdministration -Confirm:$false -Force
}

Function Install-7zip {
  Log "Instalando 7zip"
  
  Download-File -Url "https://www.7-zip.org/a/7z1900-x64.msi" -Path "$CurrentPath\7zip.msi"
  Install-MSI -File "$CurrentPath\7zip.msi"
}

Function Install-Java {
  Log "Instalando OpenJDK"
  
  Download-File -Url "https://builds.openlogic.com/downloadJDK/openlogic-openjdk/8u262-b10/openlogic-openjdk-8u262-b10-windows-x64.msi" -Path "$CurrentPath\openjdk-8u262-b10-windows-x64.msi"
  Install-MSI -File "$CurrentPath\openjdk-8u262-b10-windows-x64.msi"
  [Environment]::SetEnvironmentVariable("JAVA_HOME", "$Env:ProgramFiles\OpenJDK\jdk-8.0.262.10-hotspot\jre", "Machine")
}

Function Install-Tomcat {
  Log "Instalando Tomcat"

  Download-File -Url "https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.109/bin/apache-tomcat-7.0.109-windows-x64.zip" -Path "$CurrentPath\apache-tomcat-7.0.109.zip"
  Extract-File -ZipPath "$CurrentPath\apache-tomcat-7.0.109.zip" -Dest "$Env:ProgramFiles\Apache Software Foundation\"
  Rename-Item -Path "$Env:ProgramFiles\Apache Software Foundation\apache-tomcat-7.0.109" -NewName "$Env:ProgramFiles\Apache Software Foundation\Tomcat 7.0" -Force

  Log "Configurando Tomcat"

  $configTomcat = "& '$Env:ProgramFiles\Apache Software Foundation\Tomcat 7.0\bin\tomcat7.exe' //IS/Tomcat7" + 
      " --DisplayName='Apache Tomcat 7'" +
      " --Description='Apache Tomcat 7.0.108 Server'" + 
      " --Startup=manual" + 
      " --StartMode=jvm" + 
      " --StopMode=jvm" + 
      " --StartClass=org.apache.catalina.startup.Bootstrap" +
      " --StartParams=start" + 
      " --StopClass=org.apache.catalina.startup.Bootstrap" + 
      " --StopParams=stop" +
      " --JvmMs=1024" +
      " --JvmMx=2048" +
      " --StartPath='$Env:ProgramFiles\Apache Software Foundation\Tomcat 7.0\bin\tomcat7.exe'" +
      " --LogPath='$Env:ProgramFiles\Apache Software Foundation\Tomcat 7.0\logs'" + 
      " --LogPrefix='commons-daemon'" + 
      " --LogLevel=info" +
      " --Jvm='$Env:ProgramFiles\OpenJDK\jdk-8.0.262.10-hotspot\jre\bin\server\jvm.dll'" +
      " --Classpath='$Env:ProgramFiles\Apache Software Foundation\Tomcat 7.0\bin\bootstrap.jar;$Env:ProgramFiles\Apache Software Foundation\Tomcat 7.0\bin\tomcat-juli.jar'" +
      " --JvmOptions='-Dcatalina.home=$Env:ProgramFiles\Apache Software Foundation\Tomcat 7.0;-Dcatalina.base=$Env:ProgramFiles\Apache Software Foundation\Tomcat 7.0;-Djava.io.tmpdir=$Env:ProgramFiles\Apache Software Foundation\Tomcat 7.0\temp;-Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager;-Djava.util.logging.config.file=$Env:ProgramFiles\Apache Software Foundation\Tomcat 7.0\conf\logging.properties;-Duser.language=en;-Duser.country=US'" +
      " --JvmOptions9='--add-opens=java.base/java.lang=ALL-UNNAMED;--add-opens=java.base/java.io=ALL-UNNAMED;-add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED'" +
      " --JavaHome='$Env:ProgramFiles\OpenJDK\jdk-8.0.262.10-hotspot\jre'"
  powershell -Command $configTomcat
  cmd /c "sc config Tomcat7 obj=localsystem"
}

Function Download-Package {
  Log "Baixando pacotes da suite"

  Download-File -Url "http://10.132.1.38/$Tag.zip" -Dest "$CurrentPath\$Tag.zip"
}

Install-IIS
Install-IISAdministration
Install-7zip
Install-Java
Install-Tomcat
#Download-Package