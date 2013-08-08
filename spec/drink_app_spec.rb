require 'spec_helper'

describe DrinkApp do
  def app
    @app ||= DrinkApp
  end

  it 'loads home page' do
    get "/" 
    last_response.should be_ok
  end

  describe 'drinks/new' do
 
	  it 'loads the new drink page' do
	  	get '/drinks/new'
	  	last_response.should be_ok
	  end

	  it "sends a drink to the datastore" do
	  	datastore = Drinks.new
	  	Repository.should_receive(:for).and_return(@datastore)
	  	datastore.should_receive(:save)
	  	post '/drinks/new'
	  end
  end
end

