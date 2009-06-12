module RedCloth
  module Ast
    # Represents the root node of a parsed textile document.
    class TextileDoc
      
      def initialize(block_elements)
        @block_elements = block_elements
      end
      
      def to_sexp
        @block_elements.map {|e| e.to_sexp }
      end
      
    end
  end
end