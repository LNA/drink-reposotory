require 'spec_helper'


describe 'Guests' do 
  let (:datastore) {Guests.new}

  context '#initialize' do
    it 'should initialize the guests datastore' do
      datastore.records.should == {}
    end

    it 'should initialize with an id' do
      datastore.id.should == 1
    end
  end
end

describe 'the datastore methods' do

  before :each do
    @datastore = Guests.new

    @guest1 = Guest.new
    @datastore.save(@guest1)
    
    @guest2 = Guest.new
    @datastore.save(@guest2)
  end

  context '#save' do
    it 'saves a guest to the records with an id' do
      @datastore.records[1].should == @guest1
    end

    it 'sets the id on the guest that it saves' do
      @guest1.id.should == 1
    end

    it 'should advance the id after saving the guest' do
      @guest2.id.should == 2
    end

    it 'can save more than one guest' do
      @datastore.records[1].should == @guest1
      @datastore.records[2].should == @guest2
    end
  end

  context '#all' do
    it 'returns all guests' do
      @datastore.all.should == [@guest1, @guest2]
    end

    it 'returns an empty array if it has no guests' do
      @empty_datastore = Guests.new
      @empty_datastore.all.should == []
    end
  end

  context '#find_by_id' do
    it 'finds a record by the id' do
      @datastore.find_by_id(1).should == @guest1
    end
  end

  context '#delete_by_id' do
    it 'deletes a drink' do
      @datastore.delete_by_id(1)
      @datastore.all.should == [@guest2]
    end
  end
end