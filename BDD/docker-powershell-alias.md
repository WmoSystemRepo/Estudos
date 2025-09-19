# ⚡ ZDAV Launcher — Referência Rápida

Atalhos e comandos principais do ambiente **BDD com Docker**.

---

## ▶️ Subir / Derrubar Ambiente

```powershell
docker-up     # Restaura backups + sobe containers
docker-down   # Cria backups + derruba containers
docker-stop   # Cria backups + para containers
docker-pause  # Cria backups + pausa containers
```

---

## 💾 Backups Automáticos

- host_bdd_1.tar.gz → último backup do código (BDD/)
- host_bdd_2.tar.gz → penúltimo backup
- bundle_cache_1.tar.gz / _2.tar.gz → backups do volume Ruby
- app_data_1.tar.gz / _2.tar.gz → backups do volume compartilhado

Os arquivos ficam em:
```
BDD/Docker/backups/
```

---

## 💻 Alias no PowerShell

Exemplos (depois de configurar seu `$PROFILE`):

```powershell
ruby -v
bundle init
bundle install
irb

node -v
npm init -y
yarn -v
pnpm -v
```

---

## 🛠 Exemplos Rápidos

Criar Gemfile em subpasta:
```powershell
bundle init
```

Criar package.json em subpasta:
```powershell
npm init -y
```

Ver versões:
```powershell
ruby -v
node -v
```

---

✅ Use este arquivo como **atalho rápido** (cola no terminal quando esquecer os comandos).
