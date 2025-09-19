# Imagem base exatamente na versão pedida
FROM node:18.12.1

# Ativar Corepack (Yarn/Pnpm)
RUN corepack enable

# Definir diretório de trabalho
WORKDIR /usr/src/app

# Copiar dependências
COPY package*.json ./

# Instalar dependências
RUN npm install --silent

# Copiar restante do código
COPY . .

# Expor porta
EXPOSE 3000

# Comando padrão
CMD ["npm", "start"]
