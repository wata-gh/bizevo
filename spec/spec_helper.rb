unless defined?(RACK_ENV)
  RACK_ENV = ENV['RACK_ENV'] == 'development' ? 'test' : ENV['RACK_ENV']
end

require 'simplecov'
require 'simplecov-rcov'
require 'simplecov_custom_profile'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start 'padrino'

require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require 'rr'
Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/**/*.rb")].each(&method(:require))
Dir[File.expand_path(File.dirname(__FILE__) + '/factories/**/*.rb')].each(&method(:require))
Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/*.rb")].each(&method(:require))
Dir[File.expand_path(File.dirname(__FILE__) + '/../lib/**/*.rb')].each(&method(:require))

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  conf.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  conf.before(:each) do
    DatabaseCleaner.start
  end

  conf.after(:each) do
    DatabaseCleaner.clean
  end
end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app Bizevo::App
#   app Bizevo::App.tap { |a| }
#   app(Bizevo::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end
