require 'spec_helper'

describe DrinkApp do
  def app
    @app ||= DrinkApp
  end

  it 'loads home page' do
    get "/" 
    last_response.should be_ok
  end

  describe "creating a drink " do
    it 'loads the new drink page' do
      get '/drinks/new'
      last_response.should be_ok
    end

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

    it "returns the drink id" do
      params = {:booze => 'vodka',
               :mixer => 'water',
               :glass => 'rocks'}
      @drink = Drink.new(params)
      Repository.for(:drink).save(@drink)
      get '/drink/1'
      last_response.should be_ok
    end
  end

  describe "Reading the drinks " do
    it "displays a list of all drinks" do
      get "/drinks"
      last_response.should be_ok
    end
  end

  describe "updating a drink" do
    before :each do
      params = {:booze => 'vodka',
               :mixer => 'water',
               :glass => 'rocks',
               :name =>  'drink1'}
      @drink = Drink.new(params)
      Repository.for(:drink).save(@drink)
    end

    it "fetches the drink to update from the repository" do
      Repository.for(:drink).should_receive(:find_by_id).with(1)
      put "drink/1"
    end

    it "updates a specific drink" do
      params = {"booze"=>"rum", "splat"=>[], "captures"=>["#{@drink.id}"], "id"=>"#{@drink.id}"}
      @drink.should_receive(:update).with(params)
      put "drink/#{@drink.id}", params
    end

    it "renders the show page after updating a drink" do
      put "drink/#{@drink.id}"
      last_response.should be_ok
    end
  end

  describe "deleting a drink" do
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
end