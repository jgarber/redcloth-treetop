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
      
      describe "#block_element" do
        it "should output a simple paragraph" do
          @block_element = mock("block element")
          @formatter.should_receive(:paragraph)
          @formatter.block_element(@block_element)
        end
      end

      describe "#paragraph" do
        it "should output a simple paragraph" do
          @paragraph = Ast::Paragraph.new({}, ["test"])
          @formatter.paragraph(@paragraph)
          @messenger.string.should == "<p>test</p>"
        end
      end
      
      describe "#strong" do
        it "should output a strong phrase" do
          @strong = Ast::Element.new({:type => 'strong'}, ['Strong phrase.'])
          @formatter.strong(@strong)
          @messenger.string.should == "<strong>Strong phrase.</strong>"
        end
      end
      
    end
  end
end

