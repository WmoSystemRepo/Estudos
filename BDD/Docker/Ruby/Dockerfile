# Imagem oficial do Ruby 3.2.2 (baseada em Debian)
FROM ruby:3.2.2

# Instalar pacotes adicionais (equivalente ao DevKit no Linux)
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    libyaml-dev \
    sqlite3 libsqlite3-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Verificação
RUN ruby -v
