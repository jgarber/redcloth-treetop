module RedCloth
  module Ast
    class ListItem
      
      def initialize(opts, inline)
        @opts, @inline = opts, inline
      end
      
      def to_sexp
        [:list_item, @opts, @inline.to_sexp]
      end
      
    end
  end
end