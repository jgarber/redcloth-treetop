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
          [[:strong, {}, "don't you dare!"]]
      end
      
    end
  end
end