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
      
      def block_element(element)
        p(element)
      end
      
      def p(element)
        @builder.p(element.contained_elements)
      end
      
      def strong(element)
        @builder.strong(super)
      end
      
    end
  end
end