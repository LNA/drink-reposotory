require 'spec_helper'
require 'guest'

describe 'Guest' do  
  it "creates a new guest with params" do
    params = {:first_name => "Bob",
              :last_name => "West"}
    guest1 = Guest.new(params)
    guest1.first_name.should == "Bob"
    guest1.last_name.should == "West"              
  end

  it "updates the gues params" do
  end
end