require 'spec_helper'
require 'orders'
require 'order'
require 'drink'
require 'guest'

describe 'initializing the orderss datastore' do
  before :each do
    @datastore = Orders.new
  end

  context '#initialize' do
    it 'should intitialize with empty records' do
      @datastore.records.should == {}
    end

    it 'should intialize with an id' do
      @datastore.id.should == 1
    end
  end
end

describe 'the orders datastore methods' do  
  before :each do
    drink_1_params = {:booze => 'Rye',
                      :mixer => 'absinthe',
                      :glass => 'rocks',
                      :name =>  'Sazerac'}
    @drink_1 = Drink.new(drink_1_params)

    drink_2_params = {:booze => 'Gin',
                      :mixer => 'Campari',
                      :glass => 'rocks',
                      :name =>  'Negroni'}
    @drink_2 = Drink.new(drink_2_params)

    @drink_1_datastore = Drinks.new
    @drink_1_datastore.save(@drink_1)
    @drink_1_datastore.save(@drink_2)
    
    guest_1_params = {:first_name => 'Jane',
                      :last_name => 'Doe'}
    @guest_1 = Guest.new(guest_1_params)

    guest_2_params = {:first_name => 'Jon',
                      :last_name => 'Doe'}
    @guest_2 = Guest.new(guest_2_params)


    @guest_1_datastore = Guests.new
    @guest_1_datastore.save(@guest_1)

    @guest_2_datastore = Guests.new
    @guest_2_datastore.save(@guest_2)



    order_1_params = {:drink => @drink_1_datastore,
                     :guest => @guest_1_datastore}

    order_2_params = {:drink => @drink_2_datastore,
                     :guest => @guest_2_datastore}


    @order_1 = Order.new(order_1_params)
    @order_2 = Order.new(order_2_params)

    @order_datastore = Orders.new
    @order_datastore.save(@order_1)
    @order_datastore.save(@order_2)

    @single_order_datastore = Orders.new
    @single_order_datastore.save(@order_1)
  end

  context '#save' do  
    it 'saves an object in the records with the id' do
      expected_record_id = 1
      @order_datastore.records[expected_record_id].should == @order_1
    end

    it 'sets the id on the order that it saves' do 
      @order_1.id.should == 1
    end

    it 'increments the id by 1 after saving an order' do
      @order_2.id.should == 2
    end

    it 'can save more than one order' do
      @order_datastore.records[1].should == @order_1
      @order_datastore.records[2].should == @order_2
    end
  end

  context '#all' do 
    it 'returns all orders' do
      @order_datastore.all.should == [@order_1, @order_2]
    end

    it 'returns an empty array if it holds no orders' do
      @empty_datastore = Orders.new
      @empty_datastore.all.should == []
    end
  end

  context '#find_by_id' do 
    it 'finds a record by the id' do 
      @order_datastore.find_by_id(1).should == @order_1
    end
  end

  context '#delete_by_id' do
    it 'deletes an order' do 
      @order_datastore.delete_by_id(1)
      @order_datastore.all.should == [@order_2]
    end
  end

  context '#guest_id'
  it 'returns an orders guest id' do 
    @order_datastore.guest_id(@order_1).should == 1
  end


  context '#drink_id' do
    it 'returns the drink id of an order' do 
      @order_datastore.drink_id(@order_1).should == 1
    end
  end

  context '#find_order' do 
    it 'returns the order based on the drink_id and guest_id' do
      require 'pry'
      binding.pry
      @order_datastore.find_order(1, 2).should == @order_1
    end
  end
end
