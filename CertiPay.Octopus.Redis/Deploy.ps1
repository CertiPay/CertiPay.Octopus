###
### These variables should be set in the Octopus Depoy UI
###

if (!$RedisServer) { $RedisServer = 'localhost:6379' }
if (!$RedisDatabaseId) { $RedisDatabaseId = 0 }
# if (!$RedisPassword) { $RedisPassword = '' }

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

Add-Type -Path "$ScriptPath\StackExchange.Redis.dll"

$ConnectionMultiplexer = [StackExchange.Redis.ConnectionMultiplexer]::Connect($RedisServer + ",allowAdmin=true", $null)

$Server = $ConnectionMultiplexer.GetServer($RedisServer, [object]$null)

$Server.FlushDatabase($RedisDatabaseId, [StackExchange.Redis.CommandFlags]::None)