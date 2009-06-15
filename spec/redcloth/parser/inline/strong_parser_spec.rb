require File.dirname(__FILE__) + "/../../../spec_helper"
require 'redcloth/parser/inline/strong'

module RedCloth
  module Parser
    module Inline
      describe StrongParser do
        before :each do
          @parser = StrongParser.new
        end
        
        def parse(string)
          @parser.parse_or_fail(string)
        end
        
        it "should parse a strong phrase" do
          parse("*don't you dare!*").to_sexp.should ==
            [:strong, {}, ["don't you dare!"]]
        end
        
        it "should allow asterisks as words in a strong phrase" do
          parse("*2 * 7*").to_sexp.should ==
            [:strong, {}, ["2 * 7"]]
        end
        
        it "should allow a strong phrase to contain asterisks in a word" do
          parse("*veg*an*").to_sexp.should ==
            [:strong, {}, ["veg*an"]]
        end
      
        describe "strong_word rule" do
          before(:each) { @parser.root = :strong_word }
        
          it "should parse a normal word" do
            lambda { parse("word") }.should_not raise_error
          end
          it "should parse a word with an asterisk in it" do
            parse("veg*an")
          end
          it "should parse a lone asterisk" do
            parse("*")
          end
          it "should include leading asterisk in a word" do
            parse("*yow").should == "*yow"
          end
          it "should not include trailing asterisk in a word if the next char is a space" do
            @parser.consume_all_input = false
            parse("yow* ").should == "yow"
          end
          it "should include trailing asterisk in a word if the next char is an asterisk" do
            @parser.consume_all_input = false
            parse("yow**").should == "yow*"
          end
          it "should not include trailing asterisk in a word if the next char is an underscore" do
            @parser.consume_all_input = false
            parse("yow*_").should == "yow"
          end
          it "should not include trailing asterisk in a word if the next char is a question mark" do
            @parser.consume_all_input = false
            parse("yow*?").should == "yow"
          end
          it "should not include trailing asterisk in a word if the next char is an exclamation mark" do
            @parser.consume_all_input = false
            parse("yow*!").should == "yow"
          end
          it "should not include trailing asterisk in a word if the next char starts an HTML tag" do
            @parser.consume_all_input = false
            parse("yow*</span>").should == "yow"
          end
          it "should not include trailing asterisk in a word if the next char is a double quote" do
            @parser.consume_all_input = false
            parse("yow*\"").should == "yow"
          end
          it "should not include trailing asterisk in a word if the next char is a single quote" do
            @parser.consume_all_input = false
            parse("yow*'").should == "yow"
          end
        end
           
      end
    end
  end
end