#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="/app"
PROJECT_PATH="$ROOT_DIR/QAx/projects/starbugs-cucumber"

mkdir -p "$PROJECT_PATH"
cd "$PROJECT_PATH"
echo "📂 Diretório de trabalho: $PROJECT_PATH"

if [[ ! -f Gemfile ]]; then
  echo "📦 Criando Gemfile (bundle init)..."
  bundle init
fi

if ! grep -qiE "gem ['\"]cucumber['\"]" Gemfile; then
  echo "➕ Adicionando gem 'cucumber' ao Gemfile..."
  echo "gem 'cucumber'" >> Gemfile
fi

echo "🔄 Instalando gems..."
bundle install --jobs 4 --retry 3

bundle binstubs cucumber --force

exec "$@"
