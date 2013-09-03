$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'
require 'repository'
require 'drinks'
require 'drink'
require './seed'
require 'guest'
require 'guests'

Repository.register(:drink, Drinks.new)
Repository.register(:guest, Guests.new)

Seed.drinks
Seed.guests

class DrinkApp < Sinatra::Application
  get '/' do
    'Welcome to Drink App.'
  end

  get '/drinks/new' do
    erb '/drinks/new'.to_sym
  end

  post '/drinks' do
    @drink = Drink.new(params)
    Repository.for(:drink).save(@drink) 
    erb '/drinks/show'.to_sym
  end

  get '/drinks' do 
    drink_datastore_instance = Repository.for(:drink) 
    @drinks = drink_datastore_instance.all
    erb 'drinks/index'.to_sym
  end

  get '/drink/:id' do
    id = params[:id].to_i
    @drink = Repository.for(:drink).find_by_id(id)
    erb '/drinks/show'.to_sym
  end

  put '/drink/:id' do
    id = params[:id].to_i
    @drink = Repository.for(:drink).find_by_id(id)
    @drink.update(params)
    erb 'drinks/show'.to_sym
  end

  get '/drink/:id/edit' do
    id = params[:id].to_i
    @drink = Repository.for(:drink).find_by_id(id)
    erb '/drinks/edit'.to_sym
  end

  get '/drink/:id/delete' do
    id = params[:id].to_i
    @drink = Repository.for(:drink).find_by_id(id)
    erb 'drinks/delete'.to_sym
  end

  delete '/:id' do
    id = params[:id].to_i
    @drink = Repository.for(:drink).delete_by_id(id)
    redirect '/drinks'
  end

  get '/guests/new' do
    erb '/guests/new'.to_sym
  end

  post '/guests' do
    @guest = Guest.new(params)
    Repository.for(:guest).save(@guest) 
    erb '/guests/show'.to_sym
  end

  get '/guests' do
    guest_datastore_instance = Repository.for(:guest) 
    @guests = guest_datastore_instance.all
    erb 'guests/index'.to_sym
  end

  put '/guest/:id' do
    id = params[:id].to_i
    @guest = Repository.for(:guest).find_by_id(id)
    @guest.update(params)
    erb 'guests/show'.to_sym
  end

  get '/guest/:id/edit' do
    id = params[:id].to_i
    @guest = Repository.for(:guest).find_by_id(id)
    erb '/guests/edit'.to_sym
  end

  delete '/guest/:id' do
    id = params[:id].to_i
    @guest = Repository.for(:guest).delete_by_id(id)
    redirect '/guests'
  end

  get '/guest/:id/delete' do
    id = params[:id].to_i
    @guest = Repository.for(:guest).find_by_id(id)
    erb 'guests/delete'.to_sym
  end


end