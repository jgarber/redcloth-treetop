require File.dirname(__FILE__) + "/../../spec_helper"
require 'redcloth/parser'

module RedCloth
  module Parser
    # Examples in this file are general block formatting or
    # interactions between block elements. Block element
    # examples can be found in the spec/block directory.
    #
    describe TextileDocParser do
      before :each do
        @parser = TextileDocParser.new
      end
  
      def parse(string)
        @parser.parse_or_fail(string)
      end
      
      it 'should parse an implicit paragraph' do
        parse("This is my paragraph\n\n").to_sexp.should ==
          [[:p, {}, ["This is my paragraph"]]]
      end
  
      it 'should parse an explicit paragraph' do
        parse("p. This is my paragraph\n\n").to_sexp.should ==
          [[:p, {}, ["This is my paragraph"]]]
      end
  
      it 'should parse an explicit paragraph without double newline after' do
        parse("p. This is my paragraph").to_sexp.should ==
          [[:p, {}, ["This is my paragraph"]]]
      end
      
      it "should parse two block elements separated by two newlines" do
        parse("One paragraph.\n\nTwo paragraphs.").to_sexp.should ==
          [[:p, {}, ["One paragraph."]],
           [:p, {}, ["Two paragraphs."]]]
      end

      it "should parse two block elements with spaces on the separating line" do
        parse("One paragraph.\n  \nTwo paragraphs.").to_sexp.should ==
          [[:p, {}, ["One paragraph."]],
           [:p, {}, ["Two paragraphs."]]]
      end
        
      it "should parse two block elements with tabs on the separating line" do
        parse("One paragraph.\n\t\t\nTwo paragraphs.").to_sexp.should ==
          [[:p, {}, ["One paragraph."]],
           [:p, {}, ["Two paragraphs."]]]
      end
        
      it "should parse a basic list followed by double newline" do
        parse("# one\n# two\n\n").to_sexp.should ==
          [[:list, {}, [
            [:list_item, {}, ["one"]],
            [:list_item, {}, ["two"]]]
          ]]
      end
      
      it "should parse a list followed by paragraph" do
        parse("# one\n# two\n\nA paragraph.").to_sexp.should ==
          [ [:list, {}, [
              [:list_item, {}, ["one"]],
              [:list_item, {}, ["two"]]]],
            [:p, {}, ["A paragraph."]]
          ]
      end
      
      it "should parse a paragraph followed by a list" do
        parse("A paragraph.\n\n# one\n# two").to_sexp.should ==
          [ [:p, {}, ["A paragraph."]],
            [:list, {}, [
              [:list_item, {}, ["one"]],
              [:list_item, {}, ["two"]]]]
          ]
      end
      
      describe "InlineParser integration" do

        it "should parse a paragraph containing inline elements" do
          parse("p. This is *my* paragraph").to_sexp.should ==
            [[:p, {}, [
              "This is ",
              [:strong, {}, ["my"]],
              " paragraph"]]]
        end
        
        it "should parse a basic list that contains inline strong" do
          parse("# *one*\n# two\n\n").to_sexp.should ==
            [[:list, {}, [
              [:list_item, {}, [
                [:strong, {}, ["one"]]]],
              [:list_item, {}, ["two"]]]
            ]]
        end
        
      end
      
    end

  end
end