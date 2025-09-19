# ==============================
# Script de gerenciamento Docker
# ==============================
# Objetivo:
#   - Centralizar a lógica de backup/restore dos volumes Docker e do bind mount do host (BDD/).
#   - Automatizar nos comandos `up`, `down`, `stop`, `pause` para nunca perder dados.
# ==============================

# --- Parâmetro obrigatório: ação a executar ---
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("up","down","stop","pause")]  # Só aceita esses valores
    [string]$Action
)

# === CONFIGURAÇÃO GERAL ===
# Lista de volumes Docker que queremos proteger
$volumes = @("bundle_cache", "app_data")

# Caminho da pasta onde ficam os backups (dentro de BDD/Docker/backups)
$backupDir = Join-Path $PSScriptRoot "backups"
if (!(Test-Path $backupDir)) { New-Item -ItemType Directory -Path $backupDir | Out-Null }

# Raiz do projeto (um nível acima de Docker/) → será usada para backup/restore do bind mount
$hostRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path

# ==================================================================
# FUNÇÕES DE BACKUP E RESTORE DOS VOLUMES DOCKER
# ==================================================================

function Backup-Volume($volume) {
    Write-Host "[BACKUP] Volume $volume..."

    # Executa um container Alpine temporário
    # - Monta o volume em /data
    # - Monta a pasta de backups em /backup
    # - Compacta o conteúdo do volume em um tar.gz
    docker run --rm -v "${volume}:/data" -v "${backupDir}:/backup" alpine `
        sh -c "tar -czf /backup/tmp_${volume}.tar.gz -C /data ."

    # Arquivos finais de backup (último e penúltimo)
    $b1 = Join-Path $backupDir "$($volume)_1.tar.gz"  # mais recente
    $b2 = Join-Path $backupDir "$($volume)_2.tar.gz"  # anterior

    # Rotaciona: se já existe um backup mais novo, move ele para o "2"
    if (Test-Path $b1) {
        if (Test-Path $b2) { Remove-Item $b2 -Force } # apaga o penúltimo, se já existir
        Move-Item -Force $b1 $b2
    }

    # Renomeia o arquivo temporário para se tornar o backup mais recente
    Move-Item -Force (Join-Path $backupDir "tmp_${volume}.tar.gz") $b1

    Write-Host "[OK] Gerado: $(Split-Path $b1 -Leaf)"
}

function Restore-Volume($volume) {
    # Caminhos dos backups disponíveis
    $b1 = Join-Path $backupDir "$($volume)_1.tar.gz"
    $b2 = Join-Path $backupDir "$($volume)_2.tar.gz"

    # Verifica se o volume já existe
    $volumeExists = (docker volume ls -q | Select-String -SimpleMatch $volume) -ne $null
    if (-not $volumeExists) {
        Write-Host "[RESTORE] Criando volume $volume..."
        docker volume create $volume | Out-Null
    }

    # Se existir backup mais recente (_1), extrai ele no volume
    if (Test-Path $b1) {
        docker run --rm -v "${volume}:/data" -v "${backupDir}:/backup" alpine `
            sh -c "tar -xzf /backup/$($volume)_1.tar.gz -C /data || true"
        Write-Host "[OK] $volume restaurado de ${volume}_1.tar.gz"
    }
    # Senão, tenta restaurar o penúltimo backup (_2)
    elseif (Test-Path $b2) {
        docker run --rm -v "${volume}:/data" -v "${backupDir}:/backup" alpine `
            sh -c "tar -xzf /backup/$($volume)_2.tar.gz -C /data || true"
        Write-Host "[OK] $volume restaurado de ${volume}_2.tar.gz"
    }
    else {
        # Nenhum backup disponível → volume segue vazio
        Write-Host "[WARN] Sem backup para $volume (segue vazio)."
    }
}

# ==================================================================
# FUNÇÕES DE BACKUP E RESTORE DO BIND MOUNT DO HOST (pasta BDD/)
# ==================================================================

function Backup-HostTree {
    Write-Host "[BACKUP] Árvore do host em: $hostRoot"

    # Executa container Alpine temporário:
    # - Monta a pasta raiz do projeto em /host
    # - Monta a pasta de backups em /backup
    # - Compacta todo o conteúdo da raiz (exceto Docker/ e Docker/backups/)
    docker run --rm -v "${hostRoot}:/host" -v "${backupDir}:/backup" alpine `
      sh -c "tar -czf /backup/tmp_host_bdd.tar.gz --exclude=Docker --exclude=Docker/backups -C /host ."

    # Arquivos finais de backup
    $h1 = Join-Path $backupDir "host_bdd_1.tar.gz"
    $h2 = Join-Path $backupDir "host_bdd_2.tar.gz"

    # Rotação: último vai para o "2"
    if (Test-Path $h1) {
        if (Test-Path $h2) { Remove-Item $h2 -Force }
        Move-Item -Force $h1 $h2
    }

    # Renomeia o temporário para o mais recente
    Move-Item -Force (Join-Path $backupDir "tmp_host_bdd.tar.gz") $h1

    Write-Host "[OK] Gerado: $(Split-Path $h1 -Leaf)"
}

function Restore-HostTree {
    # Caminhos dos backups
    $h1 = Join-Path $backupDir "host_bdd_1.tar.gz"
    $h2 = Join-Path $backupDir "host_bdd_2.tar.gz"

    # Se existir backup mais recente (_1), restaura ele
    if (Test-Path $h1) {
        docker run --rm -v "${hostRoot}:/host" -v "${backupDir}:/backup" alpine `
          sh -c "tar -xzf /backup/host_bdd_1.tar.gz -C /host"
        Write-Host "[OK] Host restaurado de host_bdd_1.tar.gz"
    }
    # Senão, restaura o penúltimo (_2)
    elseif (Test-Path $h2) {
        docker run --rm -v "${hostRoot}:/host" -v "${backupDir}:/backup" alpine `
          sh -c "tar -xzf /backup/host_bdd_2.tar.gz -C /host"
        Write-Host "[OK] Host restaurado de host_bdd_2.tar.gz"
    }
    else {
        # Nenhum backup disponível
        Write-Host "[WARN] Sem backup do host (nada a restaurar)."
    }
}

# ==================================================================
# ORQUESTRAÇÃO PRINCIPAL
# ==================================================================
switch ($Action) {
    "up" {
        # 1. Restaura arquivos do host e volumes
        Restore-HostTree
        foreach ($v in $volumes) { Restore-Volume $v }

        # 2. Sobe os containers
        docker compose -f "$PSScriptRoot\docker-compose.yml" up -d --build
    }
    "down" {
        # 1. Cria backups do host e volumes
        Backup-HostTree
        foreach ($v in $volumes) { Backup-Volume $v }

        # 2. Derruba os containers
        docker compose -f "$PSScriptRoot\docker-compose.yml" down
    }
    "stop" {
        # Igual ao "down", mas mantém containers e rede criados
        Backup-HostTree
        foreach ($v in $volumes) { Backup-Volume $v }
        docker compose -f "$PSScriptRoot\docker-compose.yml" stop
    }
    "pause" {
        # Pausa os containers, mas antes garante backup
        Backup-HostTree
        foreach ($v in $volumes) { Backup-Volume $v }
        docker compose -f "$PSScriptRoot\docker-compose.yml" pause
    }
}
