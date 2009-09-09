require File.dirname(__FILE__) + "/../../../spec_helper"
require 'redcloth/parser/inline/quotation'

module RedCloth
  module Parser
    module Inline
      describe QuotationParser do
        before :each do
          @parser = QuotationParser.new
        end
        
        def parse(string)
          @parser.parse_or_fail(string)
        end
        
        it "should parse a quotation" do
          parse(%{"I think, therefore, I am"}).to_sexp.should ==
            [:double_quote, {}, ["I think, therefore, I am"]]
        end
        
        # it "should parse class/id attributes on quotation" do
        #   parse("*(myclass#myid)don't you dare!*").to_sexp.should ==
        #     [:strong, {:class => "myclass", :id => "myid"}, ["don't you dare!"]]
        # end
        # 
        # it "should allow asterisks as words in a strong phrase" do
        #   parse("*2 * 7*").to_sexp.should ==
        #     [:strong, {}, ["2 * 7"]]
        # end
        # 
        # it "should allow a strong phrase to contain asterisks in a word" do
        #   parse("*veg*an*").to_sexp.should ==
        #     [:strong, {}, ["veg*an"]]
        # end
      
        # describe "word rule" do
        #   before(:each) do
        #     @parser.root = :word
        #     @parser.consume_all_input = false
        #   end
        # 
        #   it "should parse a normal word" do
        #     parse("word").should == "word"
        #   end
        #   it "should parse a word with an asterisk in it" do
        #     parse("veg*an").should == "veg*an"
        #   end
        #   it "should parse a lone asterisk" do
        #     parse("*").should == "*"
        #   end
        #   it "should include leading asterisk in a word" do
        #     parse("*yow").should == "*yow"
        #   end
        #   it "should not include trailing asterisk in a word if the next char is a space" do
        #     parse("yow* ").should == "yow"
        #   end
        #   it "should include trailing asterisk in a word if the next char is an asterisk" do
        #     pending # FIXME: this conflicts with the basic bold rule, where a bold phrase ends with **
        #     parse("yow**").should == "yow*"
        #   end
        #   it "should not include trailing asterisk in a word if the next char is an underscore" do
        #     parse("yow*_").should == "yow"
        #   end
        #   it "should not include trailing asterisk in a word if the next char is a question mark" do
        #     parse("yow*?").should == "yow"
        #   end
        #   it "should not include trailing asterisk in a word if the next char is an exclamation mark" do
        #     parse("yow*!").should == "yow"
        #   end
        #   it "should not include trailing asterisk in a word if the next char starts an HTML tag" do
        #     parse("yow*</span>").should == "yow"
        #   end
        #   it "should not include trailing asterisk in a word if the next char is a double quote" do
        #     parse("yow*\"").should == "yow"
        #   end
        #   it "should not include trailing asterisk in a word if the next char is a single quote" do
        #     parse("yow*'").should == "yow"
        #   end
        # end
        #    
      end
    end
  end
end