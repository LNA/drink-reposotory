require 'spec_helper'
require 'drink'

describe Drink do 
  before :each do
    params = {:booze => 'vodka',
              :mixer => 'water',
              :glass => 'rocks',
              :name => 'drink1'}
    @drink1 = Drink.new(params)
  end

  it 'creates a new drink with params' do
    @drink1.booze.should == 'vodka'
    @drink1.mixer.should == 'water'
    @drink1.glass.should == 'rocks'
  end

  it 'updates the booze paramater' do
    require 'pry'
    binding.pry
    @drink1.update(:booze => 'rum')
    @drink1.booze.should == 'rum'
	end
end
