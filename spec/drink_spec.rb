require 'spec_helper'
require 'drink'

describe Drink do 
	it "creates a new drink with params" do
		drink1 = Drink.new(:glass => 'Rocks')
		# require 'pry'
		# binding.pry
		Drink.should_receive(:new).with(:some_params) #code to post to drinks/new with :some_params
	end
	
	it "sends the newly created drink to the Repository" do
	  Drink.should_receive(:new).and_return("something")
	  Repository.for(:drink).records[1].should == "something"
	end
end
