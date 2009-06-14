require File.dirname(__FILE__) + "/../../spec_helper"
require 'redcloth/parser/attributes'

module RedCloth
  module Parser
    describe AttributesParser do
      before :each do
        @parser = AttributesParser.new
      end
  
      def parse(string)
        @parser.parse_or_fail(string)
      end
      
      it "should parse a class" do
        parse("(myclass)").to_opts.should == {:class => "myclass"}
      end
      
      it "should parse alignment" do
        parse("<").to_opts.should == {:align => "left"}
      end
      
      it "should parse class and alignment with class first" do
        parse("(myclass)<").to_opts.should == {:class => "myclass", :align => "left"}
        parse("(myclass)<>").to_opts.should == {:class => "myclass", :align => "justify"}
        parse("(myclass)>").to_opts.should == {:class => "myclass", :align => "right"}
        parse("(myclass))").to_opts.should == {:class => "myclass", :padding_right => 1}
        parse("(myclass)(").to_opts.should == {:class => "myclass", :padding_left => 1}
        parse("(myclass)()").to_opts.should == {:class => "myclass", :padding_left => 1, :padding_right => 1}
      end
      
      it "should parse class and alignment with alignment first" do
        parse("<(myclass)").to_opts.should == {:class => "myclass", :align => "left"}
        parse("<>(myclass)").to_opts.should == {:class => "myclass", :align => "justify"}
        parse(">(myclass)").to_opts.should == {:class => "myclass", :align => "right"}
        parse(")(myclass)").to_opts.should == {:class => "myclass", :padding_right => 1}
        parse("((myclass)").to_opts.should == {:class => "myclass", :padding_left => 1}
        parse("()(myclass)").to_opts.should == {:class => "myclass", :padding_left => 1, :padding_right => 1}
      end
      
      it "should parse id and alignment with id first" do
        parse("(#myid)<").to_opts.should == {:id => "myid", :align => "left"}
        parse("(#myid)<>").to_opts.should == {:id => "myid", :align => "justify"}
        parse("(#myid)>").to_opts.should == {:id => "myid", :align => "right"}
        parse("(#myid))").to_opts.should == {:id => "myid", :padding_right => 1}
        parse("(#myid)(").to_opts.should == {:id => "myid", :padding_left => 1}
        parse("(#myid)()").to_opts.should == {:id => "myid", :padding_left => 1, :padding_right => 1}
      end
      
      it "should parse id and alignment with alignment first" do
        parse("<(#myid)").to_opts.should == {:id => "myid", :align => "left"}
        parse("<>(#myid)").to_opts.should == {:id => "myid", :align => "justify"}
        parse(">(#myid)").to_opts.should == {:id => "myid", :align => "right"}
        parse(")(#myid)").to_opts.should == {:id => "myid", :padding_right => 1}
        parse("((#myid)").to_opts.should == {:id => "myid", :padding_left => 1}
        parse("()(#myid)").to_opts.should == {:id => "myid", :padding_left => 1, :padding_right => 1}
      end
      
      it "should parse aligns separated by class" do
        parse("<(myclass)>").to_opts.should == {:class => "myclass", :align => "left"}
        parse("((myclass))").to_opts.should == {:class => "myclass", :padding_left => 1, :padding_right => 1}
      end
      
      it "should gracefully accept multiple classes" do
        lambda { parse("(myclass)(otherclass)") }.should_not raise_error
      end
      
    end

  end
end