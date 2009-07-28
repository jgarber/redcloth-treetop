require File.dirname(__FILE__) + "/../../../spec_helper"
require 'redcloth/parser/inline/italic'

module RedCloth
  module Parser
    module Inline
      describe ItalicParser do
        before :each do
          @parser = ItalicParser.new
        end
        
        def parse(string)
          @parser.parse_or_fail(string)
        end
        
        it "should parse a italic phrase" do
          parse("__complete all required fields__").to_sexp.should ==
            [:italic, {}, ["complete all required fields"]]
        end
        
        it "should parse class/id attributes on italic phrase" do
          parse("__(myclass#myid)complete all required fields__").to_sexp.should ==
            [:italic, {:class => "myclass", :id => "myid"}, ["complete all required fields"]]
        end
        
        it "should allow double underscores as words in a italic phrase" do
          parse("__a __ b__").to_sexp.should ==
            [:italic, {}, ["a __ b"]]
        end
        
        it "should allow a italic phrase to contain double underscores in a word" do
          parse("__foo__bar__").to_sexp.should ==
            [:italic, {}, ["foo__bar"]]
        end

        describe "word rule" do
          before(:each) do
            @parser.root = :word
            @parser.consume_all_input = false
          end

          it "should parse a normal word" do
            parse("word").should == "word"
          end
          it "should parse a word with a double-underscore in it" do
            parse("foo__bar").should == "foo__bar"
          end
          it "should parse a lone double-underscore" do
            parse("__").should == "__"
          end
          it "should include a leading double-underscore in a word" do
            parse("__foo").should == "__foo"
          end
          it "should not include a trailing double-underscore in a word if the next char is a space" do
            parse("foo__ ").should == "foo"
          end
          it "should not include a trailing double-underscore in a word if the next char is EOF" do
            parse("foo__").should == "foo"
          end
          it "should include a trailing underscore in a word if the next char is a double-underscore" do
            parse("foo___").should == "foo_"
          end
          it "should include a trailing double-underscore in a word if the next char is a double-underscore" do
            parse("foo____").should == "foo__"
          end
          it "should not include a trailing double-underscore in a word if the next char is an asterisk" do
            parse("foo__*").should == "foo"
          end
          it "should not include a trailing double-underscore in a word if the next char is a question mark" do
            parse("foo__?").should == "foo"
          end
          it "should not include trailing double-underscore in a word if the next char starts an HTML tag" do
            parse("foo__</span>").should == "foo"
          end
          it "should not include trailing double-underscore in a word if the next char is a double quote" do
            parse("foo__\"").should == "foo"
          end
          it "should not include trailing double-underscore in a word if the next char is a single quote" do
            parse("foo__'").should == "foo"
          end
        end
        
      end
    end
  end
end