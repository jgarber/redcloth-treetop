module RedCloth
  module Ast
    class Inline
      
      def initialize(inline_elements)
        @inline_elements = inline_elements
      end
      
      def to_sexp
        contents
      end
      
      def contents
        @inline_elements.inject([]) do |a, e|
          if e.is_a?(String)
            if a.last.is_a?(String)
              a.last << e
            else
              a << e
            end
          else
            a << e.to_sexp
          end
          a
        end
      end
      
    end
  end
end