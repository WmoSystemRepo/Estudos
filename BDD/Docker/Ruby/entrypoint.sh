#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="/app"
PROJECT_PATH="$ROOT_DIR/QAx/projects/starbugs-cucumber"

# 1) Criar diretórios e ir para o projeto
mkdir -p "$PROJECT_PATH"
cd "$PROJECT_PATH"
echo "📂 Diretório de trabalho: $PROJECT_PATH"

# 2) Criar Gemfile se não existir
if [[ ! -f Gemfile ]]; then
  echo "📦 Criando Gemfile (bundle init)..."
  bundle init
fi

# 3) Garantir cucumber no Gemfile
if ! grep -qiE "gem ['\"]cucumber['\"]" Gemfile; then
  echo "➕ Adicionando gem 'cucumber' ao Gemfile..."
  echo "gem 'cucumber'" >> Gemfile
fi

# 4) Instalar dependências (no volume /usr/local/bundle)
echo "🔄 Instalando gems..."
bundle install --jobs 4 --retry 3

# 5) Criar binstubs do cucumber (útil para execuções locais)
bundle binstubs cucumber --force

# 6) Entregar o controle ao comando final (ex.: bash)
exec "$@"
