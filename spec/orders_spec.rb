require 'spec_helper'

describe 'initializing the orders datastore' do
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



    order_1_params = {:drink_id => @drink_1.id,
                      :guest_id => @guest_1.id,
                      :quantity => 0}

    order_2_params = {:drink_id => @drink_2.id,
                      :guest_id => @guest_2.id,
                      :quantity => 0}

    order_3_params = {:drink_id => @drink_1.id,
                      :guest_id => @guest_2.id,
                      :quantity => 0}


    @order_1 = Order.new(order_1_params)
    @order_2 = Order.new(order_2_params)
    @order_3 = Order.new(order_3_params)

    @order_datastore = Orders.new
    @order_datastore.save(@order_1)
    @order_datastore.save(@order_2)
    @order_datastore.save(@order_3)
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
      @order_datastore.all.should == [@order_1, @order_2, @order_3]
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
      @order_datastore.all.should == [@order_2, @order_3]
    end
  end

  context '#find_order' do 
    it 'returns the order based on the drink_id and guest_id' do
      @order_datastore.find_order(1, 1).should == @order_1
      @order_datastore.find_order(2, 2).should == @order_2
      @order_datastore.find_order(1, 2).should == @order_3
    end
  end

  context 'saving an order' do
    it 'saves an order with a new drink_id' do
      @order_datastore.records[1].drink_id.should == 1
    end

    it 'saves an order with a new guest_id' do
      @order_datastore.records[1].guest_id.should == 1
    end

    it 'saves an order with a quantity of 1' do
      @order_datastore.records[1].quantity.should == 1
    end
  end

  context 'updating an existing order' do
    it 'when reordering an existing order it finds the existing one and increments quantity by 1' do
      # require 'pry'
      # binding.pry

      @order_datastore.increase_quantity_by_one(1,1)
      @order_datastore.records[1].quantity.should == 2

      @order_datastore.increase_quantity_by_one(2,2)
      @order_datastore.records[2].quantity.should == 2

      @order_datastore.increase_quantity_by_one(1,2)
      @order_datastore.records[3].quantity.should == 2
    end

    it 'decreases quantity by 1' do
      @order_datastore.decrease_quantity_by_one(1,1)
      @order_datastore.records[1].quantity.should == 0
    end

    it 'does not decrease the quantity if quantity is zero' do
      @order_datastore.decrease_quantity_by_one(1,1)
      @order_datastore.decrease_quantity_by_one(1,1)
      @order_datastore.records[1].quantity.should == 0
    end

    it 'when voiding an order of 1 it deletes the order record' do
    end
  end
end