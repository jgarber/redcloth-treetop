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
          before(:each) do
            @parser.root = :word
            @parser.consume_all_input = false
          end

          it "should parse a normal word" do
            parse("word").should == "word"
          end
          it "should parse a word with a double-asterisk in it" do
            parse("veg**an").should == "veg**an"
          end
          it "should parse a lone double-asterisk" do
            parse("**").should == "**"
          end
          it "should include leading double-asterisk in a word" do
            parse("**yow").should == "**yow"
          end
          it "should not include trailing double-asterisk in a word if the next char is a space" do
            parse("yow** ").should == "yow"
          end
          it "should not include trailing double-asterisk in a word if the next char is EOF" do
            parse("yow**").should == "yow"
          end
          it "should include trailing asterisk in a word if the next char is a double-asterisk" do
            parse("yow***").should == "yow*"
          end
          it "should include trailing double-asterisk in a word if the next char is a double-asterisk" do
            parse("yow****").should == "yow**"
          end
          it "should not include trailing double-asterisk in a word if the next char is an underscore" do
            parse("yow**_").should == "yow"
          end
          it "should not include trailing double-asterisk in a word if the next char is a question mark" do
            parse("yow**?").should == "yow"
          end
          it "should not include trailing double-asterisk in a word if the next char starts an HTML tag" do
            parse("yow**</span>").should == "yow"
          end
          it "should not include trailing double-asterisk in a word if the next char is a double quote" do
            parse("yow**\"").should == "yow"
          end
          it "should not include trailing double-asterisk in a word if the next char is a single quote" do
            parse("yow**'").should == "yow"
          end
        end
        
      end
    end
  end
end