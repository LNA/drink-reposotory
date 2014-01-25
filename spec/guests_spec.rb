require 'spec_helper'


describe 'Guests' do 
  let (:datastore) {Guests.new}
  let (:guest1) {Guest.new}
  let (:guest2) {Guest.new}

  context '#initialize' do
    it 'should initialize the guests datastore' do
      datastore.records.should == {}
    end

    it 'should initialize with an id' do
      datastore.id.should == 1
    end
  end

  context '#save' do
    it 'saves a guest to the records with an id' do
      datastore.save(guest1)

      datastore.records[1].should == guest1
    end

    it 'sets the id on the guest that it saves' do
      datastore.save(guest1)

      guest1.id.should == 1
    end

    it 'should advance the id after saving the guest' do
      datastore.save(guest1)
      datastore.save(guest2)

      guest2.id.should == 2
    end

    it 'can save more than one guest' do
      datastore.save(guest1)
      datastore.save(guest2)

      datastore.records[1].should == guest1
      datastore.records[2].should == guest2
    end
  end

  context '#all' do
    it 'returns all guests' do
      datastore.save(guest1)
      datastore.save(guest2)

      datastore.all.should == [guest1, guest2]
    end

    it 'returns an empty array if it has no guests' do
      datastore.all.should == []
    end
  end

  context '#find_by_id' do
    it 'finds a record by the id' do
      datastore.save(guest1)

      datastore.find_by_id(1).should == guest1
    end
  end

  context '#delete_by_id' do
    it 'deletes a drink' do
      datastore.save(guest1)
      datastore.save(guest2)
      datastore.delete_by_id(1)

      datastore.all.should == [guest2]
    end
  end
end