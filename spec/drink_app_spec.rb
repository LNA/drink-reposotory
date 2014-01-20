require 'spec_helper'
require 'mock_datastore'

describe DrinkApp do
  
  before :each do
    @drink = Drink.new
    Repository.for(:drink).save(@drink)

    @guest = Guest.new
    Repository.for(:guest).save(@guest)
  end

  def app
    @app ||= DrinkApp
  end

  context 'the home page' do
    it 'loads home page' do
      get "/" 
      last_response.should be_ok
    end
  end

  context 'drinks' do
    it 'displays the form for creating new drinks' do
      get '/drinks/new'
      last_response.should be_ok
    end

    it 'creates a new drink object' do
      Drink.should_receive(:new)
      post '/drinks'
    end

    it 'sends a new drink object to the datastore' do
      mock = MockDatastore.new
      Repository.should_receive(:for).and_return(mock)
      post '/drinks', @params
      mock.item.booze == 'vodka'
    end

    it 'displays a list of all drinks' do
      get '/drinks'
      last_response.should be_ok
    end
  end

  context 'drink' do
    it 'returns the drink id' do
      Repository.for(:drink).save(@drink)
      get '/drink/1'
      last_response.should be_ok
    end

    it 'fetches the drink to update from the repository' do
      Repository.for(:drink).should_receive(:find_by_id).with(1)
      put "drink/1"
    end

    it 'updates a specific drink' do
      params = {"booze"=>"rum", "splat"=>[], "captures"=>["#{@drink.id}"], "id"=>"#{@drink.id}"}
      @drink.should_receive(:update).with(params)
      put "drink/#{@drink.id}", params
    end

    it 'renders the show page after updating a drink' do
      put "drink/#{@drink.id}"
      last_response.should be_ok
    end

    it 'loads a specific drink for the delete view' do
      Repository.for(:drink).should_receive(:find_by_id).with(@drink.id)
      get "drink/#{@drink.id}/delete"
    end

    it 'succesfully renders the show page' do
      get "drink/#{@drink.id}/delete"
      last_response.should be_ok
    end

    it 'deletes the drink by id' do
      delete "/#{@drink.id}"
      Repository.for(:drink).find_by_id(@drink.id).should == nil
    end

    it 'succesfully redirects to the drink index page after delete' do
      delete "/#{@drink.id}"
      last_response.should be_redirect
    end
  end

  context 'guests' do 

    before :each do
      @params = {:first_name => 'Jay',
               :last_name => 'Crew'}
      @guest = Guest.new(@params)
    end

    it 'displays the new guest page' do
      get '/guests/new'
      last_response.should be_ok
    end

    it 'creates a new guest object' do
      Guest.should_receive(:new)
      post '/guests'
    end
  
    it 'sends a new guest object to the datastore' do
      mock = MockDatastore.new
      Repository.should_receive(:for).and_return(mock)
      post '/guests', @params
      mock.item.first_name.should == 'Jay'
    end

    it 'saves a new guest object to the datastore' do
      Repository.for(:guest).save(@guest)
      post '/guests'
    end

    it 'displays a list of all guests' do
      get '/guests'
      last_response.should be_ok
    end
  end

  context 'guest' do 
    it 'returns the guest id' do
      Repository.should_receive(:for).and_return(:id)
      post '/guests'
    end

    it 'fetches the guest to update from the repository' do
      Repository.for(:guest).should_receive(:find_by_id).with(1)
      put "guest/1"
    end

    it 'updates a specific guest' do
      params = {"first_name" =>"Cindy", "splat"=>[], "captures"=>["#{@guest.id}"], "id"=>"#{@guest.id}"}
      @guest.should_receive(:update).with(params)
      put "guest/#{@guest.id}", params
    end

    it 'renders the show page after updating a guest' do
      put "guest/#{@guest.id}"
      last_response.should be_redirect
    end

    it 'loads a specific guest for the delete view' do
      Repository.for(:guest).should_receive(:find_by_id).with(@guest.id)
      get "guest/#{@guest.id}/delete"
    end

    it 'sucessfully renders the delete page' do
      get "guest/#{@guest.id}/delete"
      last_response.should be_ok
    end

    it 'deletes a guest by id' do
      delete "guest/#{@guest.id}"
      Repository.for(:guest).find_by_id(@guest.id).should == nil
    end

    it 'successfully redirects to the guest index page after delete' do
      delete "guest/#{@guest.id}"
      last_response.should be_redirect
    end

    context 'orders' do 
      before :each do
        Repository.for(:order).records = {}
        Repository.for(:order).id = 1
      end

      it 'creates an order' do
        Repository.for(:order).records = {}
        put "orders/#{@guest.id}/#{@drink.id}"
        order = Repository.for(:order).records[1]
        order.drink_id.should == @drink.id
        order.guest_id.should == @guest.id
      end

      it 'updates the quantity as 1 the first time a drink is ordered' do
        put "orders/#{@guest.id}/#{@drink.id}"
        order = Repository.for(:order).records[1]
        order.quantity.should == 1
      end

      it 'updates the quantity by 1 the second time a drink is ordered' do
        put "orders/#{@guest.id}/#{@drink.id}"
        put "orders/#{@guest.id}/#{@drink.id}"
        
        order = Repository.for(:order).records[1]

        order.quantity.should == 2
      end

      it 'deletes a guests drink if quantity was 1' do
        params = {:drink_id => @drink.id, :guest_id => @guest.id}
        order = Order.new(params)
        Repository.for(:order).save_new(order.drink_id, order.guest_id)

        delete "/orders/#{@guest.id}/#{@drink.id}"
  
        Repository.for(:order).records[1].should == nil
      end
    end
  end
end