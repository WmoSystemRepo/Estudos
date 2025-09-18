# 📦 Docker Commands — Guia Completo para CMD

Este documento é um guia prático e organizado com os principais comandos do **Docker** que você pode rodar no **CMD** (Windows) ou terminal (Linux/Mac).

---

## 🔹 Básico do Docker

### Verificar versão instalada
```sh
docker --version
```
Mostra a versão atual do Docker instalada na máquina.

### Verificar se o Docker está rodando
```sh
docker info
```
Exibe informações detalhadas sobre o daemon do Docker.

### Listar todos os comandos disponíveis
```sh
docker --help
```
Mostra todos os comandos principais e opções disponíveis.

---

## 🔹 Imagens

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

---

## 🔹 Containers

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

### Remover um container
```sh
docker rm <container_id>
```

---

## 🔹 Volumes

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

---

## 🔹 Redes

### Listar redes
```sh
docker network ls
```

### Criar rede
```sh
docker network create <nome_rede>
```

### Remover rede
```sh
docker network rm <nome_rede>
```

---

## 🔹 Logs e Execução

### Ver logs de um container
```sh
docker logs <container_id>
```

### Acessar o terminal dentro de um container
```sh
docker exec -it <container_id> bash
```

---

## 🔹 Docker Compose

### Subir containers com `docker-compose.yml`
```sh
docker-compose up -d
```

### Derrubar containers do compose
```sh
docker-compose down
```

---

## 🔹 Limpeza

### Remover containers parados
```sh
docker container prune
```

### Remover imagens não utilizadas
```sh
docker image prune
```

### Remover tudo (containers, volumes, redes e imagens não utilizados)
```sh
docker system prune -a
```

---

## 📌 Dicas Extras

- Sempre utilize **tags** nas imagens (`nginx:1.23`) ao invés de `latest` para garantir consistência.
- Use `docker inspect <id>` para ver detalhes avançados sobre containers, imagens ou volumes.
- Combine `docker ps` com `grep` para localizar containers específicos:
  ```sh
  docker ps | grep nginx
  ```

---

✍️ **Autor:** Documentação gerada para estudos e prática de Docker.
