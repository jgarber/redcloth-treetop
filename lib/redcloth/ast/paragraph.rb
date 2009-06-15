module RedCloth
  module Ast
    class Paragraph
      
      def initialize(opts, inline_contents)
        @opts, @inline_contents = opts, inline_contents
      end
      
      def to_sexp
        [:paragraph, @opts, @inline_contents.to_sexp]
      end
      
    end
  end
end