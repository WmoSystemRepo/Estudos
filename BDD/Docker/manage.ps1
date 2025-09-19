param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("up","down","stop","pause")]
    [string]$Action
)

# Volume exclusivo do Ruby
$volume = "bundle_cache"

# Onde os backups ficam salvos (no host)
$backupDir = Join-Path $PSScriptRoot "backups"
if (!(Test-Path $backupDir)) { New-Item -ItemType Directory -Path $backupDir | Out-Null }

function Backup-Volume {
    Write-Host "[BACKUP] Criando backup do volume $volume..."

    # Cria um tar.gz temporário do volume
    docker run --rm -v ${volume}:/data -v "${backupDir}:/backup" alpine `
        sh -c "tar czf /backup/tmp.tar.gz -C /data ."

    # Rotaciona backups: _1 é o mais recente, _2 o penúltimo
    $b1 = Join-Path $backupDir "$($volume)_1.tar.gz"
    $b2 = Join-Path $backupDir "$($volume)_2.tar.gz"

    if (Test-Path $b1) {
        if (Test-Path $b2) { Remove-Item $b2 -Force }
        Move-Item -Force $b1 $b2
    }
    Move-Item -Force (Join-Path $backupDir "tmp.tar.gz") $b1

    Write-Host "[OK] Backup atualizado: $(Split-Path $b1 -Leaf) (penúltimo: $(Split-Path $b2 -Leaf))"
}

function Restore-Volume {
    $b1 = Join-Path $backupDir "$($volume)_1.tar.gz"
    $b2 = Join-Path $backupDir "$($volume)_2.tar.gz"

    $volumeExists = (docker volume ls -q | Select-String -SimpleMatch $volume) -ne $null

    if (-not $volumeExists) {
        Write-Host "[RESTORE] Volume $volume não existe. Criando e tentando restaurar do backup..."
        docker volume create $volume | Out-Null

        if (Test-Path $b1) {
            docker run --rm -v ${volume}:/data -v "${backupDir}:/backup" alpine `
                sh -c "tar xzf /backup/$($volume)_1.tar.gz -C /data"
            Write-Host "[OK] Restaurado do backup1."
        }
        elseif (Test-Path $b2) {
            docker run --rm -v ${volume}:/data -v "${backupDir}:/backup" alpine `
                sh -c "tar xzf /backup/$($volume)_2.tar.gz -C /data"
            Write-Host "[OK] Restaurado do backup2."
        }
        else {
            Write-Host "[WARN] Nenhum backup encontrado. Volume $volume permanecerá vazio."
        }
    }
    else {
        Write-Host "[SYNC] Volume $volume existe. Sincronizando com backup (sem sobrescrever arquivos mais novos)..."
        if (Test-Path $b1) {
            docker run --rm -v ${volume}:/data -v "${backupDir}:/backup" alpine `
                sh -c "tar xzf /backup/$($volume)_1.tar.gz -C /data --skip-old-files || true"
            Write-Host "[OK] Volume sincronizado com backup1."
        } else {
            Write-Host "[WARN] Nenhum backup disponível para sincronizar."
        }
    }
}

switch ($Action) {
    "up" {
        Restore-Volume
        docker compose -f "$PSScriptRoot\docker-compose.yml" up -d --build
    }
    "down" {
        Backup-Volume
        docker compose -f "$PSScriptRoot\docker-compose.yml" down
    }
    "stop" {
        Backup-Volume
        docker compose -f "$PSScriptRoot\docker-compose.yml" stop
    }
    "pause" {
        Backup-Volume
        docker compose -f "$PSScriptRoot\docker-compose.yml" pause
    }
}
