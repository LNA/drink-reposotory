require 'spec_helper'

describe Drink do 
  let (:params) { {:booze => 'vodka',
                   :mixer => 'water',
                   :glass => 'rocks',
                   :name => 'drink1'}  }
  let (:drink1) {Drink.new(params)}

  it 'creates a new drink with params' do
    drink1.booze.should == 'vodka'
    drink1.mixer.should == 'water'
    drink1.glass.should == 'rocks'
  end

  it 'updates the booze paramater' do
    drink1.update(:booze => 'rum')
    drink1.booze.should == 'rum'
	end
end
