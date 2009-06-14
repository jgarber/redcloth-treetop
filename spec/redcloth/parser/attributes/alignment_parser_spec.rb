require File.dirname(__FILE__) + "/../../../spec_helper"
require 'redcloth/parser/attributes/alignment'

module RedCloth
  module Parser
    module Attributes
      describe Alignment do
        before :each do
          @parser = AlignmentParser.new
        end
        
        def parse(string)
          @parser.parse_or_fail(string)
        end
        
        it "should parse the left align option" do
          parse("<").to_opts.should == {:align => "left"}
        end
        
        it "should parse the right align option" do
          parse(">").to_opts.should == {:align => "right"}
        end
        
        it "should parse the justified align option" do
          parse("<>").to_opts.should == {:align => "justify"}
        end
        
        it "should parse the center align option" do
          parse("=").to_opts.should == {:align => "center"}
        end
        
        it "should gracefully accept the first of conflicting align options" do
          parse("><").to_opts.should == {:align => "right"}
          parse("<<").to_opts.should == {:align => "left"}
          parse(">>").to_opts.should == {:align => "right"}
          parse("><>").to_opts.should == {:align => "right"}
          parse("<<>").to_opts.should == {:align => "left"}
          parse("=<").to_opts.should == {:align => "center"}
          parse("<>=").to_opts.should == {:align => "justify"}
          parse("<>><").to_opts.should == {:align => "justify"}
        end
        
        it "should parse the pad left option" do
          parse("(").to_opts.should == {:padding_left => 1}
        end
        
        it "should parse the double pad left option" do
          parse("((").to_opts.should == {:padding_left => 2}
        end
        
        it "should parse the pad right option" do
          parse(")").to_opts.should == {:padding_right => 1}
        end
        
        it "should parse the double pad right option" do
          parse("))").to_opts.should == {:padding_right => 2}
        end
        
        it "should parse multiple pad left and right options" do
          parse("()").to_opts.should == {:padding_right => 1, :padding_left => 1}
          parse("(()").to_opts.should == {:padding_right => 1, :padding_left => 2}
          parse("())").to_opts.should == {:padding_right => 2, :padding_left => 1}
          parse("(())").to_opts.should == {:padding_right => 2, :padding_left => 2}
          parse("((()))").to_opts.should == {:padding_right => 3, :padding_left => 3}
          parse(")(").to_opts.should == {:padding_right => 1, :padding_left => 1}
          parse(")()").to_opts.should == {:padding_right => 2, :padding_left => 1}
          parse("()()").to_opts.should == {:padding_right => 2, :padding_left => 2}
        end
        
        it "should parse mixed padding and alignment options" do
          parse("<(").to_opts.should == {:align => "left", :padding_left => 1}
          parse("(<").to_opts.should == {:align => "left", :padding_left => 1}
          parse("(<)").to_opts.should == {:align => "left", :padding_left => 1, :padding_right => 1}
          parse(")=(").to_opts.should == {:align => "center", :padding_left => 1, :padding_right => 1}
        end
                
      end
    end
  end
end