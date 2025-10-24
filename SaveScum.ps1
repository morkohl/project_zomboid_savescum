$SavesRoot = "$Home\Zomboid\Saves"
$BackupsRoot = Join-Path $SavesRoot "Backups"
$Timestamp = (Get-Date).ToString("dd-MM-yyyy_HH-mm")

$dirs = Get-ChildItem $SavesRoot -Directory | Where-Object { $_.Name -ne "Backups" } |
    ForEach-Object { Get-ChildItem $_.FullName -Directory }

Write-Host "=== Welcome to Zomboid Backup Util ==="
Write-Host 

for ($i = 0; $i -lt $dirs.Count; $i++) {
    $rel = $dirs[$i].FullName.Substring($SavesRoot.Length).TrimStart('\')
    Write-Host "[$i] $rel"
}

$sel = Read-Host "Please select the save you want to backup"

$Source = $dirs[$sel].FullName
$rel = $dirs[$sel].FullName.Substring($SavesRoot.Length).TrimStart('\')
$Destination = Join-Path $BackupsRoot ($rel + "_$Timestamp")

Write-Host
Write-Host "<- Source: $Source"
Write-Host "-> Destination: $Destination"
Write-Host 

Write-Host "Starting Backup"

Copy-Item $Source $Destination -Recurse -Force

Write-Host 
Write-Host "Backup Complete"
Write-Host 

Read-Host "Press Enter to exit"
