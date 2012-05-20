source "https://rubygems.org"

gem "rails", "3.2.2"

# Bundle edge Rails instead:
# gem "rails", :git => "git://github.com/rails/rails.git"

gem "rails-api"

gem "mongoid"
gem "bson_ext"

gem "spreadsheet", :require => false

gem "savon", :require => false

gem "kaminari"

gem "thin"


gem "jquery-rails"

gem "active_model_serializers", :git => "git://github.com/josevalim/active_model_serializers.git"

group :development do
  gem "guard-cucumber"
  gem "guard-rspec"
end

group :test do
  gem "cucumber-rails", :require => false
  gem "cucumber-api-steps", :require => false
  gem "json_spec"
  gem "database_cleaner"
  gem "spork"
  gem "factory_girl"
  gem "pickle"
end

group :test, :development do
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "mongoid-rspec"
end

# To use ActiveModel has_secure_password
# gem "bcrypt-ruby", "~> 3.0.0"

# To use Jbuilder templates for JSON
# gem "jbuilder"

# Use unicorn as the app server
# gem "unicorn"

# Deploy with Capistrano
# gem "capistrano", :group => :development

# To use debugger
# gem "ruby-debug19", :require => "ruby-debug"
