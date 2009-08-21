module RedCloth
  module Ast
    class List
      attr_reader :opts

      def initialize(opts, list_items)
        @opts, @list_items = opts, list_items
      end
      
      def <<(list_item)
        @list_items << list_item
      end
      
      def to_sexp
        [:list, @opts, @list_items.map {|li| li.to_sexp }]
      end
      
      def contained_elements
        @list_items
      end
      
    end
  end
end