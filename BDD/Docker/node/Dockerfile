# Imagem base exatamente na versão pedida
FROM node:18.12.1

# Ativar Corepack (Yarn/Pnpm)
RUN corepack enable

# Diretório de trabalho
WORKDIR /usr/src/app

# Copiar e instalar dependências
COPY package*.json ./
RUN npm install --silent

# Copiar o restante do código
COPY . .

# Expor porta do exemplo
EXPOSE 3000

# Comando padrão
CMD ["npm", "start"]
