module RedCloth
  module Ast
    class Paragraph
      attr_reader :inline_contents
      
      def initialize(opts, inline_contents)
        @opts, @inline_contents = opts, inline_contents
      end
      
      def to_sexp
        [:paragraph, @opts, @inline_contents.to_sexp]
      end
      
    end
  end
end