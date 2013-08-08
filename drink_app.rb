$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'
require 'repository'
require 'drinks'
require 'spec_helper'


Repository.register(:drink, Drinks.new)


class DrinkApp < Sinatra::Application
  get '/' do
    "Hello World"
  end

  get "/drinks/new" do
    @drink = Repository.register(:drink, Drinks.new)
    erb '/drinks/new'.to_sym
  end

  post "/drinks" do
    @drink = Repository.for(:drink).save(Repository.for(:drink))
    erb '/drinks/new'.to_sym
  end


  # get '/drinks' do
  #   @drinks = DrinkRepository.for(:drink).all

  #   erb 'drinks/index'.to_sym
  # end

  # get '/drink/:id' do
  #   @drink = DrinkRepository.for(:drink).find_by_id(:id)

  #   erb '/drinks/show'.to_sym
  # end

  # get '/drink/:id/delete' do
  #   @drink = DrinkRepository.for(:drink).find_by_id(:id)

  #   erb 'drinks/delete'.to_sym
  # end

  # delete '/drink/:id/delete' do
  #   @drink = DrinkRepository.for(:drink).find_by_id(:id)
  #   @drink.destroy 
  # end

end