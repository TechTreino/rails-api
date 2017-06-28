# techtreino-api
[![CircleCI](https://circleci.com/gh/TechTreino/rails-api.svg?style=svg)](https://circleci.com/gh/TechTreino/rails-api)
[![Code Climate](https://codeclimate.com/github/TechTreino/rails-api/badges/gpa.svg)](https://codeclimate.com/github/TechTreino/rails-api)

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

Every email sent in developer env will open a tab in your browser, through `letter_opener`

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
* CLIENT_URL
  * Required for production environment
* SENTRY_DSN
  * Required for production environment

