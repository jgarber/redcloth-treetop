module RedCloth
  module Ast
    class ListItem
      
      def initialize(opts, text)
        @opts, @text = opts, text
      end
      
      def to_sexp
        [:list_item, @opts, @text]
      end
      
    end
  end
end