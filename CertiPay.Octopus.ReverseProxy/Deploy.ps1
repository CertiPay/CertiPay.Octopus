###
### These variables should be set in the Octopus Depoy UI
###

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

## Ensure Chocolatey is installed

if(-not $env:ChocolateyInstall -or -not (Test-Path "$env:ChocolateyInstall"))
{
	Write-Output "Chocolatey Not Found, Installing..."
	iex ((new-object net.webclient).DownloadString('http://chocolatey.org/install.ps1')) 
}

## Check if webpi.cmd is installed

choco install webpi.cmd

## Check if Application Request Routing 3.0 is installed via webpi

choco install ARRv3_0 -source webpi

## Tell IIS / UrlRewrite to include original host headers

& c:\Windows\system32\inetsrv\AppCmd.exe set config -section:system.webServer/proxy /preserveHostHeader:"True" /commit:apphost