require File.dirname(__FILE__) + "/../../spec_helper"
require 'redcloth/parser'

module RedCloth
  module Parser
    describe TextileDocParser do
      before :each do
        @parser = TextileDocParser.new
      end
  
      def parse(string)
        @parser.parse_or_fail(string)
      end
  
      it 'should parse an implicit paragraph' do
        parse("This is my paragraph\n\n").to_sexp.should ==
          [[:paragraph, {}, ["This is my paragraph"]]]
      end
  
      it 'should parse an explicit paragraph' do
        parse("p. This is my paragraph\n\n").to_sexp.should ==
          [[:paragraph, {}, ["This is my paragraph"]]]
      end
  
      it 'should parse an explicit paragraph without double newline after' do
        parse("p. This is my paragraph").to_sexp.should ==
          [[:paragraph, {}, ["This is my paragraph"]]]
      end
        
      it "should parse a basic list followed by double newline" do
        parse("# one\n# two\n\n").to_sexp.should ==
          [[:list, {}, [
            [:list_item, {}, "one"],
            [:list_item, {}, "two"]]
          ]]
      end
      
      describe "InlineParser integration" do

        it "should parse a paragraph with inline strong" do
          parse("p. This is *my* paragraph").to_sexp.should ==
            [[:paragraph, {}, [
              "This is ",
              [:strong, {}, ["my"]],
              " paragraph"]]]
        end
        
      end
      
    end

  end
end