# Use a imagem oficial do Ruby
FROM ruby:3.1.1

# Instalar dependências do sistema
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  && rm -rf /var/lib/apt/lists/*

# Defina o diretório de trabalho
WORKDIR /srv/jekyll

# Copiar o Gemfile
COPY Gemfile /srv/jekyll/Gemfile

# Instalar as dependências do Bundler
RUN gem install bundler && bundle install

# Copiar o restante dos arquivos do projeto
COPY . /srv/jekyll

# Expor a porta 4000
EXPOSE 4000

# Comando para iniciar o servidor Jekyll
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
