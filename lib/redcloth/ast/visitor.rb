module RedCloth
  module Ast
    class Visitor
      
      def visit_strong(element)
        element.inline_elements.map {|e| e.is_a?(String) ? e : e.accept(self) }
      end
      
    end
  end
end