require File.dirname(__FILE__) + '/../../spec_helper'
require 'redcloth/ast'

module RedCloth
  module Ast
    describe TextileDoc do
      before(:each) do
        @element = mock("element1")
        @expected_sexp = [:element, {}, '']
        @element.stub!(:to_sexp).and_return(@expected_sexp)
        @textile_doc = TextileDoc.new([@element])
        @visitor = mock('Visitor')
      end
      
      it "should return the s-expressions of its children" do
        @textile_doc.to_sexp.should == [@expected_sexp]
      end
      
      it "should accept visitor" do
        @visitor.should_receive(:visit_block_element).with(@element)
        @textile_doc.accept(@visitor)
      end
      
    end
  end
end

