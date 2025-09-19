FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y \
    build-essential git libpq-dev \
    && rm -rf /var/lib/apt/lists/*

ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_BIN=/usr/local/bundle/bin \
    GEM_HOME=/usr/local/bundle \
    PATH="/usr/local/bundle/bin:${PATH}"

WORKDIR /app

RUN gem install bundler:2.4.10

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["bash"]
