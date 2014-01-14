$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'
require 'sinatra/activerecord'
require 'repository'
require 'drinks'
require 'drink'
require './seed'
require 'guest'
require 'guests'
require 'orders'
require 'order'
require 'mock_datastore'

set :database, 'sqlite3:///drinks.db'

Repository.register(:drink, Drinks.new)
Repository.register(:guest, Guests.new)
Repository.register(:order, Orders.new) 

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
    find_drink_by_id
    erb '/drinks/show'.to_sym
  end

  put '/drink/:id' do
    find_drink_by_id
    @drink.update(params)
    erb 'drinks/show'.to_sym
  end

  get '/drink/:id/edit' do
    find_drink_by_id
    erb '/drinks/edit'.to_sym
  end

  get '/drink/:id/delete' do
    find_drink_by_id
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
    redirect '/guests'
  end

  get '/guests' do
    guest_datastore_instance = Repository.for(:guest) 
    @guests = guest_datastore_instance.all
    erb 'guests/index'.to_sym
  end

  get '/guest/:id' do
    find_guest_by_id
    drink_datastore_instance = Repository.for(:drink) 
    @drinks = drink_datastore_instance.all
    erb '/guests/show'.to_sym
  end

  put '/guest/:id' do
    find_guest_by_id
    @guest.update(params)
    redirect "/guest/#{@guest.id}"
  end

  get '/guest/:id/edit' do
    find_guest_by_id
    erb '/guests/edit'.to_sym
  end

  delete '/guest/:id' do
    id = params[:id].to_i
    @guest = Repository.for(:guest).delete_by_id(id)
    redirect '/guests'
  end

  get '/guest/:id/delete' do
    find_guest_by_id
    erb 'guests/delete'.to_sym
  end

  put '/orders/:guest_id/:drink_id' do
    guest_id = params[:guest_id]
    drink_id = params[:drink_id]

    @order = Order.new(params)
    @order.quantity += 1

    Repository.for(:order).save(@order) 

    redirect "/guest/#{guest_id}"
  end

  delete '/orders/:guest_id/:drink_id' do
    guest_id = params[:guest_id]
    drink_id = params[:drink_id]

    @order = Repository.for(:order).find_order(drink_id, guest_id)

    check_and_decrease_quantity

    redirect "/guest/#{guest_id}"
  end

  private

  def find_drink_by_id
    id = params[:id].to_i
    @drink = Repository.for(:drink).find_by_id(id)
  end

  def find_guest_by_id
    id = params[:id].to_i
    @guest = Repository.for(:guest).find_by_id(id)
  end

  def check_and_increase_quantity
    if @order.quantity >= 1
      @order.quantity += 1
    end
  end

  def check_and_decrease_quantity
    if @order.quantity == 1
      delete_order(drink_id, guest_id)
    else
      @order.quantity -= 1
    end
  end
end