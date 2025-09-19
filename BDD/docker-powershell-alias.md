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
que redirecionam para os containers.  
Assim, você usa `ruby`, `node`, `npm` normalmente, como se estivessem instalados no Windows.

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

Cole o seguinte conteúdo:

```powershell
function ruby {
    docker compose run --rm ruby-3.2.2 ruby $args
}

function node {
    docker compose run --rm node-18.12.1 node $args
}

function npm {
    docker compose run --rm node-18.12.1 npm $args
}
```

💡 Você pode adicionar outros atalhos, como:

```powershell
function yarn {
    docker compose run --rm node-18.12.1 yarn $args
}

function pnpm {
    docker compose run --rm node-18.12.1 pnpm $args
}

function irb {
    docker compose run --rm ruby-3.2.2 irb $args
}
```

---

### 4️⃣ Recarregar o perfil
Depois de salvar, recarregue:
```powershell
. $PROFILE
```

---

### 5️⃣ Testar os comandos
Agora você pode rodar normalmente no PowerShell:

```powershell
ruby --version
node --version
npm -v
yarn -v
pnpm -v
irb
```

👉 Esses comandos estão rodando **dentro dos containers Docker**, mas para você é como se estivessem instalados no Windows.

---

## ✅ Conclusão

- **Opção 1:** Boa para testes rápidos.  
- **Opção 2:** Boa para rodar um comando isolado.  
- **Opção 3:** Melhor para o dia a dia, integra o Docker ao seu terminal como se fosse ambiente local.  

✨ Dessa forma, você tem um **ambiente de estudos completo** (Node.js + Ruby + outros) rodando via Docker,
mas acessível direto pelo seu **PowerShell**.

---

> 📘 **Dica:** Esta documentação foi criada para ser usada em projetos de estudo no GitHub.  
> Salve este arquivo como **`docker-powershell-alias.md`** na raiz do seu repositório e consulte sempre que precisar.
