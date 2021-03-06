require File.dirname(__FILE__) + "/../../spec_helper"
require 'redcloth/parser/common'

module RedCloth
  module Parser
    describe CommonParser do
      
      before :each do
        @parser = CommonParser.new
      end
      
      def parse(string)
        @parser.parse_or_fail(string)
      end
      
      describe "mspace rule" do
        before(:each) { @parser.root = :mspace }
        
        it "should parse space" do
          lambda { parse(" ") }.should_not raise_error
        end
        it "should parse tab" do
          lambda { parse("\t") }.should_not raise_error
        end
        it "should parse space tab" do
          lambda { parse(" \t") }.should_not raise_error
        end
        
        it "should not parse double newline" do
          lambda { parse("\n\n") }.should raise_error(RedCloth::Parser::SyntaxError)
        end
        
      end
      
    end
  end
end