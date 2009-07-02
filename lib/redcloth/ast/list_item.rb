module RedCloth
  module Ast
    class ListItem
      
      def initialize(opts, contained_elements)
        @opts, @contained_elements = opts, contained_elements
      end
      
      def to_sexp
        [:list_item, @opts, @contained_elements.map {|e| e.to_sexp }]
      end
      
    end
  end
end