$: << File.expand_path(File.dirname(__FILE__)) + '/../'
$: << File.expand_path(File.dirname(__FILE__)) + '/../lib/'

require 'rack/test'
require 'drink_app'


def app
  Sinatra::Application
end

#makes Rake::Test available to all contexts
RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def new_test_drink
  Repository.for(:drink).save(Drink.new)
end

def new_test_guest
  Repository.for(:guest).save(Guest.new)
end

def clear_records
  Repository.for(:drink).records = {}
  Repository.for(:guest).records = {}
  Repository.for(:order).records = {}

  Repository.for(:drink).id = 1
  Repository.for(:guest).id = 1
  Repository.for(:order).id = 1
end

