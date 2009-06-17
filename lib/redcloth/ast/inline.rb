module RedCloth
  module Ast
    class Inline
      
      def initialize(contained_elements)
        @contained_elements = contained_elements
      end
      
      def to_sexp
        contents_to_sexp
      end
      
      def contents_to_sexp
        if @contained_elements.is_a?(Inline)
          @contained_elements.to_sexp
        else
          @contained_elements.inject([]) do |a, e|
            if e.is_a?(String)
              if a.last.is_a?(String)
                a.last << e
              else
                a << e unless e.blank?
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
end