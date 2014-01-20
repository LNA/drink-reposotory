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

  context '#drinks' do
    it 'returns the drinks for a guest' do
      guest = Guest.new
      Repository.for(:guest).save(guest)

      drink = Drink.new
      Repository.for(:drink).save(drink)

      Repository.for(:order).save_new(drink.id, guest.id)
      
      guest.drinks.should == [drink]
    end
  end
end