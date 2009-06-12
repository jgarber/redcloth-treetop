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
        
      it "should parse a nested list" do
        parse("# one\n## one.two\n\n").to_sexp.should == 
        [[:list, {}, [
          [:list_item, {}, "one"],
          [:list, {}, [
            [:list_item, {}, "one.two"]]]]]]
      end
      
      it "should parse a nested list with multiple items in each" do
        parse("# one\n# two\n## two.one\n## two.two\n\n").to_sexp.should == 
        [[:list, {}, [
          [:list_item, {}, "one"],
          [:list_item, {}, "two"],
          [:list, {}, [
            [:list_item, {}, "two.one"],
            [:list_item, {}, "two.two"]]]]]]
      end
      
      it "should parse a nested list that returns to its outer list" do
        parse("# one\n## one.two\n# two\n\n").to_sexp.should == 
        [[:list, {}, [
          [:list_item, {}, "one"],
          [:list, {}, [
            [:list_item, {}, "one.two"]]],
          [:list_item, {}, "two"]]]]
      end
      
    end

  end
end