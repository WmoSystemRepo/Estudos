# 📦 Docker Commands — Guia Completo para CMD

Este documento é um guia prático, **profissional** e organizado com os principais comandos do **Docker** que você pode rodar no **CMD** (Windows) ou terminal (Linux/Mac).  
Inclui exemplos, explicações, boas práticas e até fluxos ilustrativos para facilitar o aprendizado. 🚀

---

## 🐳 O que é o Docker?

O **Docker** é uma plataforma open-source que facilita a criação, deploy e execução de aplicações em **containers**.  
Um **container** é como uma "caixa isolada" que contém tudo que sua aplicação precisa para rodar: código, dependências, bibliotecas e configurações.

🔑 **Benefícios principais:**
- Portabilidade: roda em qualquer ambiente (Windows, Linux, Mac).
- Escalabilidade: fácil de replicar e subir múltiplos containers.
- Isolamento: evita conflitos de dependências entre projetos.

---

## 🔹 Fluxo Básico do Docker

```mermaid
flowchart LR
    A[📥 Pull Imagem] --> B[📦 Criar Container]
    B --> C[▶️ Rodar Container]
    C --> D[🔍 Monitorar / Logs]
    D --> E[🛑 Parar / Remover]
```

Esse fluxo mostra os passos comuns de uso no dia a dia.

---

## ⚙️ Comandos Básicos

### Verificar versão instalada
```sh
docker --version
```
📌 Mostra a versão atual do Docker instalada na máquina.

### Verificar se o Docker está rodando
```sh
docker info
```
📌 Exibe informações detalhadas sobre o daemon do Docker.

### Listar todos os comandos disponíveis
```sh
docker --help
```
📌 Mostra todos os comandos principais e opções disponíveis.

---

## 🖼️ Trabalhando com Imagens

### Baixar uma imagem
```sh
docker pull <imagem>:<tag>
```
Exemplo:
```sh
docker pull nginx:latest
```

### Listar imagens baixadas
```sh
docker images
```

### Remover uma imagem
```sh
docker rmi <image_id>
```

### Inspecionar imagem
```sh
docker inspect <image_id>
```

---

## 📦 Containers

### Criar e rodar um container
```sh
docker run <opções> <imagem>
```
Exemplo:
```sh
docker run -d -p 8080:80 nginx
```
- `-d`: roda em segundo plano (detached)
- `-p`: mapeia a porta local para a porta do container

### Listar containers em execução
```sh
docker ps
```

### Listar todos containers (inclusive parados)
```sh
docker ps -a
```

### Parar um container
```sh
docker stop <container_id>
```

### Iniciar um container parado
```sh
docker start <container_id>
```

### Reiniciar um container
```sh
docker restart <container_id>
```

### Remover um container
```sh
docker rm <container_id>
```

### Acessar terminal do container
```sh
docker exec -it <container_id> bash
```

---

## 💾 Volumes (Persistência de Dados)

### Criar volume
```sh
docker volume create <nome_volume>
```

### Listar volumes
```sh
docker volume ls
```

### Remover volume
```sh
docker volume rm <nome_volume>
```

### Montar volume em container
```sh
docker run -d -v <nome_volume>:/caminho/no/container nginx
```

---

## 🌐 Redes

### Listar redes
```sh
docker network ls
```

### Criar rede
```sh
docker network create <nome_rede>
```

### Conectar container a uma rede
```sh
docker network connect <nome_rede> <container_id>
```

### Remover rede
```sh
docker network rm <nome_rede>
```

---

## 📊 Logs e Monitoramento

### Ver logs de um container
```sh
docker logs <container_id>
```

### Seguir logs em tempo real
```sh
docker logs -f <container_id>
```

### Ver consumo de recursos
```sh
docker stats
```

---

## 🛠️ Docker Compose

O **Docker Compose** permite orquestrar múltiplos containers usando um arquivo `docker-compose.yml`.

### Subir containers com `docker-compose.yml`
```sh
docker-compose up -d
```

### Derrubar containers do compose
```sh
docker-compose down
```

### Reconstruir serviços
```sh
docker-compose up --build -d
```

---

## 🧹 Limpeza e Manutenção

### Remover containers parados
```sh
docker container prune
```

### Remover imagens não utilizadas
```sh
docker image prune
```

### Remover volumes não utilizados
```sh
docker volume prune
```

### Remover tudo (containers, volumes, redes e imagens não utilizados)
```sh
docker system prune -a
```

---

## ✅ Boas Práticas

✔️ Sempre use **tags específicas** (`nginx:1.23`) em vez de `latest`.  
✔️ Organize containers em **redes próprias** para cada projeto.  
✔️ Use **volumes nomeados** em vez de paths absolutos quando possível.  
✔️ Monitore com `docker stats` e `docker logs`.  
✔️ Prefira `docker-compose` para projetos com múltiplos serviços.

---

## 📚 Recursos Extras

- 📖 [Documentação Oficial do Docker](https://docs.docker.com/)
- 🎥 [Playlist sobre Docker no YouTube (em Português)](https://www.youtube.com/playlist?list=PLf-O3X2-mxDlvXQGDvqetZ2x7Hm7JQ4g3)
- 📦 [Docker Hub - Repositório de Imagens](https://hub.docker.com/)

---

✍️ **Autor:** Documentação gerada para estudos e prática de Docker, no estilo **profissional**.  
