require 'spec_helper'
require 'drink'

describe Drink do 
	it "creates a new drink with params" do
		params = {:booze => 'vodka',
		           :mixer => 'water',
		           :glass => 'rocks'}
		drink1 = Drink.new(params)
		drink1.booze.should == 'vodka'
		drink1.mixer.should == 'water'
		drink1.glass.should == 'rocks'
	end
end
