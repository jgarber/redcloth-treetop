module RedCloth
  module Ast
    class Inline
      
      def initialize(inline_elements)
        @inline_elements = inline_elements
      end
      
      def to_sexp
        @inline_elements.map {|e| e.to_sexp }
      end
      
    end
  end
end