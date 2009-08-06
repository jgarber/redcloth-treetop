require File.dirname(__FILE__) + "/../../../spec_helper"
require 'redcloth/parser/inline/link'

module RedCloth
  module Parser
    module Inline
      describe LinkParser do
        before :each do
          @parser = LinkParser.new
        end
        
        def parse(string)
          @parser.parse_or_fail(string)
        end
        
        it "should parse a basic link" do
          parse('"Google":http://google.com').to_sexp.should ==
            [:link, {:href => "http://google.com"}, ["Google"]]
        end
      end
    end
  end
end