Param (
    [Parameter(Position=1)]
    [ValidateSet("up","ssh","destroy")]
    [string]$Action = "up"
)

$CurrentPath = $(Get-Location).Path

Function UP {
    #$VM_Name = Read-Host "Enter the name of your virtual machine"
    $Type_OS = $(Get-TypeOS)
    $Box = $(Get-Box -Type_OS $Type_OS)

    if ($Type_OS -eq 'windows') {
      $CleanVM = Read-Host "Do you want to provision a clean virtual machine? (y/n)"
    }

    $Env:VM_Name = $Box
    $Env:VM_Box = $Box
    $Env:VM_Clean = $CleanVM
    Set-Location -Path "$CurrentPath\$Type_OS"
    
    powershell -Command "vagrant up --provider $Provider"
    
    Set-Location -Path "$CurrentPath"
}

Function Destroy {
    $VM_Name = $(Get-SelectedVM)
    $Type_OS = $(Get-TypeOS -VM_Name $VM_Name)
    #$Box = $(Get-Box -Type_OS $Type_OS)
    
    $Env:VM_Name = $VM_Name
    $Env:VM_Box = $VM_Name

    Set-Location -Path "$CurrentPath\$Type_OS"

    vagrant destroy -f

    Set-Location -Path "$CurrentPath"
}

Function SSH {
    $VM_Name = $(Get-SelectedVM)
    $Type_OS = $(Get-TypeOS -VM_Name $VM_Name)
    #$Box = $(Get-Box -Type_OS $Type_OS)
    
    $Env:VM_Name = $VM_Name
    $Env:VM_Box = $VM_Name

    Set-Location -Path "$CurrentPath\$Type_OS"

    vagrant ssh

    Set-Location -Path "$CurrentPath"
}

Function Get-SelectedVM {
    $ListMachines = @{}
    Switch($Provider){
        { $_ -eq '1' -or $_ -eq 'virtualbox' } {
            $List = $(& 'C:\Program Files\Oracle\VirtualBox\VBoxManage.exe' list vms)
            $Count = 0;
            foreach($vb in $List) {

                [int]$indexOf = $($vb.IndexOf('"') + 1)
                [int]$lastIndexOf = $($vb.LastIndexOf('"') - 1)
                [string]$nameOK = $vb.Substring($indexOf, $lastIndexOf)
                
                [void]$ListMachines.Add($Count, $nameOK);
                $Count++;
            }
        }
        { $_ -eq '2' -or $_ -eq 'hyperv' } {
            $List = $(Get-VM).Name
            $Count = 0;
            foreach($hv in $List) {
                [void]$ListMachines.Add($Count, $hv);
                $Count++;
            }
        }
    }

    Write-Host " "
    Write-Host "Machines available: ---------- "
    $ListMachines.Keys | ForEach-Object {
        $message = " {0} - {1}" -f $_, $ListMachines[$_]
        Write-Host $message
    }
    Write-Host "----------------------------------------- "

    [int]$IndexVM  = Read-Host "Enter the virtual machine number"
    $SelectedVM = $ListMachines[$IndexVM];

    Write-Host "Selected Virtual Machine: $SelectedVM" -ForegroundColor Green

    return $SelectedVM;
}

Function Get-TypeOS([string]$VM_Name = "") {
    
    Write-Host "==================================="
    Write-Host "$VM_Name"
    Write-Host "==================================="

    if ($VM_Name -like "*windows*") {
        $Type_OS = 'windows'
    } elseif ($VM_Name -like "*generic*") {
        $Type_OS = 'linux'
    } else {
        $Type_OS = Read-Host "What type of operating system do you want to provision? (1-linux, 2-windows)"

        Switch($Type_OS) {
            { $_ -eq '1' -or $_ -eq 'linux'} {
                $Type_OS = 'linux'
            }
            { $_ -eq '2' -or $_ -eq 'windows'} {
                $Type_OS = 'windows'
            }
        }
    }
    
    Write-Host "Selected Type OS: $Type_OS" -ForegroundColor Green
    return $Type_OS;
}

Function Get-Box([string]$Type_OS) {
    $ListBoxLinux = @{
        1 = "generic/centos7"; 
        2 = "generic/debian8"; 
        3 = "generic/rhel7";
        4 = "generic/rhel8";
        5 = "generic/ubuntu1804";
        6 = "generic/ubuntu2004";
    }

    $ListBoxWindows= @{
        1 = "windows_2016";
        2 = "windows_2019";
    }

    Write-Host " "
    Write-Host "Available Boxes ---------------- "
    Switch($Type_OS) {
        "windows" {
            $ListBoxWindows.Keys | ForEach-Object {
                $message = " {0} - {1}" -f $_, $ListBoxWindows[$_]
                Write-Host $message
            }
            $List = $ListBoxWindows.Clone();
        }
        "linux" {
           $ListBoxLinux.Keys | ForEach-Object {
                $message = " {0} - {1}" -f $_, $ListBoxLinux[$_]
                Write-Host $message
           }
           $List = $ListBoxLinux.Clone();
        }
    }
    Write-Host "-------------------------------- "
    Write-Host " "

    [int]$Box = Read-Host "Enter the box number"
    $SelectedBox = $($List[$Box])

    Write-Host "Selected box: $SelectedBox" -ForegroundColor Green

    return $SelectedBox;
}

Function Get-Provider {
    $Provider = Read-Host "Enter your provider (1-virtualbox, 2-hyperv)"

    Switch($Provider) {
        {$_ -eq "1" -or $_ -eq "virtualbox"} {
            $Provider = "virtualbox"
        }
        {$_ -eq "2" -or $_ -eq "hyperv"} {
            $Provider = "hyperv"
        }
    }
    Write-Host "Selected Provider: $Provider" -ForegroundColor Green
    return $Provider
}

$Provider = $(Get-Provider)

Switch($Action) {
    { $_ -eq 'up'} {
        UP
    }
    { $_ -eq 'ssh'} {
        SSH
    }
    { $_ -eq 'destroy'} {
        Destroy
    }
}