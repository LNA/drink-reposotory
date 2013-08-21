require 'spec_helper'
require 'drinks'
require 'drink'

describe "the drinks datastore" do
  before :each do
    @datastore = Drinks.new
  end

  it "should intitialize with empty records" do
    @datastore.records.should == {}
  end

  it "should intialize with an id" do
    @datastore.id.should == 1
  end

  it "should save an object in the records with the id" do
    @datastore.save("something")
    @datastore.records[1].should == "something"
  end

  it "should advance the id after saving an object" do
    @datastore.save("something")
    @datastore.id.should == 2
  end

  it "can save more than one object" do
    @datastore.save("something")
    @datastore.save("something else")
    @datastore.records[1].should == "something"
    @datastore.records[2].should == "something else"
  end

  it "returns all drinks" do
    @datastore.save("one")
    @datastore.save("two")
    @datastore.all.should == ["one", "two"]
  end

  it "returns an empty array if it has no drinks" do
    @datastore.all.should == []
  end

  it "finds a record by the id" do
    @datastore.save("stuff")
    @datastore.find_by_id(1).should == "stuff"
  end

  it "sets the id on the object that it saves" do
    params = {:booze => "vodka",
              :mixer => 'water',
              :glass => 'rocks'
    }
    drink1 = Drink.new(params)

    @datastore.save(drink1)

    drink1.id.should == 1
  end

  it "deletes a drink" do
    params = {:booze => "vodka",
              :mixer => 'water',
              :glass => 'rocks',
              :name => 'my drink'
    }
    drink1 = Drink.new(params)
    @datastore.save(drink1)
    @datastore.delete_by_id(1)
    @datastore.records.should == {}
  end
end