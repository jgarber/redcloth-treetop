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
  end
  
  it 'should parse an explicit paragraph' do
    parse("p. This is my paragraph\n\n").should have_a_paragraph
  end
  
  it 'should parse an explicit paragraph without double newline after' do
    parse("p. This is my paragraph").should have_a_paragraph
  end
  
  it "should parse a basic list" do
    parse("# one\n# two\n\n").should have_a_list
  end

  it "should parse a basic list without double newline after" do
    parse("# one\n# two\n\n").should have_a_list
  end
  
  it "should parse a nested list" do
    parse("# one\n## one.two\n\n").should have_a_list do |list|
      list.should have_an_li
    end
  end
  
  def have_a_list(&block)
    HaveList.new(&block)
  end
  
  def have_a_paragraph(&block)
    HaveParagraph.new(&block)
  end

  def have_an_li(&block)
    HaveLi.new(&block)
  end
end

class HaveSyntaxNode
  def initialize(&block)
    @block    = block
  end
  
  def matches?(parse_tree, &block)
    @block ||= block
    
    matched = parse_tree.find_recursively_having_extension_module(mod)
    
    !parse_tree.nil? && matched && (!@block || @block.call(matched))
  end
end

class HaveList < HaveSyntaxNode
  def mod
    TextileDoc::List1
  end
end

class HaveParagraph < HaveSyntaxNode
  def mod
    TextileDoc::Paragraph1
  end
end

class HaveLi < HaveSyntaxNode
  def mod
    TextileDoc::Li0
  end
end

class Treetop::Runtime::SyntaxNode
  def find_recursively_having_extension_module(extension_module)
    return self if self.has_extension_module?(extension_module)
    elements.find {|e| e.has_extension_module?(extension_module)}
  end
  
  def has_extension_module?(extension_module)
    self.extension_modules.include?(extension_module)
  end
end