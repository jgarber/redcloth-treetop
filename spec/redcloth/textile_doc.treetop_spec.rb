require File.dirname(__FILE__) + "/../spec_helper"

describe TextileDocParser do
  before :each do
    @parser = TextileDocParser.new
  end
  
  def parse(string)
    @parser.parse(string)
  end
  
  it 'should parse an implicit paragraph' do
    parse("This is my paragraph\n\n").should have_a_paragraph
    parse("This is my paragraph\n\n").to_html.should == "<p>This is my paragraph</p>"
  end
  
  it 'should parse an explicit paragraph' do
    parse("p. This is my paragraph\n\n").should have_a_paragraph
    parse("p. This is my paragraph\n\n").to_html.should == "<p>This is my paragraph</p>"
  end
  
  it 'should parse an explicit paragraph without double newline after' do
    parse("p. This is my paragraph").should have_a_paragraph
    parse("p. This is my paragraph").to_html.should == "<p>This is my paragraph</p>"
  end
  
  it "should parse a basic list" do
    parse("# one\n# two\n\n").should have_a_list
    parse("# one\n# two\n\n").to_html.should == "<ol><li>one</li><li>two</li></ol>"
  end

  it "should parse a basic list without double newline after" do
    parse("# one\n# two").should have_a_list
    parse("# one\n# two").to_html.should == "<ol><li>one</li><li>two</li></ol>"
  end
  
  it "should parse a nested list" do
    puts parse("# one\n## one.two\n\n").inspect
    # parse("# one\n## one.two\n\n").should have_a_list("one.two") do |list|
    #   list.should have_an_li
    # end
    parse("# one\n## one.two\n\n").to_html.should == "<ol><li>one</li><ol><li>one.two</li></ol></ol>"
  end
  
  # TODO: abstract these later
  def have_a_list(options={}, &block)
    HaveList.new(options, &block)
  end
  
  def have_a_paragraph(options={}, &block)
    HaveParagraph.new(options, &block)
  end

  def have_an_li(options={}, &block)
    HaveLi.new(options, &block)
  end
end

class HaveSyntaxNode
  def initialize(options={}, &block)
    @options  = options.is_a?(String) ? {:content => options} : options
    @block    = block
  end
  
  def matches?(parse_tree, &block)
    @block ||= block
    
    if respond_to?(:mod)
      matched = parse_tree.find_recursively_having_extension_module(mod)
    else
      matched = parse_tree.find_recursively_having_class_and_content(class_name, @options[:content])
    end
    
    !parse_tree.nil? && matched && (!@block || @block.call(matched))
  end
  
  def failure_message
    message = "could not find SyntaxNode of class #{class_name}"
    message << %Q{ and content "#{@options[:content]}"} if @options[:content]
  end
  
end

class HaveList < HaveSyntaxNode
  def class_name
    TextileDoc::List
  end
  # def mod
  #   TextileDoc::List1
  # end
end

class HaveParagraph < HaveSyntaxNode
  def mod
    TextileDoc::Paragraph1
  end
end

class HaveLi < HaveSyntaxNode
  def class_name
    TextileDoc::ListItem
  end
  # def mod
  #   TextileDoc::Li0
  # end
end

class Treetop::Runtime::SyntaxNode
  def find_recursively_having_class_and_content(class_name, content=nil)
    if content
      return self if self.is_a?(class_name) && self.respond_to?(:content) && self.content == content
      elements.find {|e| e.is_a?(class_name) && self.respond_to?(:content) && self.content == content}
    else
      return self if self.is_a?(class_name)
      elements.find {|e| e.is_a?(class_name)}
    end
  end

  def find_recursively_having_extension_module(extension_module)
    return self if self.has_extension_module?(extension_module)
    elements.find {|e| e.has_extension_module?(extension_module)}
  end
  
  def has_extension_module?(extension_module)
    self.extension_modules.include?(extension_module)
  end
end