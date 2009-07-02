module RedCloth
  module Ast
    class Visitor
      
      def p(element)
        accept_contents(element)
      end
      
      def strong(element)
        accept_contents(element)
      end

      def bold(element)
        accept_contents(element)
      end
      
      def accept_contents(element)
        element.contained_elements.map {|e| e.is_a?(String) ? e : e.accept(self) }.join
      end
      
    end
  end
end