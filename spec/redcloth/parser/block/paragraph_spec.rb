require File.dirname(__FILE__) + "/../../../spec_helper"
require 'redcloth/parser'

module RedCloth
  module Parser
    describe TextileDocParser, "paragraph" do
      before :each do
        @parser = TextileDocParser.new
      end
  
      def parse(string)
        @parser.parse_or_fail(string)
      end
      
      it "should parse attributes on an explicit paragraph" do
        parse("p(myclass#myid). This is my paragraph").to_sexp.should ==
          [[:p, {:class => "myclass", :id => "myid"}, ["This is my paragraph"]]]
      end
      
    end
  end
end