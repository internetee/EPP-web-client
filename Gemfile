source 'https://rubygems.org'

# core
gem 'rails', '4.2.1'

gem 'depp', github: 'domify/depp', ref: '800ab30dcb6dae33095bcb9df47b4e0a390891a3'
# gem 'depp', path: '../depp'

# load env
gem 'figaro', '~> 1.1.0'

# html-xml
gem 'haml-rails', '~> 0.9.0' # haml for views

# style
gem 'sass-rails', '~> 5.0.0'       # sass style
gem 'bootstrap-sass', '~> 3.3.1.0' # bootstrap style

# js
gem 'uglifier', '~> 2.6.1'         # minifies js
gem 'coffee-rails', '~> 4.1.0'     # coffeescript support
gem 'jquery-rails', '~> 4.0.3'     # jquery
gem 'turbolinks'
gem 'therubyracer',  platforms: :ruby

gem 'epp', '~> 1.4.2', github: 'gitlabeu/epp'

gem 'kaminari',        '~> 0.16.3'  # pagination

# monitors
gem 'newrelic_rpm', '~> 3.9.9.275'

group :development do
  # dev tools
  gem 'spring'
  gem 'unicorn'
  gem 'rubocop',               '~> 0.26.1'
  gem 'guard-rubocop',         '~> 1.1.0'

  # better errors
  gem 'better_errors', '~> 2.0.0'
  gem 'binding_of_caller', '~> 0.7.2'

  # fast sass development
  gem 'guard-livereload', '2.4.0', require: false
  gem 'rack-livereload', '0.3.15'

  # deploy
  gem 'mina', '~> 0.3.1' # for fast deployment
end

group :development, :test do
  gem 'pry',  '~> 0.10.1'
  gem 'sdoc', '~> 0.4.0'
end
