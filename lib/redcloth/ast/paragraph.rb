module RedCloth
  module Ast
    class Paragraph
      
      def initialize(text, opts={})
        @text = text
        @opts = opts
      end
      
      def to_sexp
        [:paragraph, @opts, @text]
      end
      
    end
  end
end