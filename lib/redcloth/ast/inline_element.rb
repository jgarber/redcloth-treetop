module RedCloth
  module Ast
    class InlineElement < Inline
      
      def initialize(opts={}, contents=nil)
        @opts = opts
        @inline_elements = contents
      end
      
      def to_sexp
        [@opts.delete(:type), @opts, contents]
      end
      
    end
  end
end