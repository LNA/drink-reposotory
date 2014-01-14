require 'spec_helper'

describe Order do 
  before :each do
    @drink_1 = Drink.new
    @drink_2 = Drink.new
    @drink_datastore = Drinks.new
    @drink_datastore.save(@drink_1)
    @drink_datastore.save(@drink_2)

    @guest_1 = Guest.new
    @guest_2 = Guest.new
    @guest_datastore = Guests.new
    @guest_datastore.save(@guest_1)
    @guest_datastore.save(@guest_2)


    params = { :drink_id => @drink_1.id,
               :guest_id => @guest_1.id,
               :quantity => 0} 

    @order1 = Order.new(params)
  end
  
	it 'creates a new order with guest parameters' do
		@order1.guest_id.should == @guest_1.id
  end

  it 'creates a new order with drink parameters' do
    @order1.drink_id.should == @drink_1.id
  end

  context '#update' do 

    it 'updates the guest parameter' do 
      @order1.update(:guest_id => @guest_2.id)
      @order1.guest_id.should == @guest_2.id
    end

    it 'updates the drink parameter' do 
      @order1.update(:drink_id => @drink_2.id)
      @order1.drink_id.should == @drink_2.id
    end
  end
end