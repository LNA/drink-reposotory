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

    params = {:guest_id => @guest1.id,
              :drink_id => @drink1.id} 

    @order1 = Order.new(params)
  end
  
	it 'creates a new order with guest parameters' do
		@order1.guest_id.should == @guest1.id
  end

  it 'creates a new order with drink parameters' do
    @order1.drink_id.should == @drink1.id
  end

  context '#update' do 

    it 'updates the guest parameter' do 
      @order1.update(:guest_id => @guest2.id)
      @order1.guest_id.should == @guest2.id
    end

    it 'updates the drink parameter' do 
      @order1.update(:drink_id => @drink2.id)
      @order1.drink_id.should == @drink2.id
    end
  end
end