module RedCloth
  module Ast
    class List
      
      def initialize(opts, list_items)
        @opts, @list_items = opts, list_items
      end
      
      def to_sexp
        [:list, @opts, @list_items.map {|li| li.to_sexp }]
      end
      
    end
  end
end