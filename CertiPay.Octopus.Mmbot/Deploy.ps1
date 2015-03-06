###
### Script that runs on deploy in Octopus
###

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$ServiceName = "MMbotService"

### ----- Ensure Chocolatey and NuGet are Installed

if(-not $env:ChocolateyInstall -or -not (Test-Path "$env:ChocolateyInstall"))
{
	Write-Output "Chocolatey Not Found, Installing..."
	iex ((new-object net.webclient).DownloadString('http://chocolatey.org/install.ps1')) 
}

if(!(Test-Path "$env:ChocolateyInstall\lib\Nuget.CommandLine.*\tools\NuGet.exe"))
{
	Write-Output "NuGet Command Line Not Found, Installing..."
	choco install nuget.commandline
}

### ----- Ensure Mmbot is installed

if(!(Test-Path "$env:ChocolateyInstall\lib\mmbot.*\tools\mmbot"))
{
	Write-Output "Mmbot Not Found, Installing..."
	choco install mmbot
}

### ----- Install HipChat adapter

nuget install mmbot.hipchat -o packages

### ----- Stop/Start/Install Mmbot as Local Service

$MmbotSvc = Get-Service $ServiceName -ErrorAction SilentlyContinue

if($MmbotSvc)
{
    Write-Output "The service ($ServiceName) will be stopped and reconfigured for the new version..."

	Stop-Service $ServiceName

	sc delete $ServiceName

	Write-Output "The service ($ServiceName) has been removed..."
}

$MmbotExe = Join-Path "$env:ChocolateyInstall\lib\mmbot.*\tools\mmbot" "mmbot.exe" -Resolve

New-Service -Name $ServiceName -binaryPathName "$MmbotExe -s -d $ScriptPath"  -StartupType Automatic

Start-Service $ServiceName

Write-Output "The service ($ServiceName) has been installed and started!"

### ----- Write Happy Completion Message

Write-Output "Mmbot deployment completed!"