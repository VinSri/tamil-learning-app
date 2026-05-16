# tamil-learning-app

Open source Tamil language learning app with modern and classical Tamil support.

## Setup

* Ruby version — see `.ruby-version`
* PostgreSQL
* `bundle install`
* Copy `config/database.yml` locally (not in git)
* `bin/rails db:setup`
* `bin/dev`

## Configuration

Sensitive files are gitignored: `config/database.yml`, `config/credentials.yml.enc`, `config/master.key`, `.kamal/secrets`.
