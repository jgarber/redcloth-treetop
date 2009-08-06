require File.dirname(__FILE__) + "/../../../spec_helper"
require 'redcloth/parser/attributes/sentence_uri'

module RedCloth
  module Parser
    module Attributes
      describe SentenceUri do
        before :each do
          @parser = SentenceUriParser.new
        end
  
        def parse(string)
          @parser.parse_or_fail(string)
        end
        
        # Though technically valid, punctuation is not allowed at the end of a URL in
        # the context of inline Textile.
        describe "termination" do
          before(:each) do
            @parser.consume_all_input = false
          end
          
          it "should allow a '.' within the domain" do
            parse("http://red.cloth.org").text_value.should == "http://red.cloth.org"
          end
          
          it "should allow a '.' before the first slash" do
            parse("http://redcloth.org./").text_value.should == "http://redcloth.org./"
          end
                    
          %w(. !).each do |punct|
            
            it "should allow a '#{punct}' within the path without a slash" do
              parse("http://redcloth.org/text#{punct}ile").text_value.should == "http://redcloth.org/text#{punct}ile"
            end
            
            it "should allow a '#{punct}' within the filename" do
              parse("http://redcloth.org/text#{punct}ile.html").text_value.should == "http://redcloth.org/text#{punct}ile.html"
            end
            
            it "should allow a '#{punct}' within the path with a slash" do
              parse("http://redcloth.org/text#{punct}ile/").text_value.should == "http://redcloth.org/text#{punct}ile/"
            end
            
            it "should allow a '#{punct}' before the fragment hash" do
              parse("http://redcloth.org/#{punct}#").text_value.should == "http://redcloth.org/#{punct}#"
            end
            
            it "should allow a '#{punct}' within the fragment" do
              parse("http://redcloth.org/#foo#{punct}bar").text_value.should == "http://redcloth.org/#foo#{punct}bar"
            end
            
            it "should allow a '#{punct}' within the absolute path" do
              parse("/foo#{punct}bar").text_value.should == "/foo#{punct}bar"
            end
            
            it "should allow a '#{punct}' before the absolute path final slash" do
              parse("/foo#{punct}/").text_value.should == "/foo#{punct}/"
            end
            
            it "should allow a '#{punct}' within the relative path" do
              parse("foo#{punct}bar").text_value.should == "foo#{punct}bar"
            end
            
            it "should allow a '#{punct}' before the param" do
              parse("foo#{punct};bar").text_value.should == "foo#{punct};bar"
            end
            
            it "should allow a '#{punct}' within the param" do
              parse("foo;bar#{punct}baz").text_value.should == "foo;bar#{punct}baz"
            end
            
            it "should allow a '#{punct}' within the query" do
              parse("index?foo=bar#{punct}baz").text_value.should == "index?foo=bar#{punct}baz"
            end
            
            it "should not include a '#{punct}' terminating the TLD" do
              parse("http://redcloth.org#{punct}").text_value.should == "http://redcloth.org"
            end
            
            it "should not include a '#{punct}' terminating the first slash" do
              parse("http://redcloth.org/#{punct}").text_value.should == "http://redcloth.org/"
            end
            
            it "should not include a '#{punct}' terminating the path without a slash" do
              parse("http://redcloth.org/textile#{punct}").text_value.should == "http://redcloth.org/textile"
            end
            
            it "should not include a '#{punct}' terminating the filename" do
              parse("http://redcloth.org/textile.html#{punct}").text_value.should == "http://redcloth.org/textile.html"
            end
            
            it "should not include a '#{punct}' terminating the path with a slash" do
              parse("http://redcloth.org/textile/#{punct}").text_value.should == "http://redcloth.org/textile/"
            end
            
            it "should not include a '#{punct}' terminating the fragment hash" do
              parse("http://redcloth.org/##{punct}").text_value.should == "http://redcloth.org/#"
            end
            
            it "should not include a '#{punct}' terminating the fragment" do
              parse("http://redcloth.org/#foo#{punct}").text_value.should == "http://redcloth.org/#foo"
            end
            
            it "should not include a '#{punct}' terminating the absolute path" do
              parse("/foo#{punct}").text_value.should == "/foo"
            end
            
            it "should not include a '#{punct}' terminating the absolute path final slash" do
              parse("/foo/#{punct}").text_value.should == "/foo/"
            end
            
            it "should not include a '#{punct}' terminating the relative path" do
              parse("foo#{punct}").text_value.should == "foo"
            end
            
            it "should not include a '#{punct}' terminating the param" do
              parse("foo;bar#{punct}").text_value.should == "foo;bar"
            end
            
            it "should not include a '#{punct}' terminating the querystring" do
              parse("index?foo=bar#{punct}").text_value.should == "index?foo=bar"
            end
            
          end
        end
        
      end
    end
  end
end