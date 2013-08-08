require 'spec_helper'
require 'drinks'

describe "the drinks datastore" do
	it "should intitialize with empty records" do
		datastore = Drinks.new
		datastore.records.should == {}
	end

	it "should intialize with an id" do
		datastore = Drinks.new
		datastore.id.should == 1
	end

	it "should save an object in the records with the id" do
		datastore = Drinks.new
		datastore.save("something")
		datastore.records[1].should == "something"
	end

	it "should advance the id after saving an object" do
		datastore = Drinks.new
		datastore.save("something")
		datastore.id.should == 2
	end

	it "can save more than one object" do
		datastore = Drinks.new
		datastore.save("something")
		datastore.save("something else")
		datastore.records[1].should == "something"
		datastore.records[2].should == "something else"
	end

	it "can create a new drink object" do
		datastore = Drinks.new
		datastore.new_drink('something')
		datastore.records[1].should == "something"
	end
end