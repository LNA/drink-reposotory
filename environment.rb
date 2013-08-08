configure do 
  $: << File.expand_path(File.dirname(__FILE__)) + '/lib'
  Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

  require 'sinatra'
  require 'drink_repository'
  require 'spec_helper'
end

configure :test, :development do
   Repository.register(:drink, Drinks.new)
 end