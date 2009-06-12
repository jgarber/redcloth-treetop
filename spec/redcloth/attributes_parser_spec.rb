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
      end

      it "should parse css classes" do
        parse("(myclass otherclass)").should_not be_nil
      end
      
    end

  end
end