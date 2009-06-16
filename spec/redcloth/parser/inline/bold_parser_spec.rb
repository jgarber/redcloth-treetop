require File.dirname(__FILE__) + "/../../../spec_helper"
require 'redcloth/parser/inline/bold'

module RedCloth
  module Parser
    module Inline
      describe BoldParser do
        before :each do
          @parser = BoldParser.new
        end
        
        def parse(string)
          @parser.parse_or_fail(string)
        end
        
        it "should parse a bold phrase" do
          parse("**complete all required fields**").to_sexp.should ==
            [:bold, {}, ["complete all required fields"]]
        end
        
        it "should allow double asterisks as words in a bold phrase" do
          parse("**2 ** 7**").to_sexp.should ==
            [:bold, {}, ["2 ** 7"]]
        end
        
        it "should allow a bold phrase to contain double asterisks in a word" do
          parse("**veg**an**").to_sexp.should ==
            [:bold, {}, ["veg**an"]]
        end

        describe "word rule" do
          before(:each) { @parser.root = :word }

          it "should parse a normal word" do
            lambda { parse("word") }.should_not raise_error
          end
          it "should parse a word with a double-asterisk in it" do
            parse("veg**an")
          end
          it "should parse a lone double-asterisk" do
            parse("**")
          end
          it "should include leading double-asterisk in a word" do
            parse("**yow").should == "**yow"
          end
          it "should not include trailing double-asterisk in a word if the next char is a space" do
            @parser.consume_all_input = false
            parse("yow** ").should == "yow"
          end
          it "should not include trailing double-asterisk in a word if the next char is EOF" do
            @parser.consume_all_input = false
            parse("yow**").should == "yow"
          end
          it "should include trailing asterisk in a word if the next char is a double-asterisk" do
            @parser.consume_all_input = false
            parse("yow***").should == "yow*"
          end
          it "should include trailing double-asterisk in a word if the next char is a double-asterisk" do
            @parser.consume_all_input = false
            parse("yow****").should == "yow**"
          end
          it "should not include trailing double-asterisk in a word if the next char is an underscore" do
            @parser.consume_all_input = false
            parse("yow**_").should == "yow"
          end
          it "should not include trailing double-asterisk in a word if the next char is a question mark" do
            @parser.consume_all_input = false
            parse("yow**?").should == "yow"
          end
          it "should not include trailing double-asterisk in a word if the next char starts an HTML tag" do
            @parser.consume_all_input = false
            parse("yow**</span>").should == "yow"
          end
          it "should not include trailing double-asterisk in a word if the next char is a double quote" do
            @parser.consume_all_input = false
            parse("yow**\"").should == "yow"
          end
          it "should not include trailing double-asterisk in a word if the next char is a single quote" do
            @parser.consume_all_input = false
            parse("yow**'").should == "yow"
          end
        end
        
      end
    end
  end
end