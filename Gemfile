source 'https://rubygems.org'

# Distribute your app as a gem
# gemspec

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'bcrypt'
gem 'erubis', '~> 2.7.0'
gem 'activerecord', '>= 3.1', :require => 'active_record'
gem 'mysql2'
gem 'redcarpet'
gem 'composite_primary_keys'
gem 'database_cleaner'
gem 'unicorn'
gem 'actionview'
gem 'actionpack'
gem 'kaminari', '0.16.1', :require => 'kaminari/sinatra'
gem 'ruby-oci8'
gem 'activerecord-oracle_enhanced-adapter', '~> 1.5.0'
gem 'composite_primary_keys'
gem 'enum_help'

# Test requirements
group :test, :'travis-ci' do
  gem 'rr', :require => false
  gem 'rspec'
  gem 'rack-test', :require => 'rack/test'
  gem 'factory_girl'
  gem 'awesome_print'
  gem 'simplecov'
  gem 'simplecov-rcov'
  gem 'ci_reporter'
end

group :deployment do
  gem 'capistrano'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano3-unicorn'
end

# Padrino Stable Gem
gem 'padrino', '0.12.5'

# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# Or Individual Gems
# %w(core support gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.12.3'
# end
