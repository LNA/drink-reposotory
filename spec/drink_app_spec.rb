require 'spec_helper'
require 'mock_datastore'

describe DrinkApp do
  def app
    @app ||= DrinkApp
  end

  it 'loads home page' do
    get "/" 
    last_response.should be_ok
  end

  describe 'Creating a drink' do

    before :each do
      @params = {:booze => 'vodka',
               :mixer => 'water',
               :glass => 'rocks',
               :name =>  'drink1'}
      @drink = Drink.new(@params)
    end

    it 'loads the new drink page' do
      get '/drinks/new'
      last_response.should be_ok
    end

    it 'initializes a new drink' do
      Drink.should_receive(:new)
      post '/drinks'
    end

    it 'sends a drink to the datastore' do
      mock = MockDatastore.new
      Repository.should_receive(:for).and_return(mock)
      post '/drinks', @params
      mock.item.booze == 'vodka'
    end

    it 'returns the drink id' do
      Repository.for(:drink).save(@drink)
      get '/drink/1'
      last_response.should be_ok
    end
  end

  describe 'Reading the drinks' do
    it "displays a list of all drinks" do
      get "/drinks"
      last_response.should be_ok
    end
  end

  describe 'Updating a drink' do
    before :each do
      params = {:booze => 'vodka',
               :mixer => 'water',
               :glass => 'rocks',
               :name =>  'drink1'}
      @drink = Drink.new(params)
      Repository.for(:drink).save(@drink)
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
  end

  describe 'Deleting a drink' do
    before :each do
      params = {:booze => 'vodka',
               :mixer => 'water',
               :glass => 'rocks'}
      @drink = Drink.new(params)
      Repository.for(:drink).save(@drink)
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

  describe 'Creating a guest' do 

    before :each do
      @params = {:first_name => 'Jay',
               :last_name => 'Crew'}
      @guest= Guest.new(@params)
    end

    it 'loads the new guest page' do
      get '/guests/new'
      last_response.should be_ok
    end

    it 'initializes a new guest' do
      Guest.should_receive(:new)
      post '/guests'
    end
  
    it 'sends a guest to the datastore' do
      mock = MockDatastore.new
      Repository.should_receive(:for).and_return(mock)
      post '/guests', @params
      mock.item.first_name.should == 'Jay'
    end

    it 'saves a new guest object to the datastore' do
      Repository.for(:guest).save(@guest)
      post '/guests'
    end

    it 'returns the guest id' do
      Repository.should_receive(:for).and_return(:id)
      post '/guests'
    end
  end

  describe 'Reading all guests' do
    it 'displays a list of all drinks' do
      get '/guests'
      last_response.should be_ok
    end
  end

  describe 'Updating a guest' do

    before :each do
      params = {:first_name => 'Jay',
               :last_name => 'Crew'}
      @guest= Guest.new(params)
      Repository.for(:guest).save(@guest)
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

    it 'adds a drink to a guest' do
    end
  end

  describe 'Deleting a guest' do

    before :each do
      params = {:first_name => 'Jay',
               :last_name => 'Crew'}
      @guest= Guest.new(params)
      Repository.for(:guest).save(@guest)
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
  end
end