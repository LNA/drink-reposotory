context 'save_new' do
  it "saves a new object in records by id" do 
    drink_id = 1
    guest_id = 2

    datastore = Orders.new
    datastore.save_new(drink_id, guest_id)
    datastore.records[1].id.should == 1
  end 
end

