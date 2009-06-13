require File.dirname(__FILE__) + "/../../../spec_helper"
require 'redcloth/parser/attributes/class_id'

module RedCloth
  module Parser
    module Attributes
      describe ClassId do
        before :each do
          @parser = ClassIdParser.new
        end
  
        def parse(string)
          @parser.parse_or_fail(string)
        end
      
        it "should parse a css class" do
          parse("(myclass)").should_not be_nil
          parse("(myclass)").to_opts.should == {:class => "myclass"}
        end

        it "should parse css classes" do
          parse("(myclass otherclass)").should_not be_nil
          parse("(myclass otherclass)").to_opts.should == {:class => "myclass otherclass"}
        end

        it "should parse an id" do
          parse("(#myid)").should_not be_nil
          parse("(#myid)").to_opts.should == {:id => "myid"}
        end

        it "should parse a class and an id" do
          parse("(myclass#myid)").should_not be_nil
          parse("(myclass#myid)").to_opts.should == {:class => "myclass", :id => "myid"}
        end
      
        it "should parse multiple classes and an id" do
          parse("(myclass otherclass#myid)").should_not be_nil
          parse("(myclass otherclass#myid)").to_opts.should == {:class => "myclass otherclass", :id => "myid"}
        end
      
        it "should parse valid ids" do
          lambda { parse("(#my-id)") }.should_not raise_error
          lambda { parse("(#my_id)") }.should_not raise_error
          lambda { parse("(#my-id-9)") }.should_not raise_error
          lambda { parse("(#a44)") }.should_not raise_error
          lambda { parse("(#b)") }.should_not raise_error
        end
      
        it "should not parse invalid ids" do
          lambda { parse("(#my id)") }.should raise_error
          lambda { parse("(#my.id)") }.should raise_error
          lambda { parse("(#9myid)") }.should raise_error
          lambda { parse("(#-myid)") }.should raise_error
        end
      
        it "should parse valid classes" do
          lambda { parse("(my-class)") }.should_not raise_error
          lambda { parse("(my_class)") }.should_not raise_error
          lambda { parse("(my-class-7)") }.should_not raise_error
          lambda { parse("(q99)") }.should_not raise_error
          lambda { parse("(c)") }.should_not raise_error
        end
      
        it "should not parse invalid classes" do
          lambda { parse("(#my.class)") }.should raise_error
          lambda { parse("(#9myclass)") }.should raise_error
          lambda { parse("(#-myclass)") }.should raise_error
        end
      
      end
    end
  end
end