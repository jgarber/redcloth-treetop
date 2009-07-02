require File.dirname(__FILE__) + "/spec_helper"
require 'redcloth'

describe RedCloth do
  
  def parse(string)
    RedCloth.new(string)
  end

  it 'should parse and transform to html' do
    parse("This is my paragraph").to_html.should == "<p>This is my paragraph</p>"
  end
  
end