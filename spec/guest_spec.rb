require 'spec_helper'
require 'mock_datastore'

describe 'Guest' do
  let (:datastore) {Guests.new}
  let (:params) { {:first_name => 'Jane',
                   :last_name => 'Doe'} }

  it 'creates a new guest with params' do 
    guest_1 = Guest.new(params)

    guest_1.first_name.should == 'Jane'
    guest_1.last_name.should == 'Doe'
  end

  it 'updates the guest params' do
    guest_1 = Guest.new(params)
    guest_1.update(:first_name => 'Jon',
                  :last_name => 'Dow')

    guest_1.first_name.should == 'Jon'
    guest_1.last_name.should == 'Dow'
  end
end