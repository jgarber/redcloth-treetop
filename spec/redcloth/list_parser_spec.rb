require File.dirname(__FILE__) + "/../spec_helper"
require 'redcloth/parser/list'

module RedCloth
  module Parser
    describe ListParser do
      before :each do
        @parser = ListParser.new
      end
  
      def parse(string)
        @parser.parse_or_fail(string)
      end
      
      it "should parse a basic list" do
        parse("# one\n# two").to_sexp.should ==
          [:list, {}, [
            [:list_item, {}, "one"],
            [:list_item, {}, "two"]]
          ]
      end
        
      it "should parse a nested list" do
        parse("# one\n## one.two").to_sexp.should == 
        [:list, {}, [
          [:list_item, {}, "one"],
          [:list, {}, [
            [:list_item, {}, "one.two"]]]]]
      end
      
      it "should parse a nested list with multiple items in each" do
        parse("# one\n# two\n## two.one\n## two.two").to_sexp.should == 
        [:list, {}, [
          [:list_item, {}, "one"],
          [:list_item, {}, "two"],
          [:list, {}, [
            [:list_item, {}, "two.one"],
            [:list_item, {}, "two.two"]]]]]
      end
      
      it "should parse a nested list that returns to its outer list" do
        parse("# one\n## one.two\n# two").to_sexp.should == 
        [:list, {}, [
          [:list_item, {}, "one"],
          [:list, {}, [
            [:list_item, {}, "one.two"]]],
          [:list_item, {}, "two"]]]
      end
      
      it "should parse class on the list" do
        parse("(myclass)# one\n# two").to_sexp.should ==
          [:list, {:class => "myclass"}, [
            [:list_item, {}, "one"],
            [:list_item, {}, "two"]]
          ]
      end
      
    end

  end
end