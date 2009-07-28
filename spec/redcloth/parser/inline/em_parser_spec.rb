require File.dirname(__FILE__) + "/../../../spec_helper"
require 'redcloth/parser/inline/em'

module RedCloth
  module Parser
    module Inline
      describe EmParser do
        before :each do
          @parser = EmParser.new
        end
        
        def parse(string)
          @parser.parse_or_fail(string)
        end
        
        it "should parse an emphasized phrase" do
          parse("_Clearly!_").to_sexp.should ==
            [:em, {}, ["Clearly!"]]
        end
        
        it "should parse class/id attributes on emphasized phrase" do
          parse("_(myclass#myid)Clearly!_").to_sexp.should ==
            [:em, {:class => "myclass", :id => "myid"}, ["Clearly!"]]
        end
        
        it "should allow underscores in an emphasized phrase" do
          parse("_foo _ bar_").to_sexp.should ==
            [:em, {}, ["foo _ bar"]]
        end
        
        it "should allow an emphasized phrase to contain underscores in a word" do
          parse("_foo_bar_").to_sexp.should ==
            [:em, {}, ["foo_bar"]]
        end
      
        describe "word rule" do
          before(:each) do
            @parser.root = :word
            @parser.consume_all_input = false
          end
        
          it "should parse a normal word" do
            parse("word").should == "word"
          end
          it "should parse a word with an underscore in it" do
            parse("foo_bar").should == "foo_bar"
          end
          it "should parse a lone underscore" do
            parse("_").should == "_"
          end
          it "should include leading underscore in a word" do
            parse("_foo").should == "_foo"
          end
          it "should not include trailing underscore in a word if the next char is a space" do
            parse("foo_ ").should == "foo"
          end
          it "should include trailing underscore in a word if the next char is an underscore" do
            parse("foo__").should == "foo_"
          end
          it "should not include trailing underscore in a word if the next char is an asterisk" do
            parse("foo_*").should == "foo"
          end
          it "should not include trailing underscore in a word if the next char is a question mark" do
            parse("foo_?").should == "foo"
          end
          it "should not include trailing underscore in a word if the next char is an exclamation mark" do
            parse("foo_!").should == "foo"
          end
          it "should not include trailing underscore in a word if the next char starts an HTML tag" do
            parse("foo_</span>").should == "foo"
          end
          it "should not include trailing underscore in a word if the next char is a double quote" do
            parse("foo_\"").should == "foo"
          end
          it "should not include trailing underscore in a word if the next char is a single quote" do
            parse("foo_'").should == "foo"
          end
        end
           
      end
    end
  end
end