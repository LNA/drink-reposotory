require 'spec_helper'
require 'orders'
require 'order'

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
    @datastore = Orders.new
    params = {:booze => 'vodka',
              :mixer => 'water',
              :glass => 'rocks',
              :name =>  'drink1'}
    @order_1 = Order.new(params)
    @datastore.save(@order_1)
    @order_2 = Order.new(params)
    @datastore.save(@order_2)
  end

  context '#save' do  
    it 'saves an object in the records with the id' do
      @datastore.records[1].should == @order_1
    end

    it 'sets the id on the order that it saves' do 
      @order_1.id.should == 1
    end

    it 'increments the id by 1 after saving a drink' do
      @order_2.id.should == 2
    end

    it 'can save more than one drink' do
      @datastore.records[1].should == @order_1
      @datastore.records[2].should == @order_2
    end
  end

  context '#all' do 
    it 'returns all orders' do
      @datastore.all.should == [@order_1, @order_2]
    end

    it 'returns an empty array if it holds no orders' do
      @empty_datastore = Orders.new
      @empty_datastore.all.should == []
    end
  end

  context '#find_by_id' do 
    it 'finds a record by the id' do 
      @datastore.find_by_id(1).should == @order_1
    end
  end

  context '#delete_by_id' do
    it 'deletes an order' do 
      @datastore.delete_by_id(1)
      @datastore.all.should == [@order_2]
    end
  end
end
