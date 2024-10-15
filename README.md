# README

# Consumer API - README

## Descrição

Este é um projeto Ruby on Rails para uma API de consumidores. Ele utiliza o Rails 7.2.1 com várias dependências importantes, como MySQL, Mongoid, Redis, e Sidekiq.

## Requisitos

Certifique-se de ter as seguintes dependências instaladas:

- *Ruby* 3.2.2 ou superior (a versão exata está definida no arquivo .ruby-version)
- *MySQL* 5.7 ou superior
- *Node.js* e *Yarn* (para gerenciamento de assets)
- *Bundler* (para gerenciar dependências Ruby)

## Instalação

### 1. Clonar o repositório

Primeiro, clone o repositório do projeto:

```bash
git clone https://github.com/oaspira/consumer_api.git
cd consumer_api
```

### 2. Instalar as dependências

Assumindo que você já tenha o Ruby instalado e configurado, instale as gems necessárias com o Bundler:

```bash
bundle install
```

### 3. Configurar o banco de dados

Este projeto utiliza MySQL e MongoDB. Primeiro, certifique-se de que o MySQL e o MongoDB estejam configurados corretamente em sua máquina.

- Edite o arquivo `config/database.yml` com as suas configurações do MySQL.
- Certifique-se de que o MongoDB esteja rodando localmente.

Após configurar o banco de dados, crie as tabelas e rode as migrações:

```bash
rails db:create
rails db:migrate
```

### 4. Iniciar o servidor

Inicie o servidor Rails com o seguinte comando:

```bash
rails s
```

### 5. Testes

O projeto utiliza RSpec para testes. Para rodar os testes, use o seguinte comando:

```bash
bundle exec rspec
```

### 6. Sidekiq

Para gerenciar filas de background jobs, o projeto utiliza Sidekiq. Certifique-se de que o Redis esteja rodando localmente e inicie o Sidekiq com o seguinte comando:

```bash
bundle exec sidekiq
```
