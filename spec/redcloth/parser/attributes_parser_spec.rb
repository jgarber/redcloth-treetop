require File.dirname(__FILE__) + "/../../spec_helper"
require 'redcloth/parser/attributes'

module RedCloth
  module Parser
    describe AttributesParser do
      before :each do
        @parser = AttributesParser.new
      end
  
      def parse(string)
        @parser.parse_or_fail(string)
      end
      
    end

  end
end