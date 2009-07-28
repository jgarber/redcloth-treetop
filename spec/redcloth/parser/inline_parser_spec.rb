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
      
      def parsed_sexp(string)
        parse(string).map {|e| e.to_sexp}
      end
      
      ### plain text ###
      
      it "should parse a plain-text phrase" do
        parsed_sexp("Just plain text.").should ==
          ["Just plain text."]
      end
      
      it "should parse two basic sentences" do
        parsed_sexp("One sentence. Two.").should ==
          ["One sentence. Two."]
      end
      
      it "should parse a phrase with asterisks that is not a strong phrase" do
        parsed_sexp("yes * we * can").should ==
          ["yes * we * can"]
      end

      it "should parse a phrase that is not a strong because it has space at the end" do
        parsed_sexp("yeah *that's * it!").should ==
          ["yeah *that's * it!"]
      end
      
      ### strong ###
      
      it "should parse a strong phrase" do
        parsed_sexp("*strong phrase*").should ==
          [[:strong, {}, ["strong phrase"]]]
      end
      
      it "should parse a strong phrase surrounded by plain text" do
        parsed_sexp("plain *strong phrase* plain").should ==
          ["plain ", [:strong, {}, ["strong phrase"]], " plain"]
      end
      
      it "should allow a strong phrase at the end of a sentence before punctuation" do
        parsed_sexp("Are you *veg*an*?").should ==
          ["Are you ", [:strong, {}, ["veg*an"]], "?"]
      end
      
      it "should parse a bold phrase inside a strong phrase" do
        parsed_sexp("*this is **bold** see*").should ==
          [[:strong, {}, [
            "this is ",
            [:bold, {}, ["bold"]],
            " see"]]]
      end
      
      it "should parse an emphasized phrase inside a strong phrase" do
        parsed_sexp("*_em in strong_*").should ==
          [[:strong, {}, [
            [:em, {}, ["em in strong"]]]]]
      end
      
      ### em ###
      
      it "should parse an emphasized phrase" do
        parsed_sexp("_emphasized_").should ==
          [[:em, {}, ["emphasized"]]]
      end
      
      it "should allow an emphasized phrase at the end of a sentence before punctuation" do
        parsed_sexp("Are you _sure_?").should ==
          ["Are you ", [:em, {}, ["sure"]], "?"]
      end
      
      it "should parse a strong phrase inside an emphasized phrase" do
        parsed_sexp("_*strong in em*_").should ==
          [[:em, {}, [
            [:strong, {}, ["strong in em"]]]]]
      end
      
      it "should parse a bold phrase inside an emphasized phrase" do
        parsed_sexp("_**bold in em**_").should ==
          [[:em, {}, [
            [:bold, {}, ["bold in em"]]]]]
      end
      
      ### bold ###
      
      it "should parse a bold phrase" do
        parsed_sexp("**bold phrase**").should ==
          [[:bold, {}, ["bold phrase"]]]
      end
      
      it "should parse a bold phrase surrounded by plain text" do
        parsed_sexp("plain **bold phrase** plain").should ==
          ["plain ", [:bold, {}, ["bold phrase"]], " plain"]
      end
      
      it "should allow a bold phrase at the end of a sentence before punctuation" do
        parsed_sexp("Are you **veg*an**?").should ==
          ["Are you ", [:bold, {}, ["veg*an"]], "?"]
      end
      
      it "should parse a strong phrase inside a bold phrase" do
        parsed_sexp("**this is *strong* see**").should ==
          [[:bold, {}, [
            "this is ",
            [:strong, {}, ["strong"]],
            " see"]]]
      end
      
      it "should parse an emphasized phrase inside a bold phrase" do
        parsed_sexp("**_em in bold_**").should ==
          [[:bold, {}, [
            [:em, {}, ["em in bold"]]]]]
      end
      
      
    end
  end
end