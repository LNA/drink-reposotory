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

  # context '#orders' do
  #   it 'returns all orders for a guest' do

  #     guest.orders.should == #whatever orders you add in test setup
  #   end
  # end
end