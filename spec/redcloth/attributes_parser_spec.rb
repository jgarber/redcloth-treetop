require File.dirname(__FILE__) + "/../spec_helper"
require 'redcloth/parser/attributes'

module RedCloth
  module Parser
    describe AttributesParser do
      before :each do
        @parser = AttributesParser.new
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
      
    end

  end
end