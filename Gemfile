source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'pg'
gem 'unicorn'

gem 'haml-rails'
gem 'inherited_resources'
gem 'bootstrap-generators'
gem 'simple_form'
gem 'activerecord_views'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'better_errors'                                           # Better error page for Rails and other Rack apps
  gem 'binding_of_caller'                                       # Enables the advanced features of Better Errors
end

group :development, :test do
  gem 'awesome_print', :require => 'ap'                         # Colourful memory structure text visualizer
  gem 'pry'                                                     # Debugger console system
  gem 'pry-nav'                                                 # Debugger navigation extension
  gem 'pry-rails'                                               # Use "pry" with Rails
  gem 'zeus', :require => false                                 # Rails aware forking server
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'capybara-webkit'
  gem 'site_prism'
  gem 'launchy'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

group :production do
  gem 'rails_12factor'
end
