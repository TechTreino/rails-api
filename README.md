# techtreino-api
[![CircleCI](https://circleci.com/gh/wagoid/techtreino-api.svg?style=svg&circle-token=8e0b960a4b7d64f929cf4301d580e140044ffdec)](https://circleci.com/gh/wagoid/techtreino-api)

Techtreino-api is a rails API application

## Install development environment on Mac OSX

* System dependencies
  * A Postgres database server; typically installed using home brew
    * `brew install postgresql`
  * `rvm` or `rbenv` for Ruby Version management
    * `.ruby-version` file should auto load correct ruby version

* Setup
  * `bundle`
  * `rails db:create db:schema:load db:migrate db:seed`
  * Start the application: `rails s`

## Development

* How to run the test suite
  * `rake` will run the default rake task which runs the specs and lint check
  * Alternatively they can be run independently:
    * `rspec spec`
    * `rubocop`

NOTE: depending on your environment you may need to prefix your rails commands with `bundle exec` or use `bin/rails`

### Pairing

While pairing you may want to use `git pair` for your commits, it requires installing the gem
* `gem install pivotal_git_scripts`
* See: [https://github.com/pivotal/git_scripts](https://github.com/pivotal/git_scripts)

### Testing email in development

2 options

1. Use rspec preview, see `spec/mailers/previews`
2. Use mailcatcher
 * `gem install mailcatcher`
 * Run it: `mailcatcher`
 * View emails at http://127.0.0.1:1080
 * Development environment is already configured to use mailcatcher for sending email

## Deployment

Deployment is handled automatically by CI, which pushes everything to heroku and runs migrations.
### Environment Variables

* PORT
  * Required in production, uses default for other environments
* SECRET_KEY_BASE
  * Required in production, uses default for other environments
* SMTP_USER_NAME
  * Required for production environment
* SMTP_PASSWORD
  * Required for production environment
* APP_URL
  * Required for production environment

