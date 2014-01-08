require 'spec_helper'
require 'order'

describe Order do 
  before :each do
    drink_params = {:booze => 'vodka',
                    :mixer => 'water',
                    :glass => 'rocks',
                    :name => 'drink1'}
    @drink1 = Drink.new(drink_params)

    drink2_params = {:booze => 'vodka',
                    :mixer => 'water',
                    :glass => 'rocks',
                    :name => 'drink1'}
    @drink2 = Drink.new(drink2_params)

    @guest_params = {:first_name => 'Bob',
                     :last_name => 'West'}
    @guest1 = Guest.new(@guest_params)

    @guest2_params = {:first_name => 'Jane',
                     :last_name => 'Doe'}
    @guest2 = Guest.new(@guest2_params)

    params = {:guest => @guest1 ,
              :drink => @drink1}
    @order1 = Order.new(params)
  end
  
	it 'creates a new order with guest parameters' do
		@order1.guest.should == @guest1
  end

  it 'creates a new order with drink parameters' do
    @order1.drink.should == @drink1
  end

  context '#update' do 

    it 'updates the guest parameters' do 
      @order1.update(:guest => @guest2)
      @order1.guest.should == @guest2
    end

    it 'updates the drink parameters' do 
      @order1.update(:drink => @drink2)
      @order1.drink.should == @drink2
    end
  end
end