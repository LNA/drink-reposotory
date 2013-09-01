require 'spec_helper'
require 'guest'

describe 'Guest' do 
  before :each do
    params = {:first_name => "Bob",
              :last_name => "West"}
    @guest1 = Guest.new(params)
  end

  it "creates a new guest with params" do
    @guest1.first_name.should == "Bob"
    @guest1.last_name.should == "West"              
  end

  it "updates the guest params" do
    @guest1.update(:last_name => "North")
    @guest1.last_name.should == "North"
  end
end