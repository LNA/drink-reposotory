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
  	before(:each) do
  		@datastore = Drinks.new
  		@datastore.new_drink('something')
  		#@datastore.save('something')
  	end

	  it 'loads the new drink page' do
	  	get '/drinks/new'
	  	last_response.should be_ok
	  end

	  it "creates a new drink and sends it to the datastore" do
	  	Repository.should_receive(:for).and_return(@datastore)
	  	@datastore.should_receive(:new_drink).and_return('something')
	  	@datastore.should_receive(:save).and_return('something')
	  	# require 'pry'
	  	# binding.pry
	  	post '/drinks/new'
	  end
  end
end

