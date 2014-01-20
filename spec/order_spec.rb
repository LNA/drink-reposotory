require 'spec_helper'

describe Order do 
    let(:guest_id) { 1 }
    let(:drink_id) { 1 }

    let(:guest_2_id) { 2 }
    let(:drink_2_id) { 2 }

    let (:params) { {:drink_id => drink_id,
                     :guest_id => guest_id,
                     :quantity => 0} }

    let (:order) {Order.new(params)}

  context '#initialize' do
    it 'creates a new order with guest parameters' do
      order.guest_id.should == guest_id
    end

    it 'creates a new order with drink parameters' do
      order.drink_id.should == drink_id
    end
  end


  context '#update' do 
    it 'updates the guest parameter' do 
      order.update(:guest_id => guest_2_id)
      order.guest_id.should == guest_2_id
    end

    it 'updates the drink parameter' do 
      order.update(:drink_id => drink_2_id)
      order.drink_id.should == drink_2_id
    end
  end

  context '#drink' do 
    it 'should return the drink for an order' do
      clear_records
      drink = new_test_drink
      guest = new_test_guest
      Repository.for(:order).save_new(drink.id, guest.id)
      order = Repository.for(:order).find_order(drink.id, guest.id)
    
      order.drink.should == drink
    end
  end
end