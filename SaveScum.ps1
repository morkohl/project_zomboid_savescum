if (-not $HOME) { $HOME = [Environment]::GetFolderPath("UserProfile") }
$SavesRoot   = Join-Path $HOME "Zomboid\Saves"
$BackupsRoot = Join-Path $SavesRoot "Backups"
$Timestamp   = (Get-Date).ToString("dd-MM-yyyy_HH-mm")

# ─────────── helpers ───────────

function Exit-Goodbye($msg) {  
    Write-Host "`n🧟  good luck out there, survivor..."
    Read-Host
    exit 
}

function Format-Time($date) {
    if (-not $date) { return "none" }
    $now = Get-Date
    $d = $now - [datetime]$date
    if     ($d.TotalMinutes -lt 1) { "just now" }
    elseif ($d.TotalHours   -lt 1) { "{0} min ago" -f [int]$d.TotalMinutes }
    elseif ($d.TotalHours   -lt 24){ "today $($date.ToString('HH:mm'))" }
    elseif ($d.TotalDays    -lt 2) { "yesterday $($date.ToString('HH:mm'))" }
    elseif ($d.TotalDays    -lt 7) { "{0} days ago" -f [int]$d.TotalDays }
    else                             { $date.ToString("dd-MM-yyyy HH:mm") }
}

function Banner($action="") {
    Clear-Host
    Write-Host ""
    Write-Host "  ██████  ▄▄▄       ██▒   █▓▓█████      ██████  ▄████▄   █    ██  ███▄ ▄███▓"
    Write-Host "▒██    ▒ ▒████▄    ▓██░   █▒▓█   ▀    ▒██    ▒ ▒██▀ ▀█   ██  ▓██▒▓██▒▀█▀ ██▒"
    Write-Host "░ ▓██▄   ▒██  ▀█▄   ▓██  █▒░▒███      ░ ▓██▄   ▒▓█    ▄ ▓██  ▒██░▓██    ▓██░"
    Write-Host "  ▒   ██▒░██▄▄▄▄██   ▒██ █░░▒▓█  ▄      ▒   ██▒▒▓▓▄ ▄██▒▓▓█  ░██░▒██    ▒██ "
    Write-Host "▒██████▒▒ ▓█   ▓██▒   ▒▀█░  ░▒████▒   ▒██████▒▒▒ ▓███▀ ░▒▒█████▓ ▒██▒   ░██▒"
    if ($action) { Write-Host "`n🧭  action : $action`n" }
}

function Confirm-Proceed($prompt) {
    while ($true) {
        $r = Read-Host "$prompt (y = yes, n = no, b = back, q = quit)"
        switch ($r.ToLower()) {
            "y" { return "YES" }
            "n" { return "NO"  }
            "b" { return "BACK"}
            "q" { Exit-Goodbye }
            default { Write-Host "❌  invalid value." }
        }
    }
}

function Show-Menu($title, $options, [switch]$AllowBack) {
    Write-Host ""
    Write-Host "📋  $title"
    Write-Host ""
    for ($i=0; $i -lt $options.Count; $i++) {
        $o = $options[$i]
        Write-Host ("[{0}] {1}" -f $i, $o.Label)
        if ($o.Detail) { Write-Host ("     {0}" -f $o.Detail) }
        if ($o.Extra)  { Write-Host ("     {0}" -f $o.Extra)  }
        Write-Host ""
    }
    if ($AllowBack) { Write-Host "[b] back to main menu" }
    Write-Host "[q] quit"
    Write-Host ""

    while ($true) {
        $sel = Read-Host "👉  select an option"
        if ($AllowBack -and $sel.ToLower() -eq "b") { return "BACK" }
        if ($sel.ToLower() -eq "q") { Exit-Goodbye }
        if ($sel -match '^\d+$' -and [int]$sel -lt $options.Count) {
            return [int]$sel
        }
        Write-Host "❌  invalid value."
    }
}

# ─────────── normalize paths ───────────

function Normalize-SavePath($p) {
    $full = [IO.Path]::GetFullPath($p)
    $name = Split-Path $full -Leaf
    $mode = Split-Path (Split-Path $full -Parent) -Leaf
    [pscustomobject]@{ Mode=$mode; Name=$name; Path=$full }
}

function Normalize-BackupPath($p) {
    $full = [IO.Path]::GetFullPath($p)
    $leaf = Split-Path $full -Leaf
    $mode = Split-Path (Split-Path $full -Parent) -Leaf
    $orig = $leaf
    if ($leaf -match '^(?<nm>.+?)_backup(?:_.+)?$') { $orig = $Matches['nm'] }
    [pscustomobject]@{ Mode=$mode; Leaf=$leaf; Original=$orig; Path=$full }
}

# ─────────── scanning ───────────

function Get-ValidDirs($root) {
    if (-not (Test-Path $root)) { return @() }
    Get-ChildItem $root -Directory
}

function Get-Saves {
    $out=@()
    foreach ($modeDir in (Get-ValidDirs $SavesRoot)) {
        if ($modeDir.Name -eq "Backups") { continue }
        foreach ($saveDir in (Get-ChildItem $modeDir.FullName -Directory)) {
            $n = Normalize-SavePath $saveDir.FullName
            $bmode = Join-Path $BackupsRoot $n.Mode
            $latest = $null
            if (Test-Path $bmode) {
                $pattern = "$($n.Name)_backup_*"
                $cand = Get-ChildItem $bmode -Directory -Filter $pattern | Sort-Object LastWriteTime -Descending | Select-Object -First 1
                if ($cand) { $latest = $cand.LastWriteTime }
            }
            $out += [pscustomobject]@{
                Mode=$n.Mode; Name=$n.Name; Path=$n.Path
                LastModified=(Get-Item $n.Path).LastWriteTime
                LatestBackup=$latest
            }
        }
    }
    $out
}

function Get-Backups {
    if (-not (Test-Path $BackupsRoot)) { return @() }
    $out=@()
    foreach ($modeDir in (Get-ValidDirs $BackupsRoot)) {
        foreach ($leafDir in (Get-ChildItem $modeDir.FullName -Directory)) {
            $n = Normalize-BackupPath $leafDir.FullName
            $out += [pscustomobject]@{
                Mode=$n.Mode; Name=$n.Original; Leaf=$n.Leaf; Path=$n.Path
                BackupTime=(Get-Item $n.Path).LastWriteTime
            }
        }
    }
    $out
}

# ─────────── core ops ───────────

function Do-Backup($saveObj) {
    $n = Normalize-SavePath $saveObj.Path
    $src  = $n.Path
    $destDir = Join-Path (Join-Path $BackupsRoot $n.Mode) ("{0}_backup_{1}" -f $n.Name,$Timestamp)

    Banner "backup"
    Write-Host "🎮  game mode : $($n.Mode)"
    Write-Host "💾  save name : $($n.Name)"
    Write-Host 
    Write-Host "📂  source      : $src"
    Write-Host "📦  destination : $destDir"
    Write-Host 
    Write-Host "💾  backing up..."

    if (-not (Test-Path (Split-Path $destDir -Parent))) { New-Item -ItemType Directory -Path (Split-Path $destDir -Parent) | Out-Null }
    Copy-Item $src $destDir -Recurse -Force

    Write-Host
    Write-Host "✅  backup complete!"
    Exit-Goodbye
}

function Do-Restore($backupObj) {
    $n = Normalize-BackupPath $backupObj.Path
    $src    = $n.Path
    $dest   = Join-Path (Join-Path $SavesRoot $n.Mode) ("{0}_restored" -f $n.Original)
    $created = (Get-Item $src).LastWriteTime

    Banner "restore"
    Write-Host "🎮  game mode : $($n.Mode)"
    Write-Host "💾  save name : $($n.Original)"
    Write-Host 
    Write-Host "📅  backup created: $(Format-Time $created)"
    Write-Host "🕒  backup time   : $($created.ToString('dd-MM-yyyy HH:mm'))"
    Write-Host 
    Write-Host "📁  source      : $src"
    Write-Host "📦  destination : $dest"
    Write-Host 

    $confirm = Confirm-Proceed "proceed with restore"
    if ($confirm -eq "BACK" -or $confirm -eq "NO") { return "MAIN" }

    Write-Host
    Write-Host "💾  restoring..."
    if (-not (Test-Path (Split-Path $dest -Parent))) { New-Item -ItemType Directory -Path (Split-Path $dest -Parent) | Out-Null }
    Copy-Item $src $dest -Recurse -Force

    Write-Host
    Write-Host "✅  restore complete!"
    Exit-Goodbye
}

# ─────────── flows ───────────

function Flow-BackupSave {
    Banner "backup a save"
    $saves = Get-Saves
    if (-not $saves -or $saves.Count -eq 0) {
        Write-Host "😢  no saves found." 
        Exit-Goodbye
    }

    $groups = $saves | Group-Object Mode
    $modeOptions = @()
    foreach ($g in $groups) {
        $latest = ($g.Group | Sort-Object LastModified -Descending | Select-Object -First 1).LastModified
        $modeOptions += [pscustomobject]@{
            Label  = "🎮 $($g.Name)"
            Detail = "⏰ last activity: $(Format-Time $latest)"
        }
    }

    $modeIdx = Show-Menu "available game modes" $modeOptions -AllowBack
    if ($modeIdx -eq "BACK") { return "MAIN" }
    $modeSubset = $groups[$modeIdx].Group

    $saveOptions = @()
    foreach ($s in $modeSubset) {
        $lb = if ($s.LatestBackup) { Format-Time $s.LatestBackup } else { "none" }
        $saveOptions += [pscustomobject]@{
            Label  = "🧠 $($s.Name)"
            Detail = "⏰ modified: $(Format-Time $s.LastModified)"
            Extra  = "💾 last backup: $lb"
        }
    }

    $saveIdx = Show-Menu "select a save to back up" $saveOptions -AllowBack
    if ($saveIdx -eq "BACK") { return "MAIN" }
    Do-Backup $modeSubset[$saveIdx]
}

function Flow-Restore {
    Banner "restore a backup"
    $backs = Get-Backups
    if (-not $backs -or $backs.Count -eq 0) { 
        Write-Host "😢  no backups found." 
        Exit-Goodbye
    }

    $groups = $backs | Group-Object Mode
    $modeOptions = @()
    foreach ($g in $groups) {
        $latest = ($g.Group | Sort-Object BackupTime -Descending | Select-Object -First 1).BackupTime
        $modeOptions += [pscustomobject]@{
            Label  = "🎮 $($g.Name)"
            Detail = "⏰ latest backup: $(Format-Time $latest)"
        }
    }

    $modeIdx = Show-Menu "available game modes (backups)" $modeOptions -AllowBack
    if ($modeIdx -eq "BACK") { return "MAIN" }
    $modeSubset = $groups[$modeIdx].Group | Sort-Object BackupTime -Descending

    $bkOptions = @()
    foreach ($b in $modeSubset) {
        $bkOptions += [pscustomobject]@{
            Label  = "💀 $($b.Name)"
            Detail = "📅 backup created: $(Format-Time $b.BackupTime)"
            Extra  = "🕒 backup time   : $($b.BackupTime.ToString('dd-MM-yyyy HH:mm'))"
        }
    }

    $bkIdx = Show-Menu "select a backup to restore" $bkOptions -AllowBack
    if ($bkIdx -eq "BACK") { return "MAIN" }
    Do-Restore $modeSubset[$bkIdx]
}

function Flow-BackupLatest {
    Banner "backup latest save"
    $saves = Get-Saves
    if (-not $saves -or $saves.Count -eq 0) {
        Write-Host "😢  no saves found." 
        Exit-Goodbye
    }

    $latest = $saves | Sort-Object LastModified -Descending | Select-Object -First 1
    $lb = if ($latest.LatestBackup) { Format-Time $latest.LatestBackup } else { "none" }

    Write-Host "🎮  game mode : $($latest.Mode)"
    Write-Host "💾  save name : $($latest.Name)"
    Write-Host
    Write-Host ("⏰  modified    : {0}" -f (Format-Time $latest.LastModified))
    Write-Host ("💾  last backup : {0}" -f $lb)
    Write-Host

    $confirm = Confirm-Proceed "proceed with backup"
    if ($confirm -eq "BACK" -or $confirm -eq "NO") { return "MAIN" }

    Do-Backup $latest
}

# ─────────── main loop ───────────

while ($true) {
    Banner "main menu"
    $main = @(
        [pscustomobject]@{ Label="🚀 backup latest save"; Detail="duplicate your most recently modified save" },
        [pscustomobject]@{ Label="🧠 backup a save";      Detail="choose a save and duplicate it into backups" },
        [pscustomobject]@{ Label="💀 restore a backup";   Detail="copy a backup back to saves as *_restored" }
    )
    $pick = Show-Menu "available actions" $main
    switch ($pick) {
        0 { Flow-BackupLatest | Out-Null }
        1 { Flow-BackupSave   | Out-Null }
        2 { Flow-Restore      | Out-Null }
        default { Exit-Goodbye }
    }
}
