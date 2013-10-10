require 'spec_helper'
require 'guest'
require 'drink'
require 'repository'
require 'guests'
require 'mock_datastore'

describe 'Guest' do 
  before :each do
    @guest_datastore = Guests.new
    @guest_one_params = {:first_name => 'Bob',
              :last_name => 'West'}
    @guest1 = Guest.new(@guest_one_params)
    @guest_datastore.save(@guest1)
  end

  it 'creates a new guest with params' do
    @guest1.first_name.should == 'Bob'
    @guest1.last_name.should == 'West'              
  end

  context '#update' do
    it 'updates the guest last_name' do
      @guest1.update(:last_name => 'North')
      @guest1.last_name.should == 'North'
    end

    it 'udpates the drinks for a user if drink_id exists' do
      mock_datastore = MockDatastore.new
      mock_datastore.item = "some drink"
      Repository.should_receive(:for).and_return(mock_datastore)
      @guest1.update(:drink_id => 1)
      @guest1.drinks.first.should == 'some drink'
    end

    it 'does not change the drinks for a user if no drink_id exists' do
      @guest1.drinks << 'some drink'
      @guest1.update(:first_name => 'Willy')
      @guest1.drinks.should == ['some drink']
    end
  end
end