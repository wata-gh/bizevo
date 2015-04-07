# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano3/unicorn'

set :rbenv_type, :user
set :rbenv_ruby, '2.2.0'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
