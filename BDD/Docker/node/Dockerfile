# Imagem base exatamente na versão pedida
FROM node:18.12.1

# Diretório de trabalho dentro do container
WORKDIR /usr/src/app

# Copia apenas os manifests primeiro (melhora cache)
COPY package*.json ./

# Instala dependências (ajuste para "npm ci" se usar lockfile)
RUN npm install --silent

# Agora copia o restante do código
COPY . .

# Porta padrão de apps web em Node (ajuste se precisar)
EXPOSE 3000

# Comando padrão (precisa existir "start" no package.json)
CMD ["npm", "start"]
