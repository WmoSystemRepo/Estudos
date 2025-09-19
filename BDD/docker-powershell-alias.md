# ⚡ Guia: Usando Docker como Ambiente Local no PowerShell

Este guia mostra como usar **Node.js** e **Ruby** (ou qualquer outro runtime que você rodar via Docker)
**como se estivessem instalados na sua máquina**.  
A ideia é criar um ambiente de estudo totalmente isolado no Docker, mas com comandos acessíveis no seu terminal.

---

## 🚀 Três opções disponíveis

Existem três formas principais de usar seus containers:

### 🥇 Opção 1 — Entrar no Container

A forma mais simples é **entrar no container** e rodar os comandos lá dentro:

```powershell
docker exec -it ruby-3.2.2 bash
```

➡️ Dentro do container:
```bash
ruby --version
```

👉 Você fica “preso” no container até sair com `exit`.

---

### 🥈 Opção 2 — Rodar comandos diretos com `docker compose run`

Sem precisar entrar no container, você pode rodar comandos diretos:

```powershell
docker compose run --rm ruby-3.2.2 ruby --version
docker compose run --rm node-18.12.1 node --version
docker compose run --rm node-18.12.1 npm -v
```

➡️ O `--rm` garante que o container temporário é removido depois.

---

### 🥉 Opção 3 — Criar Atalhos no PowerShell (💎 Recomendado)

A opção mais prática para o **dia a dia** é criar **funções no PowerShell**
que montam automaticamente a **pasta atual ($PWD)** no container.  
Assim, você usa `ruby`, `bundle`, `irb`, `node`, `npm` em qualquer subpasta dentro de `BDD/`.

---

## 🔎 Passo a Passo da Opção 3

### 1️⃣ Descobrir o arquivo de perfil do PowerShell
Rode:
```powershell
echo $PROFILE
```
Exemplo de saída:
```
C:\Users\Mendes\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
```

---

### 2️⃣ Criar o arquivo se não existir
Verifique:
```powershell
Test-Path $PROFILE
```
- Se for **False**, crie o arquivo:
```powershell
New-Item -Path $PROFILE -ItemType File -Force
```

---

### 3️⃣ Editar o perfil
Abra no bloco de notas:
```powershell
notepad $PROFILE
```

Cole o seguinte conteúdo (com `Remove-Item alias` para evitar conflito com Node ou Ruby instalados localmente):

```powershell
# --- Ruby / Bundler ---
Remove-Item alias:ruby -ErrorAction SilentlyContinue
function ruby {
    docker run --rm -it -v "${PWD}:/app" -w /app ruby-3.2.2 ruby $args
}

Remove-Item alias:bundle -ErrorAction SilentlyContinue
function bundle {
    docker run --rm -it -v "${PWD}:/app" -w /app ruby-3.2.2 bundle $args
}

Remove-Item alias:irb -ErrorAction SilentlyContinue
function irb {
    docker run --rm -it -v "${PWD}:/app" -w /app ruby-3.2.2 irb $args
}

# --- Node.js / NPM ---
Remove-Item alias:node -ErrorAction SilentlyContinue
function node {
    docker run --rm -it -v "${PWD}:/app" -w /app node-18.12.1 node $args
}

Remove-Item alias:npm -ErrorAction SilentlyContinue
function npm {
    docker run --rm -it -v "${PWD}:/app" -w /app node-18.12.1 npm $args
}
```

💡 Se quiser, pode adicionar também para `yarn` e `pnpm`:
```powershell
function yarn {
    docker run --rm -it -v "${PWD}:/app" -w /app node-18.12.1 yarn $args
}

function pnpm {
    docker run --rm -it -v "${PWD}:/app" -w /app node-18.12.1 pnpm $args
}
```

---

### 4️⃣ Recarregar o perfil
Depois de salvar, recarregue:
```powershell
. $PROFILE
```

---

### 5️⃣ Testar em qualquer subpasta dentro de `BDD/`

Exemplo:
```powershell
cd C:\Users\Mendes\Desktop\Clones\Wmo\Estudos\BDD\QAxe

bundle init       # cria Gemfile em QAxe
bundle -v
ruby -v

npm init -y       # cria package.json em QAxe
node -v
```

👉 Agora tudo funciona como se estivesse instalado localmente, mas na verdade roda dentro dos containers Docker.

---

## ✅ Conclusão

- **Opção 1:** Boa para testes rápidos.  
- **Opção 2:** Boa para rodar um comando isolado.  
- **Opção 3:** Melhor para o dia a dia → com atalhos dinâmicos que funcionam em qualquer subpasta dentro de `BDD/`.  

✨ Assim você tem um **ambiente de estudos completo** (Node.js + Ruby + Bundler), isolado no Docker, mas acessível direto pelo seu **PowerShell**.
