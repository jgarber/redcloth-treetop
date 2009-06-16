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
      
      ### plain text ###
      
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
      
      ### strong ###
      
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
      
      it "should parse a bold phrase inside a strong phrase" do
        parse("*this is **bold** see*").to_sexp.should ==
          [[:strong, {}, [
            "this is ",
            [:bold, {}, ["bold"]],
            " see"]]]
      end
      
      it "should parse an emphasized phrase inside a strong phrase" do
        pending
        parse("*_em in strong_*").to_sexp.should ==
          [[:strong, {}, [
            [:em, {}, ["em in strong"]]]]]
      end
      
      ### em ###
      
      it "should parse an emphasized phrase" do
        pending
        parse("_emphasized_").to_sexp.should ==
          [[:em, {}, ["emphasized"]]]
      end
      
      it "should parse a strong phrase inside an emphasized phrase" do
        pending
        parse("_*strong in em*_").to_sexp.should ==
          [[:em, {}, [
            [:strong, {}, ["strong in em"]]]]]
      end
      
      ### bold ###
      
      it "should parse a bold phrase" do
        parse("**bold phrase**").to_sexp.should ==
          [[:bold, {}, ["bold phrase"]]]
      end
      
      it "should parse a bold phrase surrounded by plain text" do
        parse("plain **bold phrase** plain").to_sexp.should ==
          ["plain ", [:bold, {}, ["bold phrase"]], " plain"]
      end
      
      it "should allow a bold phrase at the end of a sentence before punctuation" do
        parse("Are you **veg*an**?").to_sexp.should ==
          ["Are you ", [:bold, {}, ["veg*an"]], "?"]
      end
      
      it "should parse a strong phrase inside a bold phrase" do
        parse("**this is *strong* see**").to_sexp.should ==
          [[:bold, {}, [
            "this is ",
            [:strong, {}, ["strong"]],
            " see"]]]
      end
      
      it "should parse an emphasized phrase inside a bold phrase" do
        pending
        parse("**_em in bold_**").to_sexp.should ==
          [[:bold, {}, [
            [:em, {}, ["em in bold"]]]]]
      end
      
      
    end
  end
end