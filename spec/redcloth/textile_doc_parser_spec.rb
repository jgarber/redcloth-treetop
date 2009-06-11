require File.dirname(__FILE__) + "/../spec_helper"
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
          [[:paragraph, {}, "This is my paragraph"]]
      end
  
      it 'should parse an explicit paragraph' do
        parse("p. This is my paragraph\n\n").to_sexp.should ==
          [[:paragraph, {}, "This is my paragraph"]]
      end
  
      it 'should parse an explicit paragraph without double newline after' do
        parse("p. This is my paragraph").to_sexp.should ==
          [[:paragraph, {}, "This is my paragraph"]]
      end
        
      it "should parse a basic list" do
        parse("# one\n# two\n\n").to_sexp.should ==
          [[:list, {}, [
            [:list_item, {}, "one"],
            [:list_item, {}, "two"]]
          ]]
      end
      
      it "should parse a basic list without double newline after" do
        parse("# one\n# two").to_sexp.should ==
          [[:list, {}, [
            [:list_item, {}, "one"],
            [:list_item, {}, "two"]]
          ]]
      end
        
      # it "should parse a nested list" do
      #   puts parse("# one\n## one.two\n\n").inspect
      #   # parse("# one\n## one.two\n\n").should have_a_list("one.two") do |list|
      #   #   list.should have_an_li
      #   # end
      #   parse("# one\n## one.two\n\n").to_html.should == "<ol><li>one</li><ol><li>one.two</li></ol></ol>"
      # end
    end

  end
end