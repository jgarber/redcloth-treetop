require File.dirname(__FILE__) + '/../../spec_helper'
require 'redcloth/ast'

module RedCloth
  module Ast
    describe Element do
      before(:each) do
        @element_containing_string = Element.new({:type => :strong}, ["A child"])
        @expected_sexp = [:strong, {}, ["A child"]]
        @element_containing_element = Element.new({:type => :p}, [@element_containing_string])
        @visitor = mock('Visitor')
      end
      
      it "should return its s-expression when it contains a string" do
        @element_containing_string.to_sexp.should == @expected_sexp
      end
      
      it "should return the s-expressions of its children" do
        @element_containing_element.to_sexp.should == [:p, {}, [@expected_sexp]]
      end
      
      it "should accept visitor" do
        @visitor.should_receive(:p).with(@element_containing_element)
        @element_containing_element.accept(@visitor)
      end
      
    end
  end
end

