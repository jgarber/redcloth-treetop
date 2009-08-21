require File.dirname(__FILE__) + '/../../spec_helper'
require 'redcloth/formatter/html'
require 'redcloth/ast'

module RedCloth
  module Formatter
    describe Html do
      before(:each) do
        @formatter = Html.new
      end
      
      describe "#block_element" do
        it "should format a simple paragraph" do
          @block_element = mock("block element")
          @formatter.should_receive(:p)
          @formatter.block_element(@block_element)
        end
      end

      describe "#p" do
        it "should format a simple paragraph" do
          @p = Ast::Element.new({:type => :p}, ["test"])
          @formatter.p(@p).should == "<p>test</p>"
        end
        
        it "should format a paragraph composed of an inline element" do
          @strong = Ast::Element.new({:type => :strong}, ["Do not drink the water!"])
          @p = Ast::Element.new({:type => :p}, [@strong])
          @formatter.p(@p).should == "<p><strong>Do not drink the water!</strong></p>"
        end
        
        it "should format a paragraph containing inline elements" do
          @strong = Ast::Element.new({:type => :strong}, ["do not drink the water"])
          @p = Ast::Element.new({:type => :p}, ["Please ", @strong, "!"])
          @formatter.p(@p).should == "<p>Please <strong>do not drink the water</strong>!</p>"
        end
      end
      
      describe "#strong" do
        it "should format a strong phrase" do
          @strong = Ast::Element.new({:type => 'strong'}, ['Strong phrase.'])
          @formatter.strong(@strong).should == "<strong>Strong phrase.</strong>"
        end
      end
      
      describe "#bold" do
        it "should format a bold phrase" do
          @bold = Ast::Element.new({:type => 'bold'}, ['Bold phrase.'])
          @formatter.b(@bold).should == "<b>Bold phrase.</b>"
        end
      end
      
      describe "#em" do
        it "should format an emphasized phrase" do
          @em = Ast::Element.new({:type => 'em'}, ['Emphasized phrase.'])
          @formatter.em(@em).should == "<em>Emphasized phrase.</em>"
        end
      end
      
    end
  end
end

