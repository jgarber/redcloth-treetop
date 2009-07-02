require "rubygems"
gem 'treetop', "> 1.2.5"
require "treetop"

require "redcloth/parser"
require "redcloth/ast"
require "redcloth/formatter/html"

module RedCloth
  # A convenience method for creating a new TextileDoc. See
  # RedCloth::TextileDoc.
  def self.new( string, &block )
    RedCloth::Parser::TextileDocParser.new.parse_or_fail( string, &block )
  end
  
end