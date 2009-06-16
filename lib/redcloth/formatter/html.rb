begin
  require 'builder'
rescue LoadError
  gem 'builder'
  require 'builder'
end

module RedCloth
  module Formatter
    class Html < Ast::Visitor
      
      def initialize(io, options={})
        @options = options
        @builder = create_builder(io)
      end
      
      def create_builder(io)
        Builder::XmlMarkup.new(:target => io, :indent => 0)
      end
      
      def visit_block_element(element)
        visit_paragraph(element)
      end
      
      def visit_paragraph(element)
        @builder.p(element.inline_contents)
      end
      
    end
  end
end