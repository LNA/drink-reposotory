require 'spec_helper'

describe Order do 
    let (:guest_id) { 1 }
    let (:drink_id) { 1 }

    let(:guest_2_id) { 2 }
    let(:drink_2_id) { 2 }

    let (:params) { {:drink_id => drink_id,
                    :guest_id =>  guest_id,
                    :quantity => 0} }

    let(:order1) {Order.new(params)}
 
  
	it 'creates a new order with guest parameters' do
		order1.guest_id.should == guest_id
  end

  it 'creates a new order with drink parameters' do
    order1.drink_id.should == drink_id
  end

  context '#update' do 

    it 'updates the guest parameter' do 
      order1.update(:guest_id => guest_2_id)
      order1.guest_id.should == guest_2_id
    end

    it 'updates the drink parameter' do 
      order1.update(:drink_id => drink_2_id)
      order1.drink_id.should == drink_2_id
    end
  end

  # context '#drink' do 
  #   it 'should return the drink for an order' do
  #     #test setup
  #     order1.drink.should == @drink1
  #   end
  # end
end