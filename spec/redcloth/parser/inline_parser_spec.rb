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
      
      it "should parse a strong phrase" do
        parse("*don't you dare!*").to_sexp.should ==
          [[:strong, {}, ["don't you dare!"]]]
      end
      
      it "should parse a phrase with asterisks that is not a strong phrase" do
        parse("yes * we * can").to_sexp.should ==
         ["yes * we * can"]
      end

      it "should parse a strong phrase that is invalid as non-strong because it has space at the end" do
        parse("yeah *that's * it!").to_sexp.should ==
         ["yeah *that's * it!"]
      end
      
      it "should allow asterisks preceded by a space in bolded phrase" do
        parse("compute *2 * 7*").to_sexp.should ==
          ["compute ", [:strong, {}, ["2 * 7"]]]
      end
      
      it "should allow a bolded phrase to contain asterisks in a word" do
        parse("Are you *veg*an*?").to_sexp.should ==
          ["Are you ", [:strong, {}, ["veg*an"]], "?"]
      end
      
      it "should parse an emphasized phrase" do
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
        parse("_*strong in em*_").to_sexp.should ==
          [[:em, {}, [
            [:strong, {}, ["strong in em"]]]]]
      end
      
      it "should parse a bold phrase" do
        parse("**complete all required fields**").to_sexp.should ==
          [[:bold, {}, ["complete all required fields"]]]
      end
      
    end
  end
end