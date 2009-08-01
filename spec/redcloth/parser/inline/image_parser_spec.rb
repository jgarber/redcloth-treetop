require File.dirname(__FILE__) + "/../../../spec_helper"
require 'redcloth/parser/inline/image'

module RedCloth
  module Parser
    module Inline
      describe ImageParser do
        before :each do
          @parser = ImageParser.new
        end
        
        def parse(string)
          @parser.parse_or_fail(string)
        end
        
        it "should parse a basic image" do
          parse("!image.jpg!").to_sexp.should ==
            [:image, {:src => "image.jpg"}, []]
        end
        
        it "should parse an image with alt text" do
          parse("!image.jpg(with alt text)!").to_sexp.should ==
            [:image, {:src => "image.jpg", :alt => "with alt text"}, []]
        end
        
        it "should parse an image with absolute URL" do
          parse("!http://example.com/i/image.jpg!").to_sexp.should ==
            [:image, {:src => "http://example.com/i/image.jpg"}, []]
        end
        
        it "should parse an image with absolute URL and target" do
          parse("!http://example.com/i/image.jpg#a1!").to_sexp.should ==
            [:image, {:src => "http://example.com/i/image.jpg#a1"}, []]
        end
        
        it "should not parse a non-image with bang inside" do
          lambda{ parse("!!!") }.should raise_error
        end
        
        it "should not parse a non-image with space inside" do
          lambda{ parse("! image!") }.should raise_error
        end
        
        it "should parse an image with a link" do
          parse("!image.jpg!:link").to_sexp.should ==
            [:link, {:href => "link"}, [[:image, {:src => "image.jpg"}, []]]]
          
        end
        
      end
    end
  end
end