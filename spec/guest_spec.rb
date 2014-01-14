require 'spec_helper'
require 'mock_datastore'

describe 'Guest' do 
  before :each do
    @guest_datastore = Guests.new
    @guest_one_params = {:first_name => 'Jane',
                         :last_name => 'Doe'}
    @guest1 = Guest.new(@guest_one_params)
    @guest_datastore.save(@guest1)
  end

  it 'creates a new guest with params' do
    @guest1.first_name.should == 'Jane'
    @guest1.last_name.should == 'Doe'              
  end

  context '#update' do
    it 'updates the guest last_name' do
      @guest1.update(:last_name => 'North')
      @guest1.last_name.should == 'North'
    end
  end
end