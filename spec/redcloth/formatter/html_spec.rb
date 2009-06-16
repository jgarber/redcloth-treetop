require File.dirname(__FILE__) + '/../../spec_helper'
require 'redcloth/formatter/html'
require 'redcloth/ast'

module RedCloth
  module Formatter
    describe Html do
      before(:each) do
        @messenger = StringIO.new 
        @formatter = Html.new(@messenger)
      end
      
      describe "#visit_block_element" do
        it "should output a simple paragraph" do
          @block_element = mock("block element")
          @formatter.should_receive(:visit_paragraph)
          @formatter.visit_block_element(@block_element)
        end
      end

      describe "#visit_paragraph" do
        it "should output a simple paragraph" do
          @paragraph = Ast::Paragraph.new({}, "test") # FIXME: this should probably be a mock object
          @formatter.visit_paragraph(@paragraph)
          @messenger.string.should == "<p>test</p>"
        end
      end
      
    end
  end
end

