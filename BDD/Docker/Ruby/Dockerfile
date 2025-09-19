FROM ruby:3.2.2

# Dependências para gems nativas
RUN apt-get update -qq && apt-get install -y \
    build-essential git libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Gems no volume persistente e binários no PATH
ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_BIN=/usr/local/bundle/bin \
    GEM_HOME=/usr/local/bundle \
    PATH="/usr/local/bundle/bin:${PATH}"

WORKDIR /app

# Bundler alinhado ao seu ambiente
RUN gem install bundler:2.4.10

# Entrypoint: apenas bootstrap do projeto
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["bash"]
