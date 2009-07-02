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
        @builder.p do |p|
          accept_contents(element)
        end
      end
      
      def strong(element)
        @builder.strong do |p|
          accept_contents(element)
        end
      end
      
      private
      
      def accept_contents(element)
        element.contained_elements.each do |e|
          if e.is_a?(String)
            @builder.text! e
          else
            e.accept(self)
          end
        end
      end
      
      
    end
  end
end