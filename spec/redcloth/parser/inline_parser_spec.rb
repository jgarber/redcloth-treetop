require File.dirname(__FILE__) + "/../../spec_helper"
require 'redcloth/parser/inline'

module RedCloth
  module Parser
    describe InlineParser do
      before :each do
        @parser = InlineParser.new
      end
      
      def parse(string)
        @parser.parse_or_fail(string)
      end
      
      it "should parse a plain-text phrase" do
        parse("Just plain text.").to_sexp.should ==
          ["Just plain text."]
      end
      
      it "should parse a phrase with asterisks that is not a strong phrase" do
        parse("yes * we * can").to_sexp.should ==
         ["yes * we * can"]
      end

      it "should parse a phrase that is not a strong because it has space at the end" do
        parse("yeah *that's * it!").to_sexp.should ==
         ["yeah *that's * it!"]
      end
      
      it "should parse a strong phrase" do
        parse("*strong phrase*").to_sexp.should ==
          [[:strong, {}, ["strong phrase"]]]
      end
      
      it "should parse a strong phrase surrounded by plain text" do
        parse("plain *strong phrase* plain").to_sexp.should ==
          ["plain ", [:strong, {}, ["strong phrase"]], " plain"]
      end
      
      it "should allow a strong phrase at the end of a sentence before punctuation" do
        parse("Are you *veg*an*?").to_sexp.should ==
          ["Are you ", [:strong, {}, ["veg*an"]], "?"]
      end
      
      it "should parse an emphasized phrase" do
        pending
        parse("_emphasized_").to_sexp.should ==
          [[:em, {}, ["emphasized"]]]
      end
      
      it "should parse an emphasized phrase inside a strong phrase" do
        pending
        parse("*_em in strong_*").to_sexp.should ==
          [[:strong, {}, [
            [:em, {}, ["em in strong"]]]]]
      end
      
      it "should parse a strong phrase inside an emphasized phrase" do
        pending
        parse("_*strong in em*_").to_sexp.should ==
          [[:em, {}, [
            [:strong, {}, ["strong in em"]]]]]
      end
      
      it "should parse a bold phrase" do
        parse("**complete all required fields**").to_sexp.should ==
          [[:bold, {}, ["complete all required fields"]]]
      end
      
      it "should parse a bold phrase inside a strong phrase" do
        parse("*this is **bold** see*").to_sexp.should ==
          [[:strong, {}, [
            "this is ",
            [:bold, {}, ["bold"]],
            " see"]]]
      end
      
      describe "bold_word rule" do
        before(:each) { @parser.root = :bold_word }
        
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
          parse("yow***").should == "yow**"
        end
        it "should not include trailing double-asterisk in a word if the next char is an underscore" do
          @parser.consume_all_input = false
          parse("yow**_").should == "yow"
        end
        it "should include trailing double-asterisk in a word if the next char is a question mark" do
          @parser.consume_all_input = false
          parse("yow**?").should == "yow**"
        end
      end
           
    end
  end
end