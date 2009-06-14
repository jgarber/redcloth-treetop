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
      
      it "should parse a strong phrase" do
        parse("*don't you dare!*").to_sexp.should ==
          [[:strong, {}, ["don't you dare!"]]]
      end
      
      it "should parse an emphasized phrase" do
        parse("_emphasized_").to_sexp.should ==
          [[:em, {}, ["emphasized"]]]
      end
      
      it "should parse an emphasized phrase inside a strong phrase" do
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