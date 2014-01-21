require 'spec_helper'
require 'mock_datastore'

describe 'Guest' do
  let (:params) { {:first_name => 'Jane',
                   :last_name => 'Doe'} }

  context '#initialize' do
    it 'creates a new guest with params' do 
      guest = Guest.new(params)

      guest.first_name.should == 'Jane'
      guest.last_name.should == 'Doe'
    end
  end

  context '#update' do 
    it 'updates the guest params' do
      guest = Guest.new(params)
      guest.update(:first_name => 'Jon',
                    :last_name => 'Dow')

      guest.first_name.should == 'Jon'
      guest.last_name.should == 'Dow'
    end
  end

  context '#orders' do
    it 'returns all orders for a guest' do
      clear_records
      drink = new_test_drink
      guest = new_test_guest
      Repository.for(:order).save_new(drink.id, guest.id)
      order = Repository.for(:order).find_order(drink.id, guest.id)
     
      guest.orders.should == order
    end
  end
end