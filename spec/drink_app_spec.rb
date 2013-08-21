require 'spec_helper'

describe DrinkApp do
  def app
    @app ||= DrinkApp
  end

  it 'loads home page' do
    get "/" 
    last_response.should be_ok
  end

  describe "get 'drinks/new' " do
    it 'loads the new drink page' do
      get '/drinks/new'
      last_response.should be_ok
    end
  end

  describe " get '/drinks' " do
    it "displays a list of all drinks" do
      get "/drinks"
      last_response.should be_ok
    end
  end

  describe "post '/drinks' " do
    it 'initializes a new drink' do
      Drink.should_receive(:new)
      post '/drinks'
    end

    it "sends a drink to the datastore" do
      Repository.should_receive(:for).and_return(:drink)
      post '/drinks'
    end

    it 'saves a new drink object to the datastore' do
      params = {:booze => 'vodka',
               :mixer => 'water',
               :glass => 'rocks'}
      @drink = Drink.new(params)
      Repository.for(:drink).save(@drink)
      post '/drinks'
    end

    it "returns the show page" do
      get '/drinks/show'
      last_response.should be_ok
    end
  end


  describe "get 'drinks/update " do
    it "returns the show page" do
      get 'drinks/update'
      last_response.should be_ok
    end
  end

  describe " get '/drinks/delete' " do
    it "loads the delete view" do
      get '/drinks/delete'
      last_response.should be_ok
    end
  end

  describe " get '/drink/:id' " do
    it "returns the drink id" do
      Repository.should_receive(:for).and_return(:id)
      get '/drink/:id'
    end
  end

  describe " get '/drink/:id/delete' " do
    it "deletes a drink" do
      Drink.should_receive(:delete)
      get '/drink/:id'
    end
  end
end