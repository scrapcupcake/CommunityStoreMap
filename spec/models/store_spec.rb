require 'spec_helper'

describe Store do

  before :all do
  end

  describe ".optimal_bounds" do
    Factory(:store)
    Factory(:store, :lat => 2.5, :lng => 2.5 )

    bounds = Store.optimal_bounds
  
    
    it "should exist" do
      bounds.should be
    end
    
    it "should have two items" do
      bounds.count.should == 2
    end
    
    it "should have 2.5 as n" do
      bounds[:ne][0].should == 2.5
    end
    
    it "should have 2.5 as east" do
      bounds[:ne][1].should == 2.5
    end
    
    it "should have 1.5 as s" do
      bounds[:sw][0].should == 1.5
    end
    
    it "should have 1.5 as w" do
      bounds[:sw][1].should == 1.5
    end
  end

  describe ".optimal_origin" do
    Factory(:store)
    Factory(:store, :lat => 2.5, :lng => 2.5 )
    origin = Store.optimal_origin
    it "should be [2.0,2.0]" do
      origin.should == [2.0,2.0]
    end
  end


end