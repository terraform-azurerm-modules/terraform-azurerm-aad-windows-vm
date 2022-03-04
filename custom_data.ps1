# New-Item -Path "C:\Azure" -ItemType "directory" -Force
Set-Location -Path "C:\Azure"
Start-Transcript -Path "C:\Azure\CustomData.log"

Write-Host "=========================================================="

Write-Host "Installing Azure CLI at $(Get-Date -UFormat '%H:%M:%S')"
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'
Write-Host "Install complete at $(Get-Date -UFormat '%H:%M:%S')"

Write-Host "=========================================================="

Write-Host "Extending path at $(Get-Date -UFormat '%H:%M:%S')"
$AzureCliPath = 'C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin'
if (Test-Path -Path $AzureCliPath) {
    $Paths = $env:PATH -split ';'
    if ($Paths.Contains($AzureCliPath)) {
        Write-Host ("Path {0} is already in the PATH environment variable." -f $AzureCliPath)
    } else {
        $RegistryKey = 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment'
        $Path = (Get-ItemProperty -Path $RegistryKey -Name PATH).path
        Set-ItemProperty -Path $RegistryKey -Name PATH -Value "$Path;$AzureCliPath"
        Write-Host ("Added path {0} to the PATH environment variable." -f $AzureCliPath)
    }
}
else {
    Write-Host ("ERROR: Path {0} not found." -f $AzureCliPath)
    Exit 1
}
Write-Host "Path section completed at $(Get-Date -UFormat '%H:%M:%S')"

Write-Host "=========================================================="

Write-Host "Installing PowerShell 7.2.1 at $(Get-Date -UFormat '%H:%M:%S')"
$PowerShellMsiUri = 'https://github.com/PowerShell/PowerShell/releases/download/v7.2.1/PowerShell-7.2.1-win-x64.msi'
Invoke-WebRequest -Uri $PowerShellMsiUri -OutFile .\PowerShell-7.2.1-win-x64.msi
Start-Process msiexec.exe -Wait -ArgumentList '/package PowerShell-7.2.1-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1 USE_MU=1 ENABLE_MU=1'
Write-Host "PowerShell 7.2.1 install complete at $(Get-Date -UFormat '%H:%M:%S')"

Write-Host "=========================================================="

Write-Host "Installing Azure Az PowerShell Module at $(Get-Date -UFormat '%H:%M:%S')"

C:\Program` Files\PowerShell\7\pwsh.exe -Command {
$PSVersionTable.PSVersion
}

C:\Program` Files\PowerShell\7\pwsh.exe -Command {
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Localmachine
Install-Module -Name Az -Scope AllUsers -Repository PSGallery -Force -Verbose
}

C:\Program` Files\PowerShell\7\pwsh.exe -Command {
Import-Module Az -Verbose
Get-Module PackageManagement,PowerShellGet,Az
}

Write-Host "Install and import complete at $(Get-Date -UFormat '%H:%M:%S')"

Write-Host "=========================================================="

Stop-Transcript