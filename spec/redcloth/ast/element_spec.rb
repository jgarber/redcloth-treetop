require File.dirname(__FILE__) + '/../../spec_helper'
require 'redcloth/ast'

module RedCloth
  module Ast
    describe Element do
      before(:each) do
        @child = mock("element1")
        @expected_sexp = [:element, {}, '']
        @child.stub!(:to_sexp).and_return(@expected_sexp)
        @element = TextileDoc.new([@child])
        @visitor = mock('Visitor')
      end
      
      it "should return the s-expressions of its children" do
        @element.to_sexp.should == [@expected_sexp]
      end
      
      it "should accept visitor" do
        @visitor.should_receive(:block_element).with(@child)
        @element.accept(@visitor)
      end
      
    end
  end
end

