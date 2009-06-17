module RedCloth
  module Ast
    class Visitor
      
      def strong(element)
        element.contained_elements.map {|e| e.is_a?(String) ? e : e.accept(self) }
      end
      
    end
  end
end