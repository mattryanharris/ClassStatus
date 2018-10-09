source 'https://rubygems.org'
ruby "2.1.5"

gem 'rails', '~> 4.0.0'

# Assets
gem 'bootstrap-sass-rails'
gem "font-awesome-sass"
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'turbolinks'
gem 'jquery-rails'
gem 'fancybox2-rails'

# System
gem 'jbuilder', '~> 1.2'
# gem 'bcrypt-ruby', '~> 3.0.0'
# gem 'unicorn'

gem "thin"
gem "haml"
gem "haml-rails"
gem "pg"
gem "simple_form"
gem "devise"
gem "stripe"
gem "cancan"
gem "cancan_strong_parameters"
gem "plivo"

group :production do
	gem 'rails_12factor'
	gem "newrelic_rpm"
end

gem "dotenv-rails", group: [:development, :test]
group :development do
  gem "guard", ">= 2.1"
  gem "guard-rspec"
  gem "guard-rails"
  gem "guard-annotate"
  gem "better_errors"
  gem "binding_of_caller"
  gem "quiet_assets"
	gem "pry-coolline"
end

group :test do
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "capybara"
  gem "database_cleaner"
  gem "faker"
  gem "stripe-ruby-mock"
	gem "rspec-activemodel-mocks"
end
