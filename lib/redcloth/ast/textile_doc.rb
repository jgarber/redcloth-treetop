module RedCloth
  module Ast
    # Represents the root node of a parsed textile document.
    class TextileDoc
      attr_accessor :file
      
      def initialize(elements)
        @elements = elements
      end
      
      def to_sexp
        @elements.map {|e| e.to_sexp }
      end
      
    end
  end
end