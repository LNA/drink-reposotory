require 'spec_helper'

describe 'Drinks' do
  let (:datastore) {Drinks.new}
  let (:drink_1)   {Drink.new} 
  let (:drink_2)   {Drink.new}

  context '#initialize' do
    it 'should intitialize with empty records' do
      datastore.records.should == {}
    end

    it 'should intialize with an id' do
      datastore.id.should == 1
    end
  end

  context '#save' do
    it 'saves a drink in the records with the id' do
      datastore.save(drink_1)

      datastore.records[1].should == drink_1
    end

    it 'sets the id on the drink that it saves' do
      datastore.save(drink_1)

      datastore.records[1].id.should == drink_1.id
    end

    it 'increments the id by 1 after saving a drink' do
      datastore.save(drink_1)
      datastore.save(drink_2)

      datastore.records[2].id.should == drink_2.id
    end

    it 'can save more than one drink' do
      datastore.save(drink_1)
      datastore.save(drink_2)

      datastore.records[2].should == drink_2
    end
  end

  context '#all' do
    it 'returns all drinks' do
      datastore.save(drink_1)
      datastore.save(drink_2)

      datastore.all.should == [drink_1, drink_2]
    end

    it 'returns an empty array if it has no drinks' do
      datastore.all.should == []
    end
  end

  context '#find_by_id' do
    it 'finds a record by the id' do
      datastore.save(drink_1)

      datastore.find_by_id(1).should == drink_1
    end
  end

  context '#delete_by_id' do
    it 'deletes a drink' do
      datastore.save(drink_1)
      datastore.save(drink_2)
      datastore.delete_by_id(1)

      datastore.all.should == [drink_2]
    end
  end
end