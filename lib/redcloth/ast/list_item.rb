module RedCloth
  module Ast
    class ListItem
      attr_reader :contained_elements
      attr_reader :opts
      
      def initialize(opts, contained_elements)
        @opts, @contained_elements = opts, contained_elements
      end
      
      def to_sexp
        [:list_item, @opts, @contained_elements.map {|e| e.to_sexp }]
      end
      
      def accept(visitor)
        visitor.send("list_item", self)
      end
      
    end
  end
end