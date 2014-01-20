require 'spec_helper'
describe 'Orders' do
    let (:drink_id)  { 1 }
    let (:guest_id)  { 1 }
    let (:datastore) {Orders.new}  

  context 'initialize' do

    it 'should intitialize with empty records' do
        datastore.records.should == {}
      end

    it 'should intialize with an id' do
      datastore.id.should == 1
    end
  end

  context 'save_new' do

    it "saves a new object in records by id" do 
      datastore.save_new(drink_id, guest_id)

      datastore.records[1].id.should == 1
    end 

    it 'increments the id for aditional objects saved' do
      datastore.save_new(drink_id, guest_id)
      datastore.save_new(drink_id, guest_id)

      datastore.records[2].id.should == 2
    end
  end

  context 'quantity' do

    it 'updates the quantity to one the first time a drink is ordered' do
      datastore.save_new(drink_id, guest_id)
    
      datastore.records[1].quantity.should == 1
    end

    it 'increases the quantity when ordering existing drink is reordered' do
      datastore.save_new(drink_id, guest_id)
      datastore.increase_quantity_by_one(drink_id, guest_id)

      datastore.records[1].quantity.should == 2
    end
  end

  context '#find_order' do 
    it 'returns the order based on the drink_id and guest_id' do
      datastore.save_new(drink_id, guest_id)
      order = datastore.find_order(1, 1)

      order.drink_id.should == 1
      order.guest_id.should == 1
    end
  end

  context 'updating an existing order' do
    it 'increments quantity by 1 when reordered' do
      datastore.save_new(drink_id, guest_id)


      datastore.increase_quantity_by_one(1,1)
      datastore.records[1].quantity.should == 2
    end
  end

  context 'void an existing order' do

    it 'deletes the order record if quantity is 1' do
      datastore.save_new(drink_id, guest_id)
      datastore.delete_order(drink_id, guest_id)

      datastore.records[1].should == nil
    end

    it 'reduces quantity by 1 if order quantity is greater than 1' do
      datastore.save_new(drink_id, guest_id)
      datastore.increase_quantity_by_one(drink_id, guest_id)
      datastore.delete_order(drink_id, guest_id)

      datastore.records[1].quantity.should == 1
    end
  end 
end