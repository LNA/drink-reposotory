require 'spec_helper'
require 'drinks'
require 'drink'

describe "the drinks datastore" do
  before :each do
    @datastore = Drinks.new
  end

  context "#initialize" do
    it "should intitialize with empty records" do
      @datastore.records.should == {}
    end

    it "should intialize with an id" do
      @datastore.id.should == 1
    end
  end
end

describe "the drinks datastore methods" do
  before :each do
    @datastore = Drinks.new
    params = {:booze => 'vodka',
                   :mixer => 'water',
                   :glass => 'rocks',
                   :name =>  'drink1'}
    @drink1 = Drink.new(params)
    @datastore.save(@drink1)
    @drink2 = Drink.new(params)
    @datastore.save(@drink2)
  end

  context "#save" do
    it "should save an object in the records with the id" do
      @datastore.records[1].should == @drink1
    end

    it "sets the id on the object that it saves" do
      @drink1.id.should == 1
    end

    it "should advance the id after saving an object" do
      @drink2.id.should == 2
    end

    it "can save more than one object" do
      @datastore.records[1].should == @drink1
      @datastore.records[2].should == @drink2
    end
  end

  context "#all" do
    it "returns all drinks" do
      @datastore.all.should == [@drink1, @drink2]
    end

    it "returns an empty array if it has no drinks" do
      @empty_datastore = Drinks.new
      @empty_datastore.all.should == []
    end
  end

  context "#find_by_id" do
    it "finds a record by the id" do
      @datastore.find_by_id(1).should == @drink1
    end
  end

  context "#delete_by_id" do
    it "deletes a drink" do
      @datastore.delete_by_id(1)
      @datastore.all.should == [@drink2]
    end
  end
end