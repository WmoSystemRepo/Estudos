# 🐳 Ambiente de Estudos - Microsserviços com .NET 6 + MySQL (Docker)

Este repositório contém um ambiente de **estudo de microsserviços** com **.NET 6** utilizando **MySQL em Docker**.  
A stack foi montada para **simular cenários reais de integração**, manipulação de dados e uso de containers em projetos de arquitetura moderna.

---

## 📂 Estrutura de Arquivos e Pastas

```
/projeto
│── docker-compose.yml   # orquestração dos serviços MySQL + Adminer
│── .env                 # credenciais e variáveis de ambiente
│── command_docke        # comandos úteis em PowerShell
│── READ                 # anotações rápidas (versão antiga do README)
│
├── conf/                # configs extras do MySQL
│   └── my.cnf
│
├── initdb/              # scripts SQL executados na primeira inicialização
│   └── 002-teste.sql    # exemplo: cria DB 'teste' e tabela 'pessoas'
│
└── backups/             # pasta reservada para backups do banco
```

### 🔎 Explicação dos principais arquivos

- **`docker-compose.yml`** → descreve os serviços (MySQL + Adminer), volumes e variáveis.  
- **`.env`** → armazena as credenciais do MySQL e configs de porta/timezone.  
- **`conf/`** → pode conter um `my.cnf` com ajustes de charset/collation.  
- **`initdb/`** → scripts `.sql` aqui são executados **automaticamente** na primeira vez que o MySQL sobe.  
- **`backups/`** → guarda dumps (`mysqldump`) para restauração.  
- **`command_docke`** → lista de comandos úteis (compose up, logs, exec).  
- **`READ`** → anotações temporárias (substituído por este `README.md`).  

---

## 🔑 Credenciais do MySQL

| Tipo de acesso  | Usuário   | Senha                  | Database | Observações                  |
|-----------------|-----------|------------------------|----------|------------------------------|
| 👑 Root (Admin) | `root`    | `TroqueEstaSenha!#2025`| Todos    | Controle total do servidor   |
| 👤 App (user)   | `appuser` | `SenhaDoApp!#2025`     | `appdb`  | Usuário para aplicações      |

- **Sistema**: MySQL / MariaDB  
- **Servidor (host)**: `mysql`  
- **Timezone**: `America/Sao_Paulo`  
- **Porta exposta**: `3306`  

> ⚠️ Senhas com `#` devem estar **entre aspas** no `.env`.

---

## ▶️ Subindo o Ambiente

Na raiz do projeto:

```powershell
docker compose down -v   # remove containers + volumes antigos
docker compose pull      # baixa imagens atualizadas
docker compose up -d     # sobe serviços em background
docker compose ps        # mostra status dos containers
```

📜 **Ver logs do MySQL**:
```powershell
docker compose logs -f mysql
```

---

## 🌐 Acesso ao Adminer (GUI)

➡️ Navegador → [http://localhost:8080](http://localhost:8080)  

Na tela de login:

- **Sistema**: MySQL / MariaDB  
- **Servidor**: `mysql`  
- **Usuário**: `root`  
- **Senha**: `TroqueEstaSenha!#2025`  
- **Database**: (deixe vazio para listar todos)

---

## 🧪 Testes com Banco `teste`

### 1️⃣ Criar banco
```sql
CREATE DATABASE teste
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;
```

### 2️⃣ Criar tabela `pessoas`
```sql
CREATE TABLE pessoas (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  idade INT
);
```

### 3️⃣ Inserir registros
```sql
INSERT INTO pessoas (nome, idade) VALUES
  ('João', 30),
  ('Maria', 25);
```

### 4️⃣ Consultar
```sql
SELECT * FROM pessoas;
```

📊 **Resultado esperado**:

| id | nome  | idade |
|----|-------|-------|
| 1  | João  | 30    |
| 2  | Maria | 25    |

---

## 📦 Backup & Restore

### 🔹 Backup
```powershell
docker compose exec mysql mysqldump -uroot -p appdb > .\backups\appdb.sql
```

### 🔹 Restore
```powershell
type .\backups\appdb.sql | docker compose exec -i mysql mysql -uroot -p appdb
```

---

## ⚙️ Observações Importantes

- 📌 Scripts em `initdb/` só rodam **na primeira inicialização** (quando o volume é novo).  
- 🔄 Para rodar scripts novos:  
  ```powershell
  docker compose down -v
  docker compose up -d
  ```
- 🐳 Containers rodam em rede interna:  
  - dentro do Compose use `mysql` como host;  
  - acessos externos usem `127.0.0.1`.

---

## 🧭 Próximos Passos

- ➕ Criar scripts SQL mais avançados em `initdb/`.  
- 🔗 Simular integrações com microsserviços .NET 6.  
- 💾 Criar pipelines de **backup automático** na pasta `backups/`.  
- ⚡ Explorar **procedures, triggers e índices** para enriquecer os testes.  

---

✍️ **Autor**: Ambiente configurado por *Mendes* para estudos de **Docker + MySQL + Adminer** em contexto de **Microsserviços .NET 6**.
