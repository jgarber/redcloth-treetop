begin
  require 'builder'
rescue LoadError
  gem 'builder'
  require 'builder'
end

module RedCloth
  module Formatter
    class Html < Ast::Visitor
      
      def initialize(textile_doc=nil, options={})
        @options = options
        format(textile_doc) if textile_doc
      end
      
      def format(textile_doc)
        textile_doc.accept(self)
      end
      
      def builder
        @builder ||= Builder::XmlMarkup.new(:indent => 0)
      end
      
      def block_element(element)
        p(element)
      end
      
      # FIXME: Yeah, these aren't DRY, but you know what they say about premature optimization
      def p(element)
        builder.p do
          accept_contents(element)
        end
      end
      
      def strong(element)
        builder.strong do
          accept_contents(element)
        end
      end
      
      def b(element)
        builder.b do
          accept_contents(element)
        end
      end
      
      private
      
      def accept_contents(element)
        element.contained_elements.each do |e|
          if e.is_a?(String)
            builder.text! e
          else
            e.accept(self)
          end
        end
      end
      
    end
  end
end

module RedCloth
  module Ast
    class TextileDoc
      def to_html
        RedCloth::Formatter::Html.new(self).builder.target!
      end
    end
  end
end