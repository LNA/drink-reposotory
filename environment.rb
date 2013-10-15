configure do 
  $: << File.expand_path(File.dirname(__FILE__)) + '/lib'
  Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

  require 'sinatra'
  require 'drink_repository'
  require 'spec_helper'
  require 'sinatra-activerecord'
  require 'sqlite3'
end

configure :test, :development do
   Repository.register(:drink, Drinks.new)
end

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "db.sqlite3"
)
